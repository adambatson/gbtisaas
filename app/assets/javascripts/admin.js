function defaultBook(id) {
	$.get("/guestbooks/"+id+"/set_default", function() {});
	location.reload();
}