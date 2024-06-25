require 'sinatra'
require 'mini_magick'
require 'json'

set port: 8080

post '/resize' do
  begin
    content_type :json
    # Extract image data and parameters
    image_data = request.body.read
    return 400, { error: "No image data" }.to_json if image_data.nil? || image_data.empty?

    params = request.params
    width = params['width'] || 100
    height = params['height'] || 100

    image = MiniMagick::Image.read(image_data)

    # Resize image
    image.resize "#{width}x#{height}"

    content_type 'image/jpeg'
    image.to_blob
  rescue => e
    puts e
    status 500
    body({ error: "Error processing image: #{e.message}" }.to_json)
  end
end
