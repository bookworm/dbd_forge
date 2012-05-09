MongoMapper.connection = Mongo::Connection.new('localhost', nil, :logger => logger)

case Padrino.env
  when :development then MongoMapper.database = 'forge_development'
  when :production  then MongoMapper.database = 'forge_production'
  when :test        then MongoMapper.database = 'forge_test'
end
