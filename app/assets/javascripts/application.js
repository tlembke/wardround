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

//= require best_in_place
//= require_tree .

$(document).ajaxSend(function(e, xhr, options) {
  var token = $("meta[name='csrf-token']").attr("content");
  xhr.setRequestHeader("X-CSRF-Token", token);
});

jQuery.ajaxSetup({
 'beforeSend': function(xhr) { xhr.setRequestHeader("Accept", "text/javascript") }
 });

	//jQuery.extend(jQuery.mobile.datebox.prototype.options, {
	//  'overrideDateFormat': '%d/%m/%Y',
	//  'showInitialValue': "true",
	// });


$('#showround').live('pageinit', function(event) {
		    $('input[type="checkbox"]').each(function(){
		        ($(this).is(':checked')) ? $(this).parent().parent().addClass('checked') : $(this).parent().parent().addClass('not-checked');
		    });


		$('.checkBoxLeft').bind('click', function(e) {
		    if($(this).find('input[type="checkbox"]').is(':checked')){
		       $(this).removeClass('checked').addClass('not-checked'); 
		       $(this).find('input[type="checkbox"]').attr('checked' , false);
		  		$.ajax({
			 		type: "POST",
					data: {patient_id: $(this).find('input[type="checkbox"]').attr('value'),round_id: $(this).find('input[type="checkbox"]').attr('name')},
					url : "/visits/remove",
		   		})
		    } else {
		       $(this).removeClass('not-checked').addClass('checked');             
		       $(this).find('input[type="checkbox"]').attr('checked' , true);
				$.ajax({
			 		type: "POST",
					data: {patient_id: $(this).find('input[type="checkbox"]').attr('value'),round_id: $(this).find('input[type="checkbox"]').attr('name')},
					url : "/visits",
		   		})
		    }
		});
});
$('#showpatient').live('pageinit', function(event) {

		
			$('input[type="checkbox"]').bind('click', function(e) {

			    if($(this).is(':checked')){
			  		$.ajax({
				 		type: "POST",
						data: {patient_id: $(this).attr('value'),round_id: $(this).attr('name')},
						url : "/visits/charge",
			   		})
			    } else {
					$.ajax({
				 		type: "POST",
						data: {patient_id: $(this).attr('value'),round_id: $(this).attr('name')},
						url : "/visits/uncharge",
			   		})
			    }
			});
		
	// attrchanger
	$(".attrchanger").change(function(){
		var name = $(this).attr('data-attr');
		var value = $(this).val();
		var dataObj = {};

		dataObj[name]=value;
		$.ajax({
			type: "PUT",
			data: dataObj,
			url : "/patients/"+$(this).attr('data-patient')
   		})

	});

	// discharge
	$("#discharge").click(function(){
		$.ajax({
	 		type: "POST",
			url : "/patients/"+$(this).attr('data-patient')+"/discharge",
   		})
	});
	//undischarge
	$("#undischarge").click(function(){
		$.ajax({
	 		type: "POST",
			url : "/patients/"+$(this).attr('data-patient')+"/undischarge",
   		})
	});

	// change patients wards
	$("#patient_ward_id").change(function(){
		$.ajax({
	 		type: "POST",
			data: {ward_id:$(this).val()},
			url : "/patients/"+$(this).attr('data-patient')+"/changeward",
   		})
	});
});


$('#newpatient').live('pageinit', function(event) {
	$("#hospital_id").change(function(){ 
		var id = $(this).children(":selected").val();
		var params = 'hospital_id=' + id;
    	$.ajax({
        	url : "/hospitals/wards_by_hospital",
			data :  params
     	})
	});
});	
	
$(document).ready(function() {

	// Replace rails submit button with button tags for jquery ui
	// commented out for jquery mobile
	// $('input[type="submit"]').each(function() {
	//	$(this).hide().after('<button>').next().button({
	//		icons: {
	//			primary: 'ui-button',
	//		},
	//		label: $(this).val()			
	//	}).click(function(event) {
	//		event.preventDefault();
	//		$(this).prev().click();
	//	});
	// });




	// for checkbox in list views in jquerymobile
	// as per http://jsfiddle.net/Gajotres/ek2QT/



/*
	
	// attrchanger
	$(".attrchanger").change(function(){
		var name = $(this).attr('data-attr');
		var value = $(this).val();
		var dataObj = {};

		dataObj[name]=value;
		$.ajax({
			type: "PUT",
			data: dataObj,
			url : "/patients/"+$(this).attr('data-patient')
   		})

	});
	
	
	// discharge
	$("#discharge").click(function(){
		alert("Discharge");
		$.ajax({
	 		type: "POST",
			url : "/patients/"+$(this).attr('data-patient')+"/discharge",
   		})
	});
	//undischarge
	$("#undischarge").click(function(){
		$.ajax({
	 		type: "POST",
			url : "/patients/"+$(this).attr('data-patient')+"/undischarge",
   		})
	});
	
	// change patients wards
	$("#patient_ward_id").change(function(){
		$.ajax({
	 		type: "POST",
			data: {ward_id:$(this).val()},
			url : "/patients/"+$(this).attr('data-patient')+"/changeward",
   		})
	});
*/	
	jQuery(".best_in_place").best_in_place();

	//$.datepicker.setDefaults({ dateFormat: 'dd/mm/y' });
	//$('.datepicker').datepicker();





/*
	$(".patient-visit").bind('change', function(){
	 	if (this.checked){
	  		$.ajax({
		 		type: "POST",
				data: {patient_id: this.value,round_id: this.name},
				url : "/visits",
 	   		})
	 	}
		else{
			$.ajax({
		 		type: "POST",
				data: {patient_id: this.value,round_id: this.name},
				url : "/visits/remove",
 	   		})
		}
	});

*/		
/*
	// change text on button when claim is submitted
	$(".edit-claim").bind("ajax:beforeSend", function(event,xhr,status){
	  var submit = $(this).find(":submit").attr('value','Saving!');

	});
	$(".edit-claim").bind("ajax:complete", function(event,xhr,status){
	  var submit = $(this).find(":submit").attr('value','Update');
	});
	
*/
//		$("#new_ward_link").click(function() {
//		  alert("Handler for .click() called.");
//		  $("#new_ward_link").toggle();
//		  $("#new_ward").toggle();
//		});


//	$('#new_ward').blur(function() {
//	  alert(this.value);
//	  $("#new_ward_link").toggle();
//	  $("#new_ward").toggle();
//	
//	});






})