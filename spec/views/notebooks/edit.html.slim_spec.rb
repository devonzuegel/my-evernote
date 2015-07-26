require 'rails_helper'

RSpec.describe "notebooks/edit", type: :view do
  before(:each) do
    @notebook = assign(:notebook, Notebook.create!(
      :guid => "MyString",
      :name => "MyString",
      :user => nil
    ))
  end

  it "renders the edit notebook form" do
    render

    assert_select "form[action=?][method=?]", notebook_path(@notebook), "post" do
      assert_select "input#notebook_guid[name=?]", "notebook[guid]"
      assert_select "input#notebook_name[name=?]", "notebook[name]"
      assert_select "select#notebook_user_id[name=?]", "notebook[user_id]"
    end
  end
end
