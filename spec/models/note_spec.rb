require 'rails_helper'

RSpec.describe Note, type: :model do
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
