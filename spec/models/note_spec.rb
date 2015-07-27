require 'rails_helper'

RSpec.describe Note, type: :model do
  describe '.sync' do
    subject(:sync) { -> { Note.sync(attributes) } }
    let(:first_note) { Note.first }

    context 'when the guid is new' do
      let(:attributes) { attributes_for(:note) }

      it { should change(Note, :count).from(0).to(1) }
    end

    context 'when the guid is in the database' do
      let!(:note) { create(:note, en_updated_at: 2.days.ago) }
      let(:attributes) { attributes_for(:note, guid: note.guid, en_updated_at: Time.now) }

      it 'updates' do
        expect(sync).to_not change(Note, :count)
        expect(first_note.title).to eq(attributes.fetch(:title))
      end
    end

    context 'when the guid is in the database but update is the same' do
      let!(:note) { create(:note, en_updated_at: 2.days.ago) }
      let(:attributes) { attributes_for(:note, guid: note.guid, en_updated_at: note.en_updated_at) }

      it 'does not update' do
        expect(sync).to_not change(Note, :count)
        expect(first_note.title).to eq(note.title)
        expect(first_note.title).to_not eq(attributes.fetch(:title))
      end
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

  describe "Acceessing the note's notebook" do
    it 'should get the notebook with the same notebook_guid' do
      notebook_guid = Faker::Lorem.characters(20)
      notebook = create(:notebook, guid: notebook_guid)
      note = create(:note, notebook_guid: notebook_guid)
      expect(note.notebook). to eq notebook
    end

    it 'should get the notebook with the same notebook_id' do
      notebook = create(:notebook)
      note = create(:note, notebook_id: notebook.id)
      expect(note.notebook).to eq notebook
    end
  end
end
