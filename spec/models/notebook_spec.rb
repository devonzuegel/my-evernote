require 'rails_helper'

RSpec.describe Notebook, type: :model do

  describe 'Syncing notebooks from evernote' do
    it 'should create a new notebook if it cannot find one with the provided guid' do
      expect(Notebook.count).to eq 0
      Notebook.sync(build(:notebook).attributes)
      expect(Notebook.count).to eq 1
    end

    it 'should updated the existing notebook that has the provided guid' do
      notebook = create(:notebook)
      expect(Notebook.count).to eq 1
      updated_attrs = {
        guid: notebook['guid'],
        name: 'A different title!',
        en_updated_at: Time.now
      }
      Notebook.sync(updated_attrs)
      expect(Notebook.count).to eq 1
      expect(Notebook.first[:name]).to eq updated_attrs[:name]
    end

    it 'should not change an existing notebook with an equivalent update date' do
      notebook = create(:notebook)
      expect(Notebook.count).to eq 1
      updated_attrs = {
        guid: notebook['guid'],
        name: 'A different title!',
        en_updated_at: notebook['en_updated_at']
      }
      Notebook.sync(updated_attrs)
      expect(Notebook.count).to eq 1
      expect(Notebook.first[:name]).to eq notebook[:name]
    end
  end
end