class Note < ActiveRecord::Base
  belongs_to :notebook

  def self.sync(attributes)
    NoteSync.new.sync(attributes)
  end
end
