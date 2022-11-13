class ErrorSerializer
  def self.required_parameter(parameter)
    {
      title: "Invalid Parameters",
      detail: "A #{parameter} parameter is required for this request.",
      source: {parameter: parameter}
    }
  end
end