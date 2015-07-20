class VisitorsController < ApplicationController
  def index
    if authtoken
      client = EvernoteOAuth::Client.new(token: authtoken)
      note_store = client.note_store
      @notebooks = note_store.listNotebooks(authtoken)
      @user = client.user_store.getUser(authtoken)

      filter = Evernote::EDAM::NoteStore::NoteFilter.new
      notes_metadata_result_spec = Evernote::EDAM::NoteStore::NotesMetadataResultSpec.new(
        includeTitle: true,
        includeContentLength: true,
        includeCreated: true,
        includeUpdated: true,
        includeDeleted: true,
        includeUpdateSequenceNum: true,
      )
      @metadata = note_store.findNotesMetadata(filter, 0, 100, notes_metadata_result_spec)
      note_guid = @metadata.notes.first.guid
      @note = note_store.getNote(authtoken, note_guid, true, true, true, true)
      @note = format_note(@note)
      @counts = note_store.findNoteCounts(authtoken, filter, false)

      obj = {
        notebooks: @notebooks,
        user: @user,
        metadata: @metadata,
        note: note_guid,
        note: @note,
        counts: @counts
      }
      # render json: obj
    end
  end

  private

  def format_note(note)
    {
      title: note.title,
      content: note.content,
      content_length: note.contentLength,
      created: note.created,
      updated: note.updated,
      active: note.active,
      update_seq_num: note.updateSequenceNum,
      notebook_guid: note.notebookGuid,
      attributes: {
        author: note.attributes.author
      }
    }
  end
end
