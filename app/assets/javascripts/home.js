// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function() {
	$('#filter').val('');
	$('#filter').on('change keyup paste', filter_names);
});

function filter_names() {
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
}

function vote(id, action, upclass, dnclass) {
	var votes = $('#votes'+id);
	var upBtn = $('#up'+id);
	var dnBtn = $('#dn'+id);

	$.getJSON("/messages/"+id+"/"+action, function( data ) {
		votes.html(data['votes']);
		votes.attr('class', data['votes']>0 ? 
			'text-success' : data['votes']<0 ?
			'text-danger' : '');

		upBtn.attr('class', data['state'] == "" ? "btn btn-default" : "btn btn-"+upclass);
		dnBtn.attr('class', data['state'] == "" ? "btn btn-default" : "btn btn-"+dnclass);
	});
}

function up(id) {
	vote(id, 'upvote', 'success', 'default');
}

function dn(id) {
	vote(id, 'downvote', 'default', 'danger');
}
//# sourceURL=home.js