$(document).ready ->
  $('#lang_select').on 'change', ->
    $.ajax
      url: '#{new_entry_path}'
      data: lang: $('#lang_select').val()
      dataType: 'script'
  $('#node_select').on 'change', ->
    $.ajax
      url: '#{new_entry_path}'
      data: node_id: $('#node_select').val()
      dataType: 'script'
    return
  return
return