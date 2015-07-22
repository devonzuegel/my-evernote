require 'rails_helper'

RSpec.describe "notes/new", type: :view do
  before(:each) do
    assign(:note, Note.new(
      :guid => "MyString",
      :title => "MyString",
      :content => "MyText",
      :active => false,
      :notebook_guid => "MyString",
      :author => "MyString",
      :notebook => nil
    ))
  end

  it "renders new note form" do
    render

    assert_select "form[action=?][method=?]", notes_path, "post" do

      assert_select "input#note_guid[name=?]", "note[guid]"

      assert_select "input#note_title[name=?]", "note[title]"

      assert_select "textarea#note_content[name=?]", "note[content]"

      assert_select "input#note_active[name=?]", "note[active]"

      assert_select "input#note_notebook_guid[name=?]", "note[notebook_guid]"

      assert_select "input#note_author[name=?]", "note[author]"

      assert_select "input#note_notebook_id[name=?]", "note[notebook_id]"
    end
  end
end
