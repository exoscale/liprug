$(document).ready(function () {
    $("td.delete-service").each(function(index, el) {
	var b = $(el).find("button");
	var id = b.attr("id");
	b.click(function (ev) {
	    ev.preventDefault();
	    $.ajax({url: '/api/services/' + id,
		    type: 'DELETE'});
	});
    });

    $("td.delete-event").each(function(index, el) {

	var b = $(el).find("button");
	var id = b.attr("id");
	b.click(function (ev) {
	    ev.preventDefault();
	    $.ajax({url: '/api/events/' + id,
		    type: 'DELETE'});
	});
    });
});
