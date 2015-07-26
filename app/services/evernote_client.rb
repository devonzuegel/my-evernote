class EvernoteClient
  ActiveModel::Model
  DEFAULT_OFFSET    = 0
  DEFAULT_N_RESULTS = 100

  def initialize(attributes = {})
    @auth_token = attributes.fetch(:auth_token)
    @user_id = attributes.fetch(:user_id)
    @client = EvernoteOAuth::Client.new(token: @auth_token)
    ping_evernote
  end

  def notebooks
    result = []
    note_store.listNotebooks(@auth_token).each do |n|
      result << {
        en_created_at: timestamp_to_datetime(n.serviceCreated),
        en_updated_at: timestamp_to_datetime(n.serviceUpdated),
        guid: n.guid,
        name: n.name,
        user_id: @user_id
      }
    end
    result
  end

  def notebook_counts
    note_store.findNoteCounts(@auth_token, filter, false)
  end

  def en_user
    user_store.getUser(@auth_token)
  end

  def notes_metadata
    note_store.findNotesMetadata(filter, DEFAULT_OFFSET, DEFAULT_N_RESULTS, notes_metadata_result_spec)
  end

  def notes
    note_guids = notes_metadata.notes.map { |n| n.guid }
    notes = note_guids.map { |guid| find_note_by_guid(guid) }
  end

  def find_note_by_guid(guid)
    note = note_store.getNote(@auth_token, guid, true, true, true, true)
    format_note(note)
  end

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
        guid: note.guid,
        title: note.title,
        content: note.content,
        content_length: note.contentLength,
        en_created_at: timestamp_to_datetime(note.created),
        en_updated_at: timestamp_to_datetime(note.updated),
        active: note.active,
        # update_seq_num: note.updateSequenceNum,
        notebook_guid: note.notebookGuid,
        author: note.attributes.author
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

    def timestamp_to_datetime(timestamp)
      epoch = timestamp.to_s.chomp('000')
      DateTime.strptime(epoch, '%s')
    end
end