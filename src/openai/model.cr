require "json"

module OpenAI
  class Model
    include JSON::Serializable

    @[JSON::Field(name: "id")]
    property id : String

    @[JSON::Field(name: "object")]
    property object : String

    @[JSON::Field(name: "created")]
    property created : Int32?

    @[JSON::Field(name: "name")]
    property name : String?

    @[JSON::Field(name: "description")]
    property description : String?

    @[JSON::Field(name: "status")]
    property status : String?

    @[JSON::Field(name: "usage")]
    property usage : Usage?

    class Usage
      include JSON::Serializable

      @[JSON::Field(name: "total_tokens")]
      property total_tokens : Int32
    end

    def to_s
      "Model: #{@name} (ID: #{@id}, Status: #{@status})"
    end
  end

  class Message
    include JSON::Serializable

    @[JSON::Field(name: "role")]
    property role : String

    @[JSON::Field(name: "content")]
    property content : String

    def initialize(@role : String, @content : String)
    end

    def to_hash
      { "role" => @role, "content" => @content }
    end
  end
end