require (File.expand_path('./../../../spec_helper', __FILE__))

describe KanbanTool::Board do

  let(:board)        { KanbanTool::Board.new }
  let(:board_params) { KanbanTool::Board::FIELDS.inject({}) { |h,f| h[f] = f*3; h } }
  let(:board_hash)   { board_params }
  let(:stage)        { {"id" => "1", "name" => "foo", "description" => "bar", "position" => 1} }
  let(:stages)       { [stage, stage, stage] }

  describe "#load!" do
    let(:extra_hash_param) { board_hash.merge({ "foo" => "bar" }) }

    it "loads the hash" do
      board.load!(board_hash)
      board_hash.each { |k,v| board.send("#{k}".to_sym).must_equal v }
    end

    it "doesn't import unlisted fields" do
      board.load!(extra_hash_param)
      board.instance_variable_get(:@foo).must_be_nil
    end

    it "overwrites existing values" do
      board.instance_variable_set(:@id, "x")
      board.load!(board_hash)
      board.id.must_equal board_hash["id"]
    end
  end

  describe "#load_stages!" do
    before do
      board.load_stages!(stages)
    end

    it "loads all stages" do
      board.stages.size.must_equal stages.size
    end

    it "creates Stage objects" do
      board.stages.each { |s| s.must_be_instance_of KanbanTool::Board::Stage }
    end

    it "freezes all stages" do
      board.stages.first.must_be :frozen?
    end
  end

  describe ".create_from_hash" do
    let(:board) { KanbanTool::Board.create_from_hash(board_hash) }

    context "without stages" do
      it "returns a board instance" do
        board.must_be_instance_of KanbanTool::Board
      end

      it "correctly loads the board data" do
        board_hash.each { |k,v| board.send("#{k}".to_sym).must_equal v }
      end

      it "handles empty stages" do
        board.stages.must_be_nil
      end
    end

    context "with stages" do
      let(:board_hash) { board_params.merge({"workflow_stages" => stages}) }

      it "populates stages" do
        board.stages.size.must_equal stages.size
      end
    end
  end
end
