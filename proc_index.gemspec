# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'proc_index/version'

Gem::Specification.new do |gem|
  gem.name          = "proc_index"
  gem.version       = ProcIndex::VERSION
  gem.summary       = "Process table ORM"
  gem.description   = "Map and search all your processes."
  gem.license       = "MIT"
  gem.authors       = ["Alex Manelis"]
  gem.email         = "amanelis@gmail.com"
  gem.homepage      = "https://rubygems.org/gems/proc_index"

  gem.files         = `git ls-files`.split($/)

  `git submodule --quiet foreach --recursive pwd`.split($/).each do |submodule|
    submodule.sub!("#{Dir.pwd}/",'')

    Dir.chdir(submodule) do
      `git ls-files`.split($/).map do |subpath|
        gem.files << File.join(submodule,subpath)
      end
    end
  end
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'awesome_print', '1.6.1'
  gem.add_dependency 'fuzzy_match', '2.1.0'
  gem.add_runtime_dependency 'hashie', '~> 3.4', '>= 3.4.3'
  gem.add_development_dependency 'pry', '~> 0.10.3'

  gem.add_development_dependency 'bundler', '~> 1.10'
  gem.add_development_dependency 'rake', '~> 10.0'
  gem.add_development_dependency 'rdoc', '~> 4.0'
  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
end
