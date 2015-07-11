class SearchesController < ApplicationController
  before_action :set_scope

  def simple
    @choice_dg = ["", "dg-gs", "dg4", "dg5", "medex", "shc", "com-po"]
    dg = current_user.dg
    if  current_user.dg == "all"
      @groups =  Node.where.not(group: nil).pluck(:group).uniq.sort
    else
      @groups =  Node.where(dg: dg).where.not(group: nil).pluck(:group).uniq.sort
    end
    @search = @q.result(distinct: true).order(id: :asc)
  end

  def complex
    ##### Grouping queries by OR instead of AND #####
    #@q = Theme.all.ransack(params[:q].try(:merge, m: 'or'))
    #  Normally, if you wanted users to be able to toggle between AND and OR query grouping, you would probably set up your search form so that m was in the URL params hash
    @search = @q.result(distinct: true).includes(:node, :metadata).order(node_id: :asc)
    @q.build_condition if @q.conditions.empty?
    @q.build_sort if @q.sorts.empty?
  end

  def show_original
    render 'original'
  end

  private
  def set_scope
    @user = current_user.dg
    case @user
    when "all"
      if params[:action] == "simple"
        @q = Node.all.where.not(dg: "deleted").ransack(params[:q])
      else
        @q = Theme.where.not(node_id: 0).joins(:node).ransack(params[:q])
      end
    else
      if params[:action] == "simple"
        @q = Node.user(@user).where.not(dg: "deleted").ransack(params[:q])
      else
        @q = Theme.where.not(node_id: 0).joins(:node).where('nodes.dg' => @user).ransack(params[:q])
      end
    end
  end

end
