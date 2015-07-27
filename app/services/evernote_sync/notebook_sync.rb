class NotebookSync < AbstractSync
  def initialize(*)
    super
  end

  protected

  def model_class
    Notebook
  end
end
