require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/clean'
require 'fileutils'
include FileUtils

###
### cleanup tasks
###

CLOBBER.include( 'pkg', 'doc/api', 'lib/version.rb' )

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

# Try to load the version number -- it's okay if it's not available

begin
  require 'optimalbot'
  require 'lib/version.rb'
rescue Exception
  class OptimalBot; end
end

desc "Appends the value in VERSION to lib/version.rb"
task :version do
  v = ENV['VERSION']
  raise "provide a VERSION via the environment variable" unless v
  sh %{echo 'class OptimalBot < Bot; VERSION = "#{v}"; end' >> lib/version.rb}
end

begin
  require 'rubygems'
  require 'rake/gempackagetask'
rescue Exception
  nil
end

if defined?( Gem ) && OptimalBot.const_defined?( 'VERSION' )
  task :gem => [:clean, :test]

  PKG_FILES = FileList[
    'lib/**/*',
    'test/**/*',
    'Rakefile',
    'README',
    'LICENSE',
    'COPYING']

  spec = Gem::Specification.new do |s|
    s.name = 'optimalbot'
    s.version = OptimalBot::VERSION
    s.summary = 'OptimalBot (plays Footsteps) for Vying Games'
    s.description = 'Vying is a game library.'
    s.homepage = 'http://vying.org/dev/public'
    s.rubyforge_project = 'Silence stupid WARNINGS'
    s.has_rdoc = true
    s.files = PKG_FILES.to_a
    #s.add_dependency "vying"
    s.author = 'Eric K Idema and Magnus Javerberg'
    s.email = 'eki@vying.org'
  end

  package_task = Rake::GemPackageTask.new( spec ) do |pkg|
    pkg.need_tar_gz = true
    pkg.need_zip = true
  end
end

