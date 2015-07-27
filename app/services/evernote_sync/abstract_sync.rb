class AbstractSync
  attr_reader :attributes

  def initialize(attributes = {})
    @attributes = attributes.symbolize_keys!
  end

  def sync
    return model_class.create(attributes) unless resource?

    resource.update_attributes(attributes) if updated?
  end

  protected

  def model_class
    fail NotImplementedError, "#{self.class}#model_class is not implemented"
  end

  private

  def resource
    @resource ||= model_class.find_by(guid: attribute(:guid))
  end

  def resource?
    resource.present?
  end

  def updated?
    resource[:en_updated_at].nil? || resource[:en_updated_at] < attribute(:en_updated_at)
  end

  def attribute(name)
    attributes.fetch(name)
  end
end
