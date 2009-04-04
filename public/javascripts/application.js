// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Forms tagged with class "emptyme" are emptied on first focus
// $(document).ready(function() {
// 	$(".emptyme").bind("focus", function() {
// 		$(this).val("");
// 		$(this).unbind("focus");
// 	})
// });
// 
// 
// $("#myForm").bind("keypress", function(e) {
//  if (e.keyCode == 34) return false;
// });

$(document).ready(function() {

  $(".emptyme").bind("focus", function() {
     $(this).val("");
     var $submitButton = $(this).next();
     $submitButton.removeAttr("disabled");

     $(this).unbind("focus")
   })
});
