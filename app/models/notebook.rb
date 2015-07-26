class Notebook < ActiveRecord::Base
  has_many :notes
  belongs_to :user
  validates :guid, uniqueness: true, presence: true

  def self.sync(attributes)
    NotebookSync.new.sync(attributes)
  end

end