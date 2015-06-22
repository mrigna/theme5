class SearchesController < ApplicationController
  before_action :set_scope

  def simple
    @choice_dg = ["", "dg-gs", "dg4", "dg5", "medex", "shc", "com-po"]
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
        @q = Node.all.ransack(params[:q])
      else
        @q = Theme.joins(:node).ransack(params[:q])
      end
    else
      if params[:action] == "simple"
        @q = Node.user(@user).ransack(params[:q])
      else
       @q = Theme.joins(:node).where('nodes.dg' => @user).ransack(params[:q])
      end
    end
  end

end
