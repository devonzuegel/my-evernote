require 'rails_helper'

RSpec.describe 'notes/index', type: :view do
  before(:each) do
    2.times { create(:note) }
    @notes = Note.all
  end

  it 'renders a list of notes' do
    render
    @notes.each do |n|
      assert_select 'tr>td', text: n.guid, count: 1
      assert_select 'tr>td', text: n.title, count: 1
    end
  end
end
