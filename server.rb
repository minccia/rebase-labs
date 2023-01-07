require 'sinatra'
require 'rack/handler/puma'
require 'json'
require 'sidekiq'

Dir[File.join(__dir__, 'app/**', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file }

set :public_folder, 'public'

use ApiV1Controller

get '/tests' do
  send_file File.join(settings.public_folder, 'views/index.html')
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)