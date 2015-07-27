class Notebook < ActiveRecord::Base
  has_many :notes
  belongs_to :user
  validates :guid, uniqueness: true, presence: true

  def self.sync(attributes)
    NotebookSync.new(attributes).sync
  end

  def notes
    (Note.where(notebook_guid: guid) | Note.where(notebook_id: id)).uniq
  end
end
