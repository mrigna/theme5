class NodesController < ApplicationController
  before_action :set_scope, only: :index

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

  def set_scope
    @user = current_user.dg
    @title = "TO BE DEFINED"   
      if @user == "all"
      @q = Node.all.ransack(params[:q])
      else
      @q = Node.user(@user).ransack(params[:q])    
      end
  end
end