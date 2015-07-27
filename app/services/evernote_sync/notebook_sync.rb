class NotebookSync < AbstractSync
  def initialize(*)
    super
    @generic_class = Notebook
  end
end
