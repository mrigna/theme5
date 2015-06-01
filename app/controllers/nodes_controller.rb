class NodesController < ApplicationController
  before_action :set_nodes, only: :index
     
  def index   
    @nodes = Node.all
    @node_select =  @q.result(distinct: true).page(params[:page]).per(20)
    @choice_dg = ["", "dg-gs", "dg4", "dg5", "medex", "shc", "com-po"]
  end
    
  private
  def set_nodes
     @dg = params[:dg]
    if @dg == "all" or @dg.nil?
       @q = Node.all.ransack(params[:q])
    else
    @q = Node.dg(@dg).ransack(params[:q])
    end
    
    if @dg.nil? and params[:authenticity_token].present?
      @title = "Simple Search" 
    else
      @title = @dg
    end      
  end
  
 
   
end
 