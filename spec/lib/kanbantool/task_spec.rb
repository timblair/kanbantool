require (File.expand_path('./../../../spec_helper', __FILE__))

describe KanbanTool::Task do

  let(:task)      { KanbanTool::Task.new }
  let(:task_hash) { KanbanTool::Task::FIELDS.inject({}) { |h,f| h[f] = f*3; h } }

  describe "#load!" do
    let(:extra_hash_param) { task_hash.merge({ "foo" => "bar" }) }

    it "loads the hash" do
      task.load!(task_hash)
      task_hash.each { |k,v| task.send("#{k}".to_sym).must_equal v }
    end

    it "doesn't import unlisted fields" do
      task.load!(extra_hash_param)
      task.instance_variable_get(:@foo).must_be_nil
    end

    it "overwrites existing values" do
      task.instance_variable_set(:@id, "x")
      task.load!(task_hash)
      task.id.must_equal task_hash["id"]
    end
  end

  describe ".create_from_hash" do
    let(:task) { KanbanTool::Task.create_from_hash(task_hash) }

    it "returns a task instance" do
      task.must_be_instance_of KanbanTool::Task
    end

    it "correctly loads the task data" do
      task_hash.each { |k,v| task.send("#{k}".to_sym).must_equal v }
    end
  end
end
