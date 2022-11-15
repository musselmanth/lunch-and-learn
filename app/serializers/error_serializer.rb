class ErrorSerializer
  def self.required_parameter(parameter)
    {
      errors: [{
        title: "Invalid Parameters",
        detail: "A #{parameter} parameter is required for this request.",
        source: {parameter: parameter}
      }]
    }
  end

  def self.validation_errors(errors)
    {
      errors: errors.map do |attribute, message|
        {
          title: "Invalid Attribute",
          detail: "#{attribute.to_s.titleize} #{message}.",
          source: {parameter: attribute.to_s}
        }
      end
    }
  end
end