require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tail
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

	if defined?(Rails::Server)
	  config.after_initialize do
	    @file_path = Rails.root.join('test_file.txt')
	  	@last_10_lines = ApplicationHelper.tail(@file_path, 10)
	  	@last_10_lines_array = @last_10_lines.split("\n")

	  	t = Thread.new(@file_path, @last_10_lines_array) do |file_path, last_10_lines_array|
	  		sleep(5)
		    while true do
		      	@new_last_10_lines = ApplicationHelper.tail(file_path, 10)
		      	@new_last_10_lines_array = @new_last_10_lines.split("\n")

		      	@new_lines_array = @new_last_10_lines_array - last_10_lines_array
			  	if(!@new_lines_array.blank?)
			  		ActionCable.server.broadcast("logs", {new_lines: @new_lines_array})
			  		last_10_lines_array = @new_last_10_lines_array
			  		@new_lines_array = []
			  	end
			  	
			  	sleep(5)
		    end
		end
	  end
	end
  end
end
