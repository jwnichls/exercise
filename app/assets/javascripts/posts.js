function processPost(text_field, label) {
	var val = $("#" + text_field).val();
	var length = val.length;
	//set base length
	var postCharacterCount = length;
	
	//find urls	
    var exp = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
    //var exp = /[-a-zA-Z0-9@:%_\+.~#?&//=]{2,256}\.[a-z]{2,4}\b(\/[-a-zA-Z0-9@:%_\+.~#?&//=]*)?/gi;

    
    //get array of matches
    var matches = val.match(exp,"<a href='$1'>$1</a>"); 
    if(matches != null) {
	    for(var i = 0; i < matches.length; i++) {
	    	//assumes each url posted >= 20 characters and will be replaced with 20 character bitly
	    	postCharacterCount = postCharacterCount - matches[i].length
	    	postCharacterCount = postCharacterCount + 20;
	    }
	}

	$("#" + label).text(140-postCharacterCount + " characters remaining");	
	if(postCharacterCount > 140) {
		$("#" + label).css("color","rgb(251,180,174)");
		$("#new-post").attr("disabled","disabled");
		$('#tweet-post').attr("disabled","disabled");
	} else {
		$("#new-post").removeAttr("disabled");
		$("#tweet-post").removeAttr("disabled");
	}
}

function processAndTweet(text_field) {
	var val = $("#" + text_field).val();
  $.post('tweets/create_and_post' + "?body=" + $('#BodyText').val(), function(data){} );

}
