require 'rails_helper'

RSpec.describe 'notebooks/show', type: :view do
  before(:each) do
    @notebook = assign(:notebook, Notebook.create!(
                                    guid: 'Guid',
                                    name: 'Name',
                                    user: nil
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Guid/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end
