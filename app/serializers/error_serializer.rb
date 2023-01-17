class ErrorSerializer
  def self.bad_request(messages)
    {
      "message": "Bad Request",
      "errors": messages
    }
  end
end