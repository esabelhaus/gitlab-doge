require 'sinatra/base'

class FakeGitlab < Sinatra::Base
  get '/projects/:id/repository/blobs/*' do
    puts params.to_yaml
    if params[:id] == 2
      content_type :json
      status 404
      "404 File Not Found"
    else
      json_response 200, params[:filepath]
    end
  end

  private

  def json_response(response_code, file_path)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_path).read
  end
end