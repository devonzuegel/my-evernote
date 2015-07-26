class NoteSync < AbstractSync
  def initialize
    @generic_class = Note
  end

  def sync(attributes = {})
    attrs = %i(active author content en_created_at en_updated_at guid notebook_guid title)
    attributes.symbolize_keys!.select! { |a| attrs.include?(a) }
    super
  end
end