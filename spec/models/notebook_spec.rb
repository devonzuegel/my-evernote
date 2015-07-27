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

  describe 'Creating a new notebook' do
    it 'adds a new valid notebook' do
      expect { create(:notebook) }.to change { Notebook.count }.by 1
    end

    it 'should not create a notebook with a blank guid' do
      expect { Notebook.create! }.to raise_error ActiveRecord::RecordInvalid
    end

    it 'should not create a notebook with a non-unique guid' do
      same_guid = Faker::Lorem.characters(20)
      create(:notebook, guid: same_guid)
      expect { create(:notebook, guid: same_guid) }.to raise_error ActiveRecord::RecordInvalid
    end
  end

  describe "accessing the notebook's notes" do
    it 'should get the notes with the same notebook_guid' do
      notebook = build(:notebook, guid: Faker::Lorem.characters(20))
      notes = 3.times.map { create(:note, notebook_guid: notebook.guid) }
      expect(notebook.notes).to match_array notes
    end

    it 'should get the notes with the same notebook_id' do
      notebook = build(:notebook)
      notes = 3.times.map { create(:note, notebook_id: notebook.id) }
      expect(notebook.notes).to match_array notes
    end
  end
end
