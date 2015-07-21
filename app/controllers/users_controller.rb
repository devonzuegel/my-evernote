class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    evernote = EvernoteClient.new(auth_token: auth_token)
    puts "evernote.auth_token = #{evernote.auth_token}".yellow
    render json: { auth_token: evernote.auth_token }

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
