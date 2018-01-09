class HomeController < ApplicationController
  def index
  	@file_path = Rails.root.join('test_file.txt')
  	@last_10_lines = ApplicationHelper.tail(@file_path, 10)
  	@last_10_lines_array = @last_10_lines.split("\n")
  end
end
