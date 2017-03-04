function defaultBook(id) {
	$.get("/guestbooks/"+id+"/set_default", function() {});
}

function archive(id, title) {
	if (confirm("Are you sure you wish to archive "+title+"?"))
		window.location = "/guestbooks/"+id+"/archive";
}