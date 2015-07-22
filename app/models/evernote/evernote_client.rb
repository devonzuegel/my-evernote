class EvernoteClient
  ActiveModel::Model
  DEFAULT_OFFSET    = 0
  DEFAULT_N_RESULTS = 100

  def initialize(attributes = {})
    @auth_token = attributes.fetch(:auth_token)
    @client = EvernoteOAuth::Client.new(token: @auth_token)
    ping_evernote
  end

  def notebooks
    note_store.listNotebooks(@auth_token)
  end

  def notebook_counts
    note_store.findNoteCounts(@auth_token, filter, false)
  end

  def user
    user_store.getUser(@auth_token)
  end

  def notes_metadata
    note_store.findNotesMetadata(filter, DEFAULT_OFFSET, DEFAULT_N_RESULTS, notes_metadata_result_spec)
  end

  def notes
    notes_metadata.notes
  end

  def first_note
    note = note_store.getNote(@auth_token, notes.first.guid, true, true, true, true)
    format_note(note)
  end

    #     @obj = {
    #       note_store: {
    #         notebooks: @notebooks,
    #         metadata: @metadata,
    #         note: @note,
    #         counts: @counts
    #       },
    #       user: @user,
    #     }
    #     ap @obj
    #   rescue => e
    #     @obj = e
    #   end
    # end
  private
    def user_store
      @client.user_store
    end

    def note_store
      @client.note_store
    end

    def ping_evernote
      note_store
    rescue Evernote::EDAM::Error::EDAMUserException => e
      raise Evernote::EDAM::Error::EDAMUserException, 'Invalid authentication token.'
    end

    def format_note(note)
      {
        title: note.title,
        content: note.content,
        content_length: note.contentLength,
        created: note.created,
        updated: note.updated,
        active: note.active,
        # update_seq_num: note.updateSequenceNum,
        notebook_guid: note.notebookGuid,
        attributes: { author: note.attributes.author }
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
        # includeUpdateSequenceNum: true,
      )
    end
end