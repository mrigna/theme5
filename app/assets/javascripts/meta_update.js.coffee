update = ->
 $.ajax
    data:	title: $('#title').val()
			description: $('#description').val()
	 	  	keywords: $('#keywords').val()
	 	   	lang_select: $('#lang_select').val()   
	 	  	node_select: $('#node_select').val()
 return


