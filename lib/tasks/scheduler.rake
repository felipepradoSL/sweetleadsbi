task :atualizar => :environment do
  Setting.atualizar
end

task :report => :environment do
  Setting.report
end

task :atualizar_jwt => :environment do
  Setting.atualizar_jwt
end