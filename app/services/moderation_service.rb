class ModerationService
  def self.check(text)
    uri = URI.parse("https://moderation.logora.fr/predict")
    request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    request.body = { text: text }.to_json

    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end

    # Supposons que `response_body` contient la réponse JSON de l'API de modération
    response_body = JSON.parse(response.body, symbolize_names: true)
    prediction = response_body[:prediction]["0"]

    # Définissez votre seuil de rejet ici
    rejection_threshold = 0.5

    # La logique pour déterminer si le contenu est accepté ou non
    is_accepted = prediction <= rejection_threshold

    # Retourner le résultat sous forme de hash pour une utilisation facile
    { is_accepted: is_accepted }
  end
end
