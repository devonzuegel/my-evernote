class AbstractSync
  attr_accessor :generic_class

  def sync(attributes = {})
    guid = attributes.symbolize_keys!.fetch(:guid)
    resource = generic_class.find_by(guid: guid)
    if resource.nil?
      resource = generic_class.create(attributes)
    elsif updated?(resource, attributes)
      resource.update_attributes(attributes)
    end
  end

  private

  def updated?(resource, attributes)
    en_updated_at = attributes.symbolize_keys!.fetch(:en_updated_at)
    resource[:en_updated_at].nil? || resource[:en_updated_at] < en_updated_at
  end
end
