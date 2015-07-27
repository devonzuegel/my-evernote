class NoteSync < AbstractSync
  SYNCED_ATTRIBUTES = %i(
    active
    author
    content
    en_created_at
    en_updated_at
    guid
    notebook_guid
    title
  )

  def initialize(attributes = {})
    super

    @attributes.slice!(*SYNCED_ATTRIBUTES)
    @generic_class = Note
  end
end
