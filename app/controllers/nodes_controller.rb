class NodesController < ApplicationController
  before_action :set_scope, only: [:home, :index, :edit]
  before_action :set_node, only: [:edit, :update]
  
  def index
    @node_select =  @q.result(distinct: true).page(params[:page]).per(20).order(nodeID: :asc)
    @title = @dg
  end
  
  def edit
    
  end
  
  def update
    @node.update(group: params[:node][:group])
    render text: ""
  end

  private
  
  def node_params
    params.require(:node).permit(:group)
  end
  
  def set_node
  @node = Node.find(params[:id])
  end
  
  def set_scope
    @user = current_user.dg
     if @user == "all"
        @dg = params[:dg]
        unless @dg == "all"
        @q = Node.dg(@dg).ransack(params[:q])
        else
        @q = Node.unscoped.load.ransack(params[:q])
        end
      else
      @q = Node.user(@user).ransack(params[:q])
      end
  end

end