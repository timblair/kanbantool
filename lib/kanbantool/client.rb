require "httparty"
require "json"

module KanbanTool
  class Client
    include HTTParty

    attr_reader :domain, :token

    def initialize(domain, token)
      @domain = domain
      @token  = token
    end

    def boards
      get("boards").collect do |board|
        Board.create_from_hash board
      end
    end

    def board(board_id)
      Board.create_from_hash get("boards/#{board_id}")
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
      unwrap JSON.parse(r.body)
    end

    def unwrap(data)
      if data.is_a? Array
        data.collect { |item| unwrap item }
      else
        keys = %w{ board task shared_item_user }
        key = keys.find { |key| !data[key].nil? }
        data.include?(key) ? data[key] : data
      end
    end

  end
end
