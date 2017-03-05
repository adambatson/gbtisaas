function defaultBook(id) {
	$.get("/guestbooks/"+id+"/set_default", function() {});
}

function setbook(select, key_id) {
	window.location = '/access_keys/'+key_id+'/assign?guestbook_id='+select.value;
}