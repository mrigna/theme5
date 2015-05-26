class NodesController < ApplicationController

  def index   
    @nodes = Node.dg("MEDEX").all
  end
   
end
 