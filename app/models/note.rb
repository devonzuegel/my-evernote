class Note < ActiveRecord::Base
  belongs_to :notebook
  validates :guid, uniqueness: true, presence: true

  def self.sync(attributes)
    NoteSync.new(attributes).sync
  end

  def notebook
    (Notebook.where(guid: notebook_guid) | Notebook.where(id: notebook_id)).first
  end
end
