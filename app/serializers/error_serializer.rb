class ErrorSerializer
  def self.required_parameter(parameter)
    {
      errors: [{
        title: "Invalid Parameters",
        detail: "A #{parameter} parameter is required for this request.",
      }]
    }
  end

  def self.user_not_found
    {
      errors: [
        {
          title: "Not Found",
          detail: "The user could not be found with the provided api_key.",
        }
      ]
    }
  end

  def self.not_found(message)
    {
      errors: [
        {
          title: "Not Found",
          detail: message
        }
      ]
    }
  end

  def self.invalid_country
    {
      errors: [{
        title: "Invalid Parameters",
        detail: "The country provided cannot be found.",
      }]
    }
  end

  def self.validation_errors(errors)
    {
      errors: errors.map do |attribute, message|
        {
          title: "Invalid Attribute",
          detail: "#{attribute.to_s.titleize} #{message}.",
        }
      end
    }
  end

  def self.invalid_login
    {
      errors: [
        {
          title: "Invalid Login",
          detail: "The email or password provided is invalid."
        }
      ]
    }
  end
end