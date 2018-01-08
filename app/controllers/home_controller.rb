class HomeController < ApplicationController
  def index
  	@file_path = Rails.root.join('test_file.txt')
  	@last_10_lines = ApplicationHelper.tail(@file_path, 10)
  	@last_10_lines_array = @last_10_lines.split("\n")

  	
  	@user_id = params[:user_id]
  	if(@user_id.blank?)
  		render
  	else
	  	t = Thread.new(@user_id, @file_path, @last_10_lines_array) do |user_id, file_path, last_10_lines_array|
	  		sleep(5)
		    while true do
		      	@new_last_10_lines = ApplicationHelper.tail(file_path, 10)
		      	@new_last_10_lines_array = @new_last_10_lines.split("\n")

		      	@new_lines_array = @new_last_10_lines_array - last_10_lines_array
			  	if(!@new_lines_array.blank?)
			  		ActionCable.server.broadcast("user_#{user_id}", {new_lines: @new_lines_array})
			  		last_10_lines_array = @new_last_10_lines_array
			  		@new_lines_array = []
			  	end

			  	sleep(5)
		    end
		end

  	end

  end
end
