# README     

A simple web application to monitor files on remote server      

* Ruby version     
	2.3     
* System dependencies      
	rails 5.1, rubygems, node.js     
	
* Database creation     

	No database needed for now.     
	if database is needed in future, then edit 'config/database.yml' file and add root passowrd and then run `rake db:create`    

* Database initialization    
	No database needed (if database is needed, the run `rake db:migrate`)	       

* Services      
	needs redis server to be running and working     

* Deployment instructions    
	1. Navigate to project directory      
	2. run `bundle install`      
	3. start redis server by running `redis-server`     
	4. start rails server by running `rails server`    
	5. Navigate to `localhost:3000` for getting continuous update of log file       
	6. Navigate to `localhost:3000?user_id={userId}` for getting continuous update of log file for perticular user    
	
	
* ...

* How it works    

1. When server starts, it begin monitoring a log file (located as 'test_file.txt' in project root) and continuously broadcasts changes in given file to "logs" channel     
2. When users visits "/?user_id=1", the webpage subscribes to "user_1" channel and server then continuously broadcasts changes to "users_1" channel     
3. similarly for "/?user_id=2"     