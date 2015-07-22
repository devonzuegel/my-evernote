require 'rails_helper'

RSpec.describe "notes/index", type: :view do
  before(:each) do
    assign(:notes, [
      Note.create!(
        :guid => "Guid",
        :title => "Title",
        :content => "MyText",
        :active => false,
        :notebook_guid => "Notebook Guid",
        :author => "Author",
        :notebook => nil
      ),
      Note.create!(
        :guid => "Guid",
        :title => "Title",
        :content => "MyText",
        :active => false,
        :notebook_guid => "Notebook Guid",
        :author => "Author",
        :notebook => nil
      )
    ])
  end

  it "renders a list of notes" do
    render
    assert_select "tr>td", :text => "Guid".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Notebook Guid".to_s, :count => 2
    assert_select "tr>td", :text => "Author".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
