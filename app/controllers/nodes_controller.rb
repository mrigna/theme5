class NodesController < ApplicationController
   before_action :set_nodes, :check_page_style, only: [:index, :simple]
     
  def index   
    @nodes = Node.all
    @node_select =  @q.result(distinct: true).page(params[:page]).per(20)
    @choice_dg = ["", "dg-gs", "dg4", "dg5", "medex", "shc", "com-po"]
  end
  
  def check_page_style
    if params[:authenticity_token].nil?
      @title = "Node listing"
      @header = 'links'
    else
      @title = "Simple Search"
      @header = 'search'
    end
  end

  
  private
  def set_nodes
     @dg = params[:dg]
    if @dg == "all" or @dg.nil?
       @q = Node.all.ransack(params[:q])
    else
    @q = Node.dg(@dg).ransack(params[:q])
    end
      
  end
  
 
   
end
 