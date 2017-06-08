namespace :db do
  desc "Export a database dump"
  task :export => :environment do
    sh "pg_dump -Fc --no-acl --no-owner _cesta-wagon_development > db/cesta.dump"
  end

  desc "Import psql dump"
  task :import => :environment do
    sh "pg_restore --clean --no-acl --no-owner -d _cesta-wagon_development db/cesta.dump"
  end
end
