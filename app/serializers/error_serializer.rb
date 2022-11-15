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

  def self.user_not_found
    {
      errors: [
        {
          title: "Not Found",
          detail: "The user could not be found with the provided api_key.",
          source: {parameter: "api_key"}
        }
      ]
    }
  end

  def self.invalid_country
    {
      errors: [{
        title: "Invalid Parameters",
        detail: "The country provided cannot be found.",
        source: {parameter: 'country'}
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