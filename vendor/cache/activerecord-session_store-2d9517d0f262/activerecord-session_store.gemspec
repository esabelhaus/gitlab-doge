# -*- encoding: utf-8 -*-
# stub: activerecord-session_store 0.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "activerecord-session_store"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["David Heinemeier Hansson"]
  s.date = "2015-02-20"
  s.email = "david@loudthinking.com"
  s.extra_rdoc_files = ["README.md"]
  s.files = ["README.md", "lib/action_dispatch", "lib/action_dispatch/session", "lib/action_dispatch/session/active_record_store.rb", "lib/active_record", "lib/active_record/session_store", "lib/active_record/session_store.rb", "lib/active_record/session_store/extension", "lib/active_record/session_store/extension/logger_silencer.rb", "lib/active_record/session_store/railtie.rb", "lib/active_record/session_store/session.rb", "lib/active_record/session_store/sql_bypass.rb", "lib/activerecord", "lib/activerecord/session_store.rb", "lib/generators", "lib/generators/active_record", "lib/generators/active_record/session_migration_generator.rb", "lib/generators/active_record/templates", "lib/generators/active_record/templates/migration.rb", "lib/tasks", "lib/tasks/database.rake"]
  s.homepage = "https://github.com/rails/activerecord-session_store"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--main", "README.md"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.rubygems_version = "2.2.2"
  s.summary = "An Action Dispatch session store backed by an Active Record class."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, ["< 5", ">= 4.0.0"])
      s.add_runtime_dependency(%q<actionpack>, ["< 5", ">= 4.0.0"])
      s.add_runtime_dependency(%q<railties>, ["< 5", ">= 4.0.0"])
      s.add_development_dependency(%q<sqlite3>, [">= 0"])
      s.add_development_dependency(%q<appraisal>, [">= 0"])
    else
      s.add_dependency(%q<activerecord>, ["< 5", ">= 4.0.0"])
      s.add_dependency(%q<actionpack>, ["< 5", ">= 4.0.0"])
      s.add_dependency(%q<railties>, ["< 5", ">= 4.0.0"])
      s.add_dependency(%q<sqlite3>, [">= 0"])
      s.add_dependency(%q<appraisal>, [">= 0"])
    end
  else
    s.add_dependency(%q<activerecord>, ["< 5", ">= 4.0.0"])
    s.add_dependency(%q<actionpack>, ["< 5", ">= 4.0.0"])
    s.add_dependency(%q<railties>, ["< 5", ">= 4.0.0"])
    s.add_dependency(%q<sqlite3>, [">= 0"])
    s.add_dependency(%q<appraisal>, [">= 0"])
  end
end
