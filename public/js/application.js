$(document).ready(function(){

  $('input').focus()


	//AJAX time
	$('.question_upvote').submit(function(e) {
		console.log("ajax! up")
		e.preventDefault()
		var listen = e.target

		$.ajax({
			url: $(listen).attr('action'),
			method: "POST",
			data: $('.question_upvote').serialize()
		}).done(function(response){
			console.log(response)
			var result = jQuery.parseJSON(response)
			

			if (result.alert_msg) {
				// $('#alert_ajax').text(result.alert_msg)
				// $('#alert_ajax').show()
				display_error(result)
			}
			else {
				
				console.log("save")
				$('#question_vote_count' + result.question_object.id ).empty()
				$('#question_vote_count' + result.question_object.id ).append(result.qv_count)
				
				if(result.voted == 1) {
					$button = $("#upvote" + result.question_object.id + ".upvote_false")
					// debugger
					$button.text("Upvoted")
					$button.removeClass("upvote_false").addClass("upvote_true")
				}
				else
				{
					$button = $("#upvote" + result.question_object.id + ".upvote_true")
					// debugger
					$button.text("Upvote")
					$button.removeClass("upvote_true").addClass("upvote_false");
				}
			}
		 
			console.log("end of ajax upvote")
		})
	})


	$('.question_downvote').submit(function(e) {
		console.log("ajax! down")
		e.preventDefault()
		var listen = e.target

		$.ajax({
			url: $(listen).attr('action'),
			method: "POST",
			data: $('.question_downvote').serialize()
		}).done(function(response){
			console.log(response)
			var result = jQuery.parseJSON(response)
			

			if (result.alert_msg) {
				// $('#alert_ajax').text(result.alert_msg)
				// $('#alert_ajax').show()
				display_error(result)
			}
			else {
				
				console.log("save")
				
				$('#question_vote_count' + result.question_object.id ).empty()
				$('#question_vote_count' + result.question_object.id ).append(result.qv_count)

				// debugger

				if(result.voted == 1) {
					$button = $("#upvote" + result.question_object.id + ".upvote_true")
					// debugger
					$button.text("Upvote")
					$button.removeClass("upvote_true").addClass("upvote_false");

				}
				else
				{
					// if user has not voted then do nothing
				}
			}
		 
			console.log("end of ajax upvote")
		})
	})




// *******************************************
// Answer UP vote
// *******************************************

	$('.answer_upvote').submit(function(e) {
		console.log("ajax! up")
		e.preventDefault()
		var listen = e.target

		$.ajax({
			url: $(listen).attr('action'),
			method: "POST",
			data: $('.answer_upvote').serialize()
		}).done(function(response){
			console.log(response)
			var result = jQuery.parseJSON(response)
			

			if (result.alert_msg) {
				// $('#alert_ajax').text(result.alert_msg)
				// $('#alert_ajax').show()
				display_error(result)
			}
			else {
				
				console.log("save")

				$('#answer_vote_count' + result.answer_object.id ).empty()
				$('#answer_vote_count' + result.answer_object.id ).append(result.av_count)
				
				if(result.voted == 1) {
					
					$button = $("#upvote" + result.answer_object.id + ".upvote_false")
					// debugger
					$button.text("Upvoted")
					$button.removeClass("upvote_false").addClass("upvote_true")

				}
				else
				{
					$button = $("#upvote" + result.answer_object.id + ".upvote_true")
					// debugger
					$button.text("Upvote")
					$button.removeClass("upvote_true").addClass("upvote_false");
				}
			}
		 
			console.log("end of ajax answer upvote")
		})
	})


// *******************************************
// Answer DOWN vote
// *******************************************

	$('.answer_downvote').submit(function(e) {
		console.log("ajax! down")
		e.preventDefault()
		var listen = e.target

		$.ajax({
			url: $(listen).attr('action'),
			method: "POST",
			data: $('.answer_downvote').serialize()
		}).done(function(response){
			console.log(response)
			var result = jQuery.parseJSON(response)
			

			if (result.alert_msg) {
				// $('#alert_ajax').text(result.alert_msg)
				// $('#alert_ajax').show()
				display_error(result)
			}
			else {
				
				console.log("save")
				
				$('#answer_vote_count' + result.answer_object.id ).empty()
				$('#answer_vote_count' + result.answer_object.id ).append(result.av_count)

				// debugger

				if(result.voted == 1) {
					$button = $("#upvote" + result.answer_object.id + ".upvote_true")
					// debugger
					$button.text("Upvote")
					$button.removeClass("upvote_true").addClass("upvote_false");

				}
				else
				{
					// if user has not voted then do nothing
				}
			}
		 
			console.log("end of ajax answer upvote")
		})
	})



	// ***********************************************************
	// User sign up
	// ***********************************************************


	$('.user_signup').submit(function(e) {
		console.log("ajax! sign up")
		e.preventDefault()
		var listen = e.target
		
		$.ajax({
			url: "/users_ajax",
			method: "POST",
			data: $('.user_signup').serialize()
		}).done(function(response){
			console.log(response)
			var result = jQuery.parseJSON(response)
			
			
			if (result.alert_msg) {
				// $('#alert_ajax').text(result.alert_msg)
				// $('#alert_ajax').show()
				display_error(result)
			}
			else {
				
				console.log("signup")
				
				if(result.success == 1) {
				debugger
				$('#signup_button').prop('disabled', true)
				$('#signup_message').empty()
				$('#signup_message').append("Your account with email address: " + result.user_object.email + " has been created successfully.")

				// Username:<%=@new_user.username%> has created an account with email:<%=@new_user.email %>


				}
				else
				{
					console.log("success = 0")

				}


			}
		 
			console.log("end of ajax signup")
		})
	})





	// ***********************************************************
	// Helper functions
	// ***********************************************************
	function display_error(result) {
		$('#result_ajax').hide()
		$('#alert_ajax').show()
		
		$('#alert_msg').empty()
		// $('#alert_msg').text(result.alert_msg)
		$('#alert_msg').append(
					'<p>' + result.alert_msg + '</p>'
			)


	}




}) // end of document ready
