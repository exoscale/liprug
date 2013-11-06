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

    $("td.delete-past-event").each(function(index, el) {

	var b = $(el).find("button");
	var id = b.attr("id");
	b.click(function (ev) {
	    ev.preventDefault();
	    $.ajax({url: '/api/past/' + id,
		    type: 'DELETE'});
	});
    });

    $("td.delete-upcoming-event").each(function(index, el) {

	var b = $(el).find("button");
	var id = b.attr("id");
	b.click(function (ev) {
	    ev.preventDefault();
	    $.ajax({url: '/api/upcoming/' + id,
		    type: 'DELETE'});
	});
    });
});
