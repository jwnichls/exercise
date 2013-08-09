// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require "foundation"
//= require jquery.validate
//= require jquery.validate.additional-methods
//= require_tree .

$(document).ready(function() {
	$("#postindex").hide();

	$("#new_survey").validate({
    onfocusout:true,
    errorPlacement: function(error, element) {
      error.insertBefore(element);
    },
		rules: {
      "survey[ls1]"		:"required",
      "survey[ls2]"		:"required",
      "survey[ils1]"	:"required"
	  }
	  
	}); 
	
	$("#survey").on('ajax:success', function(e, data, status, xhr) {
  	$(this).hide("slow");
  	if(data == 2) {
  		      
        $("#postindex").show("slow");

      
  	}
  	else if(data ==  1 || data == 3) {
  		$(".hitfinished").show("slow");
  	}
  });
  /*
  $("#postindex").on('ajax:success', function(e, data, status, xhr) {
  	$(this).show("slow");
  });*/

});



/* GOOGLE ANALYTICS */
  

  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-42541310-3', 'herokuapp.com');
  ga('send', 'pageview');

