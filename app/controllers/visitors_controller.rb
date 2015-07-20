class VisitorsController < ApplicationController
  def index
    if authtoken
      client = EvernoteOAuth::Client.new(token: authtoken)

      note_store = client.note_store
      @notebooks = note_store.listNotebooks(authtoken)
      @user = client.user_store.getUser(authtoken)
      @metadata = note_store.findNotesMetadata(filter, 0, 100, notes_metadata_result_spec)
      @note = note_store.getNote(authtoken, @metadata.notes.first.guid, true, true, true, true)
      @note = format_note(@note)
      @counts = note_store.findNoteCounts(authtoken, filter, false)

      obj = {
        note_store: {
          notebooks: @notebooks,
          metadata: @metadata,
          note: @note,
          counts: @counts
        },
        user_store: {
          user: @user,
        }
      }
      render json: obj
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

  def filter
    Evernote::EDAM::NoteStore::NoteFilter.new
  end

  def notes_metadata_result_spec
    Evernote::EDAM::NoteStore::NotesMetadataResultSpec.new(
      includeTitle: true,
      includeContentLength: true,
      includeCreated: true,
      includeUpdated: true,
      includeDeleted: true,
      includeUpdateSequenceNum: true,
    )
  end
end
