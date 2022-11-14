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

  def self.invalid_country
    {
      errors: [{
        title: "Invalid Parameters",
        details: "The country provided cannot be found.",
        source: {parameter: 'country'}
      }]
    }
  end
end