require 'rails_helper'

RSpec.describe 'notes/show', type: :view do
  before(:each) do
    @note = assign(:note, Note.create!(
                            guid: 'Guid',
                            title: 'Title',
                            content: 'MyText',
                            active: false,
                            notebook_guid: 'Notebook Guid',
                            author: 'Author',
                            notebook: nil
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Guid/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Notebook Guid/)
    expect(rendered).to match(/Author/)
    expect(rendered).to match(//)
  end
end
