# Use the official Ruby image from the Docker Hub
FROM ruby:3.3.0

# Install ImageMagick
RUN apt-get update && apt-get install -y imagemagick

# Set the working directory
WORKDIR /usr/src/app

# Copy the Gemfile and Gemfile.lock into the image
COPY Gemfile Gemfile.lock ./

# Install the dependencies
RUN bundle install

# Copy the rest of the application code into the image
COPY . .

# Expose the port that the app runs on
EXPOSE 8080

# Define the command to run the app
CMD ["ruby", "app.rb"]
