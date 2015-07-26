require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'Syncing notes from evernote' do
    it 'should create a new notebook if it cannot find one with the provided guid' do
      expect(Note.count).to eq 0
      Note.sync(build(:note).attributes)
      expect(Note.count).to eq 1
    end

    it 'should updated the existing notebook that has the provided guid' do
      note = create(:note, en_updated_at: 2.days.ago)
      expect(Note.count).to eq 1
      updated_attrs = {
        guid: note['guid'],
        title: 'A different title!',
        en_updated_at: Time.now
      }
      Note.sync(updated_attrs)
      expect(Note.count).to eq 1
      expect(Note.first[:title]).to eq updated_attrs[:title]

    end

    it 'should not change an existing notebook with an equivalent update date' do
      note = create(:note, en_updated_at: 2.days.ago)
      expect(Note.count).to eq 1
      updated_attrs = {
        guid: note['guid'],
        title: 'A different title!',
        en_updated_at: note['en_updated_at']
      }
      Note.sync(updated_attrs)
      expect(Note.count).to eq 1
      expect(Note.first[:title]).to eq note[:title]
    end

  end

  describe 'Creating a new note' do
    it 'should increment Note.count by one' do
      expect { create(:note) }.to change { Note.count }.by 1
    end

    it 'should require a guid' do
      expect { Note.create! }.to raise_error ActiveRecord::RecordInvalid
    end

    it 'should require guids to be unique' do
      same_guid = Faker::Lorem.characters(20)
      create(:note, guid: same_guid)
      expect { create(:note, guid: same_guid) }.to raise_error ActiveRecord::RecordInvalid
    end
  end
end
