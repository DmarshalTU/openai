require "http/client"
require "./model"

module OpenAI
  class OpenAIError < Exception; end
  class AuthenticationError < OpenAIError; end
  class RateLimitError < OpenAIError; end

  class Configuration
    property base_url : String = "https://api.openai.com/v1/"
    property timeout : Int32 = 30
  end

  class Client
    BASE_URL = "https://api.openai.com/v1/"

    def initialize(@api_key : String)
    end

    def list_models
      headers = HTTP::Headers{
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{@api_key}"
      }
    
      response = HTTP::Client.get(BASE_URL + "engines", headers: headers)
      raw_json = response.body
      puts raw_json
      models_json = JSON.parse(raw_json)["data"].as_a
      models = models_json.map do |model_json|
        Model.from_json(model_json.to_json)
      end
      models
    end

    def retrieve_model(model_id : String)
      response = get("#{BASE_URL}engines/#{model_id}")
      Model.from_json(response.body)
    end

    def create_chat_completion(messages : Array(Hash(String, String)), model : String, max_tokens : Int32)
      url = "#{BASE_URL}chat/completions"
    
      body = {
        model: model,
        messages: messages,
        max_tokens: max_tokens
      }.to_json
    
      response = HTTP::Client.post(url, headers: build_headers, body: body)
    
      completion_response = handle_response(response)
      completion_text = completion_response["choices"][0]["message"]["content"]
      completion_id = completion_response["id"]
    
      { text: completion_text, id: completion_id }
    end

    def create_image_completion(model : String, prompt : String, size : String, quality : String, n : Int32)
      url = "#{BASE_URL}/images/generations"
  
      body = {
        model: model,
        prompt: prompt,
        size: size,
        quality: quality,
        n: n
      }.to_json
  
      response = HTTP::Client.post(url, headers: build_headers, body: body)
  
      # Handle the response
      if response.status_code == 200
        JSON.parse(response.body)
      else
        raise OpenAIError.new("Error: #{response.status_code} - #{response.body}")
      end
    end

    private def get(url : String, headers : HTTP::Headers? = nil)
      HTTP::Client.get(url, headers: build_headers(headers))
    end

    private def build_headers(extra_headers : HTTP::Headers? = nil)
      headers = HTTP::Headers{
        "Authorization" => "Bearer #{@api_key}",
        "Content-Type"  => "application/json"
      }
      extra_headers.try &.each do |key, value|
        headers.add(key, value)
      end
      headers
    end

    private def handle_response(response : HTTP::Client::Response)
      if response.success?
        JSON.parse(response.body)
      else
        raise "Error: #{response.status_code} - #{response.body}"
      end
    end
  end
end
