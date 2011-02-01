$("fish-file").each(function(index, item) {
  var current_url = $(item).attr("href");
  var new_url = "http://fishdelish.cs.man.ac.uk/fishomatic/fish_files/display?fish_file="+current_url
  alert("Setting " + current_url + " to " + new_url);
  $(item).attr("href", new_url);
});
