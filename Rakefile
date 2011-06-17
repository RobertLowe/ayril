require 'rake/clean'
require 'rake/testtask'
require 'fileutils'
require 'date'

require 'lib/ayril/version.rb'

# task :default => :test
# task :spec => :test

# PACKAGING ============================================================

if defined?(Gem)
  # Load the gemspec using the same limitations as github
  def spec
    require 'rubygems' unless defined? Gem::Specification
    @spec ||= eval(File.read('ayril.gemspec'))
  end

  def package(ext='')
    "pkg/ayril-#{spec.version}" + ext
  end

  desc 'Build packages'
  task :package => %w[.gem].map {|e| package(e)}

  desc 'Build and install as local gem'
  task :install => package('.gem') do
    `gem install #{package('.gem')}`
  end

  directory 'pkg/'
  CLOBBER.include('pkg')

  file package('.gem') => %w[pkg/ ayril.gemspec] + spec.files do |f|
    `gem build ayril.gemspec`
    mv File.basename(f.name), f.name
  end

end