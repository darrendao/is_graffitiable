# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{is_graffitiable}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Darren Dao"]
  s.date = %q{2011-02-24}
  s.email = %q{ddao@gmail.com}
  s.files = ["README.rdoc", "VERSION.yml", "generators/is_graffitiable_migration", "generators/is_graffitiable_migration/is_graffitiable_migration_generator.rb", "generators/is_graffitiable_migration/templates", "generators/is_graffitiable_migration/templates/migration.rb", "lib/is_graffitiable.rb", "lib/graffiti.rb", "test"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/giraffesoft/is_graffitiable}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{tagging that allow you to use key:value tags}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
