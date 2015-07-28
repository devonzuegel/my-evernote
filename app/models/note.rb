class Note < ActiveRecord::Base
  belongs_to :notebook, class_name: 'Notebook'

  belongs_to :notebook_by_guid,
             class_name: 'Notebook',
             foreign_key: :notebook_guid,
             primary_key: :guid

  validates :guid, uniqueness: true, presence: true

  def self.sync(attributes)
    NoteSync.new(attributes).sync
  end

  def notebook
    Notebook.find_by('id = ? OR guid = ?', notebook_id, notebook_guid)
  end
end
