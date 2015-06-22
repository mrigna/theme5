class NodesController < ApplicationController
  before_action :set_scope, only: :index

  def index
    @nodes = Node.all
    @node_select =  @q.result(distinct: true).page(params[:page]).per(20)
    @title = @dg
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