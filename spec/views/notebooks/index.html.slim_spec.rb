require 'rails_helper'

RSpec.describe "notebooks/index", type: :view do
  before(:each) do
    assign(:notebooks, [
      Notebook.create!(
        :guid => "Guid",
        :name => "Name",
        :user => nil
      ),
      Notebook.create!(
        :guid => "Guid",
        :name => "Name",
        :user => nil
      )
    ])
  end

  it "renders a list of notebooks" do
    render
    assert_select "tr>td", :text => "Guid".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
