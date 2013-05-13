module KanbanTool
  class Task

    FIELDS = %w{ id name description created_at updated_at archived_at assigned_user }
    FIELDS.each { |f| attr_reader f.to_sym }

    def self.create_from_hash(hash)
      task = self.new
      task.load!(hash)
      task
    end

    def load!(hash)
      FIELDS.each { |f| instance_variable_set("@#{f}".to_sym, hash[f]) }
    end

  end
end
