class NodesController < ApplicationController

  def index
    #@themes = Theme.all.order(id: :asc)   
    @nodes = Node.dg("DG-GS").all.order(id: :asc)
  end
   
end
 