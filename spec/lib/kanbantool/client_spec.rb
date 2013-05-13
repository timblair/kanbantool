require (File.expand_path('./../../../spec_helper', __FILE__))

describe KanbanTool::Client do

  let(:client) { KanbanTool::Client.new("test", "123456789ABC") }

  after do
    VCR.eject_cassette
  end

  describe "#boards" do
    before do
      VCR.insert_cassette "boards"
    end

    subject { client.boards }

    it "returns an array" do
      subject.must_be_instance_of(Array)
    end

    it "returns an array of boards" do
      subject.each { |b| b.must_be_instance_of(KanbanTool::Board) }
    end

    it "populates all board objects" do
      subject.each { |b| b.id.wont_be_nil }
    end
  end

  describe "#tasks" do
    before do
      VCR.insert_cassette "tasks"
    end

    subject { client.tasks(12345) }

    it "returns an array" do
      subject.must_be_instance_of(Array)
    end

    it "returns an array of tasks" do
      subject.each { |b| b.must_be_instance_of(KanbanTool::Task) }
    end

    it "populates all task objects" do
      subject.each { |b| b.id.wont_be_nil }
    end
  end

end
