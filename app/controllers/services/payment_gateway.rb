class Services::PaymentGateway
  TIMEOUT = 60.freeze

  def self.process_payment
    response = connection.get do |request|
      request.path = "/"
      request.headers['Content-Type'] = 'application/json'
      request.body = create_post_data.to_json
      request.options[:timeout] = TIMEOUT
    end
  get_response_result(response.body)
  rescue Faraday::Error::ConnectionFailed => e
    "connection_failed"
  end

  def self.get_response_result(response)
    result = JSON.parse(response)
    result.try(:[], "status")
  end

  def self.create_post_data
    {"campaign_products" => "id", "notes" => "123"}
  end

  def self.connection
    Faraday.new(url: "http://localhost:5000") do |faraday|
      faraday.adapter :net_http
      faraday.headers["Content-Type"] = "application/json; charset=utf-8"
    end
  end
end
