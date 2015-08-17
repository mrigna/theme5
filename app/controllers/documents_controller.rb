class DocumentsController < NodesController

  def check
    @document = Document.find(params[:id])
    if  params[:document][:check_doc] == "1"
      @document.update_column(:checked, true)
    else
      @document.update_column(:checked, false)
  end
  render text: ""
  end
    
end    