require "helper"
require "fluent/plugin/filter_flatten_types.rb"

class FlattenTypesFilterTest < Test::Unit::TestCase
  setup do
    Fluent::Test.setup
  end

  test "failure" do
    flunk
  end

  private

  def create_driver(conf)
    Fluent::Test::Driver::Filter.new(Fluent::Plugin::FlattenTypesFilter).configure(conf)
  end
end
