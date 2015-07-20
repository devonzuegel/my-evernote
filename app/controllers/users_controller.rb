class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])

    if auth_token.present?
      client = EvernoteOAuth::Client.new(token: auth_token)
      @auth_token = auth_token
      note_store = client.note_store
      @notebooks = note_store.listNotebooks(auth_token)
      @user = client.user_store.getUser(auth_token)
      @metadata = note_store.findNotesMetadata(filter, 0, 100, notes_metadata_result_spec)
      @note = note_store.getNote(auth_token, @metadata.notes.first.guid, true, true, true, true)
      @note = format_note(@note)
      @counts = note_store.findNoteCounts(auth_token, filter, false)

      @obj = {
        note_store: {
          notebooks: @notebooks,
          metadata: @metadata,
          note: @note,
          counts: @counts
        },
        user: @user,
      }
    end

    # unless @user == current_user
    #   redirect_to :back, alert: 'Access denied.'
    # end
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
