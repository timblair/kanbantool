require(File.expand_path("../../lib/kanbantool", __FILE__))

require "minitest/autorun"
require "webmock/minitest"
require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.hook_into :webmock
end
