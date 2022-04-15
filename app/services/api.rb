module Api

  def self.do_get_request(api_endpoint)
    uri = URI(api_endpoint)
    response = Net::HTTP.get_response(uri)
    puts response.body if response.is_a?(Net::HTTPSuccess)
    return response
  end

  def self.do_post_request(api_endpoint, params={})
    uri = URI(api_endpoint)
    response = Net::HTTP.get_response(uri)
    response = Net::HTTP.post_form(uri, params)
    puts response.body if response.is_a?(Net::HTTPSuccess)
    return response
  end

end