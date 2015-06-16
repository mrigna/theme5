$(document).ready(function() {

    $('#lang_select').change(function() {
       $.ajax({
        url: "#{new_entry_path}",
        data: {
          lang : $('#lang_select').val()
        },
        dataType: "script"
     });

    $('#node_select').change(function() {
      $.ajax({
        url: "#{new_entry_path}",
        data: {
          node_id : $('#node_select').val()
        },
        dataType: "script"
      });
    });
  });

