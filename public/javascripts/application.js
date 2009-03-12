// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Forms tagged with class "emptyme" are emptied on first focus
$(document).ready(function() {
	$(".emptyme").bind("focus", function() {
		$(this).val("");
		$(this).unbind("focus")
	})
});
