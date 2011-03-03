class IsGraffitiableMigrationGenerator < Rails::Generator::Base 
  def manifest 
    record do |m| 
      m.migration_template 'migration.rb', 'db/migrate', :migration_file_name => 'is_graffitiable_migration'
    end 
  end
end
