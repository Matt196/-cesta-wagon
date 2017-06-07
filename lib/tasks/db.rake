# pg_dump -F c -v -U postgres -h localhost <database_name> -f /tmp/<filename>.psql
namespace :db do
  desc "Dump db to db/dump.psql"
  task dump: :environment do
    sh "pg_dump -F c -v -U postgres -h localhost _cesta-wagon_development -f db/dump.psql"
  end

  desc "Import db dump"
  task import: :environment do
    sh "pg_restore -c -C -F c -v -U postgres db/dump.psql"
  end
end
