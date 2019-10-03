Jsonapi::Swagger.config do |config|
  config.use_rswag = false
  config.version = '2.0'
  config.info = { title: 'ECHO Open Plant API', version: 'V1'}
  config.file_path = 'v1/swagger.json'
end