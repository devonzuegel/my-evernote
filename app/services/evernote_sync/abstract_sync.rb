class AbstractSync
  attr_accessor :generic_class
  attr_reader :attributes

  def initialize(attributes = {})
    @attributes = attributes.symbolize_keys!
  end

  def sync
    guid = attributes.fetch(:guid)
    resource = generic_class.find_by(guid: guid)
    if resource.nil?
      resource = generic_class.create(attributes)
    elsif updated?(resource)
      resource.update_attributes(attributes)
    end
  end

  private

  def resource
    @resource ||= generic_class.find_by(guid: attribute(:guid))
  end

  def updated?
    resource[:en_updated_at].nil? || resource[:en_updated_at] < attribute(:en_updated_at)
  end

  def attribute(name)
    attributes.fetch(name)
  end
end
