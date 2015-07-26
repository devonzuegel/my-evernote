require 'rails_helper'

RSpec.describe "notebooks/index", type: :view do
  before(:each) do
    2.times { create(:notebook) }
    @notebooks = Notebook.all
  end

  it "renders a list of notebooks" do
    render
    @notebooks.each do |n|
      assert_select "tr>td", text: n.guid.to_s, count: 1
      assert_select "tr>td", text: n.name.to_s, count: 1
      assert_select "tr>td", text: nil.to_s, count: 2
    end
  end
end
