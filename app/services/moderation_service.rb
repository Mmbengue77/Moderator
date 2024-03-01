class ModerationService
    require 'net/http'
    require 'uri'
    require 'json'
  
    def self.check(text)
      uri = URI.parse("https://moderation.logora.fr/predict")
      request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
      request.body = {text: text}.to_json
  
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.request(request)
      end
  
      JSON.parse(response.body, symbolize_names: true)
    end
  end