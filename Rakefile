require "bundler/gem_tasks"

task :default

if RUBY_PLATFORM =~ /java/
  require 'maven/ruby/maven'
  require 'jar_installer'

  desc 'setup jar dependencies to be used for "testing" and generates lib/example_jars.rb'
  task :setup do
      Jars::JarInstaller.install_jars
  end

  desc 'compile src/main/java/** into lib/example.jar'
  task :jar do
      Maven::Ruby::Maven.new.exec 'prepare-package'
  end

end
