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
//= require jquery-ui
//= require jquery.purr
//= require best_in_place
//= require_tree .


jQuery.ajaxSetup({
   'beforeSend': function(xhr) { xhr.setRequestHeader("Accept", "text/javascript") }
});


$(document).ready(function() {
	// Replace rails submit button with button tags for jquery ui
	$('input[type="submit"]').each(function() {
		$(this).hide().after('<button>').next().button({
			icons: {
				primary: 'ui-button',
			},
			label: $(this).val()			
		}).click(function(event) {
			event.preventDefault();
			$(this).prev().click();
		});
	});
	
	jQuery(".best_in_place").best_in_place();
	$.datepicker.setDefaults({ dateFormat: 'dd/mm/y' });
	$('.datepicker').datepicker();




	
 	$("#hospital_hospital_id").change(function(){
    	var id = $(this).children(":selected").val();
    	var params = 'hospital_id=' + id;
	    $.ajax({
	        url : "/hospitals/wards_by_hospital",
			data :  params
	     })
	})
	$(".patient-visit").bind('change', function(){
	 	if (this.checked){
	  		$.ajax({
		 		type: "POST",
				data: {patient_id: this.value,claim_id: this.name},
				url : "/visits",
 	   		})
	 	}
		else{
			alert(this.name);
			$.ajax({
		 		type: "POST",
				data: {patient_id: this.value,claim_id: this.name},
				url : "/visits/remove",
 	   		})
		}
	})
	$(".patient-under").bind('change', function(){
			alert(this.value);
	  		$.ajax({
		 		type: "POST",
				data: {patient_id: this.value},
				url : "/patients/"+this.value+"/under",
 	   		})
	 	
	})
	
	$(".ward-select").change(function(){
		var id = $(this).children(":selected").val();
		$.ajax({
	 		type: "POST",
			data: {ward_id:id},
			url : "/patients/"+this.name+"/changeward",
   		})
	});
	

	// change text on button when claim is submitted
	$(".edit-claim").bind("ajax:beforeSend", function(event,xhr,status){
	  var submit = $(this).find(":submit").attr('value','Saving!');

	});
	$(".edit-claim").bind("ajax:complete", function(event,xhr,status){
	  var submit = $(this).find(":submit").attr('value','Update');
	});
	

		$("#new_ward_link").click(function() {
		  alert("Handler for .click() called.");
		  $("#new_ward_link").toggle();
		  $("#new_ward").toggle();
		});
		

	$('#new_ward').blur(function() {
	  alert(this.value);
	  $("#new_ward_link").toggle();
	  $("#new_ward").toggle();
	
	});
	

	



})

