require 'base64'
require 'net/http'
require 'data_uri'

module ImageConverterClient
  SUPPORTED_MEDIA_TYPE = 'image/png'
  SUPPORTED_ENCODING_TYPE = 'base64'

  def self.convert(data)
    data_uri = build_data_uri(data)
    uri = URI.parse(Rails.configuration.image_converter_endpoint)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path)
    request.body = data_uri
    response = http.request(request)
    decode_data_uri(response.body.chomp)
  end

  def self.build_data_uri(data)
    "data:#{SUPPORTED_MEDIA_TYPE};#{SUPPORTED_ENCODING_TYPE},#{Base64.encode64(data)}"
  end

  def self.decode_data_uri(body)
    URI::Data.new(body).data
  end
end
