class NodesController < ApplicationController
  before_action :set_scope, only: [:home, :index, :edit]
  before_action :set_node, only: [:edit, :update, :remove_group]

  def index
    @node_select =  @q.result(distinct: true).page(params[:page]).per(20).order(nodeID: :asc)
    @title = @dg
  end

  def update
    @node.update(group: params[:node][:group]) unless params[:node][:group].blank?
    redirect_to dg_nodes_path(@node.dg)
  end

  def remove_group
    @node.update(group: nil)
    redirect_to dg_nodes_path(@node.dg)
  end

  private

  def set_node
  @node = Node.find(params[:id])
    unless current_user.dg == "all"
    @scope = Node.user(@user).where.not(:group => nil)
    else
    @scope = Node.all.where.not(:group => nil)
    end
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