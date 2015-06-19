class NodesController < ApplicationController
  before_action :set_nodes, only: :index

  def index
    @nodes = Node.all
    @node_select =  @q.result(distinct: true).page(params[:page]).per(20)
  end

  def home
     @title = "Home"
  end

  private
  def node_params
    params.require(:node).permit(:nodeID)
  end

  def set_nodes
    @dg = params[:dg]
    if @dg == "all" or @dg.nil?
       @q = Node.all.ransack(params[:q])
       @title = "All"
    else
    @q = Node.dg(@dg).ransack(params[:q])
    @title = @dg
    end

  end
end