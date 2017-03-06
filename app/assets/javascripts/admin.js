function defaultBook(id) {
	window.location = "/guestbooks/"+id+"/set_default";
}

function bookVisibility(id) {
	window.location = "/guestbooks/"+id+"/toggle_visibility";
}

function setbook(select, key_id) {
	window.location = '/access_keys/'+key_id+'/assign?guestbook_id='+select.value;
}

function toggleProfanity() {
	$('#profanity').prop('disabled', !$('#autoapprove').prop('checked'));
}

$(function() {
	toggleProfanity();
});