// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {
	$('#filter').val('');
	$('#filter').on('change keyup paste', function() {
		var filter = $('#filter').val().toLowerCase();
		$('.message-content').each(function() {
			var value = $(this).html().toLowerCase();
			var parent = $(this).parent();

			if (value.includes(filter)) {
				parent.fadeIn();
			} else {
				parent.fadeOut();
			}
		});
	});
});
//# sourceURL=home.js