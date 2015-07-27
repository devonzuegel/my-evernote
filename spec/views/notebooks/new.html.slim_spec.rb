require 'rails_helper'

RSpec.describe 'notebooks/new', type: :view do
  before(:each) do
    assign(:notebook, build(:notebook))
  end

  it 'renders new notebook form' do
    render

    assert_select 'form[action=?][method=?]', notebooks_path, 'post' do
      assert_select 'input#notebook_guid[name=?]', 'notebook[guid]'
      assert_select 'input#notebook_name[name=?]', 'notebook[name]'
      assert_select 'select#notebook_user_id[name=?]', 'notebook[user_id]'
    end
  end
end
