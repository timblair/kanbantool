require "httparty"
require "json"

module KanbanTool
  class Client
    include HTTParty

    attr_accessor :domain, :token

    def initialize(domain, token)
      @domain = domain
      @token  = token
    end

    def boards
      get("boards")
    end

    def board(board_id)
      get("boards/#{board_id}")
    end

    def users(board_id)
      get("boards/#{board_id}/users")
    end

    def tasks(board_id)
      get("boards/#{board_id}/tasks")
    end

    def activity(board_id)
      get("boards/#{board_id}/changelog")
    end

    def api_url
      "https://#{domain}.#{KanbanTool::API_DOMAIN}#{KanbanTool::API_PATH}"
    end

    def url_for(path)
      "#{api_url}#{path}.json"
    end

    def headers
      { "X-KanbanToolToken" => token }
    end

    def params
      { :headers => headers }
    end

    def get(path)
      r = HTTParty.get url_for(path), params
      raise "Error: #{url_for(path)} => #{r.inspect}" if r.code != 200
      return JSON.parse(r.body)
    end

  end
end
