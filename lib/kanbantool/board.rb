module KanbanTool
  class Board

    class Stage < Struct.new(:id, :name, :description, :position); end

    FIELDS = %w{ id name description created_at version last_activity_on }
    FIELDS.each { |f| attr_reader f.to_sym }

    attr_reader :stages

    def self.create_from_hash(hash)
      board = self.new
      board.load!(hash)
      board.load_stages!(hash["workflow_stages"]) unless hash["workflow_stages"].nil?
      board
    end

    def load!(hash)
      FIELDS.each { |f| instance_variable_set("@#{f}".to_sym, hash[f]) }
    end

    def load_stages!(array)
      @stages = []
      array.each do |s|
        @stages << Stage.new( s["id"], s["name"], s["description"], s["position"] ).freeze
      end
    end

    def stage(id)
      stages.first { |s| s.id == id }
    end

  end
end
