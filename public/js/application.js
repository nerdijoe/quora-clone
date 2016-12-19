$(document).ready(function(){


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
