require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/clean'
require 'fileutils'
include FileUtils

###
### cleanup tasks
###

CLEAN.include( 'lib/version.rb' )
CLOBBER.include( 'pkg', 'doc/api' )

###
### test task
###

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
end

###
### rdoc task
###

task :rdoc do
  cp "lib/bots/optimalbot/footsteps.sql", "doc/api/footsteps.sql"
end

Rake::RDocTask.new do |rd|
  rd.main = "README"
  rd.rdoc_dir = "doc/api"
  rd.rdoc_files.include( "README", "LICENSE", "COPYING",
                         "doc/*.txt", "lib/**/*.rb" )
end

###
###  RubyGems related tasks follow:
###

wd = Dir.pwd
wd =~ /\/v([\d\.]*)$/
pkg_version = $1

desc "Appends the tagged version to lib/version.rb"
task :version do
  sh %{echo 'class OptimalBot < Bot; VERSION = "#{pkg_version}"; end' >> lib/version.rb}
end

begin
  require 'rubygems'
  require 'rake/gempackagetask'
rescue Exception
  nil
end

if defined?( Gem ) && pkg_version
  task :gem => [:clean, :test, :version]

  PKG_FILES = FileList[
    'lib/**/*',
    'test/**/*',
    'Rakefile',
    'README',
    'LICENSE',
    'COPYING']

  spec = Gem::Specification.new do |s|
    s.name = 'optimalbot'
    s.version = pkg_version
    s.summary = 'OptimalBot - A Footsteps Playing Bot for Vying Games'
    s.description = 'Vying is a game library.'
    s.files = PKG_FILES.to_a
    #s.add_dependency "sqlite-ruby", ">= 2.2.3"
    #s.add_dependency "sqlite3-ruby"
    s.add_dependency "vying"
    s.require_paths << "ext"
    s.author = 'Eric K Idema and Magnus Javerberg'
    s.email = 'eki@vying.org'
  end

  package_task = Rake::GemPackageTask.new( spec ) do |pkg|
    pkg.need_tar_gz = true
    pkg.need_zip = true
  end
end

