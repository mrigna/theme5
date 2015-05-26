class NodesController < ApplicationController
  before_action :clear_search_index, only: :simple
  before_action :set_nodes, only: [:index, :simple]
  
  
  def index   
    @nodes = Node.all
    @node_select =  @q.result(distinct: true).page(params[:page]).per(20)
  end
  
  def simple
    @node_select =  @q.result(distinct: true)
    render 'simple_search'
    clear_search_index
  end
  
  private
  def set_nodes
     @dg = params[:dg]
    if @dg == "all" or @dg.nil?
       @q = Node.all.ransack(params[:q])
    else
    @q = Node.dg(@dg).ransack(params[:q])
    end
    @choice_dg = ["", "dg-gs", "dg4", "dg5", "medex", "shc", "com-po"]
    
  end
  
 
   
end
 