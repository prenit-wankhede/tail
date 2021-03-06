$(document).ready(function(){
	const user_id = $(".user-id-value").val();
	if(user_id) {
		App.user = App.cable.subscriptions.create({channel: "UsersChannel", user_id: user_id}, {
		  connected: function() {
		    // Called when the subscription is ready for use on the server
		  },

		  disconnected: function() {
		    // Called when the subscription has been terminated by the server
		  },

		  received: function(data) {
		  	if(data && data.new_lines) {
		  		$.each(data.new_lines, function( index, line ) {
		  			const newLine = '<p>' + line + '</p>'
				  	$("#lines").append(newLine)
				});	
		  	}   
		  }
		});

	}
})