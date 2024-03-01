require 'net/http'
require 'json'

class ModerationService
  def self.predict(text)
    uri = URI.parse("https://moderation.logora.fr/predict")
    uri.query = URI.encode_www_form(text: text)
  
    response = Net::HTTP.get_response(uri)
  
    # Supposons que `response_body` contient la réponse JSON de l'API de modération
    response_body = JSON.parse(response.body, symbolize_names: true)
    prediction = response_body[:is_accepted] || false
  
    # Retourner le résultat sous forme de hash pour une utilisation facile
    { is_accepted: prediction }
  end

  def self.score(text)
    uri = URI.parse("https://moderation.logora.fr/score")
    uri.query = URI.encode_www_form(text: text)

    response = Net::HTTP.get_response(uri)

    # Supposons que `response_body` contient la réponse JSON de l'API de modération
    response_body = JSON.parse(response.body, symbolize_names: true)
    score = response_body[:score]

    # Vous pouvez ajouter d'autres logiques liées au score ici

    # Retourner le résultat sous forme de hash pour une utilisation facile
    { score: score }
  end
end
