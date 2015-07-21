class EvernoteClient
  ActiveModel::Model
  attr_accessor :auth_token

  def initialize(attributes = {})
    @auth_token = attributes.fetch(:auth_token)
    @client = EvernoteOAuth::Client.new(token: auth_token)
    begin
      ping_evernote
    rescue Exception => e
      throw KeyError
    end
  end

    # @user = User.find(params[:id])

    # if auth_token.present?
    #   client = EvernoteOAuth::Client.new(token: auth_token)
    #   begin
    #     @auth_token = auth_token
    #     note_store = client.note_store
    #     @notebooks = note_store.listNotebooks(auth_token)
    #     @user = client.user_store.getUser(auth_token)
    #     @metadata = note_store.findNotesMetadata(filter, 0, 100, notes_metadata_result_spec)
    #     @note = note_store.getNote(auth_token, @metadata.notes.first.guid, true, true, true, true)
    #     @note = format_note(@note)
    #     @counts = note_store.findNoteCounts(auth_token, filter, false)

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

  def ping_evernote
    note_store = client.note_store
  end

end