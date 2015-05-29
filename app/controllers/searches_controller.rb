class SearchesController < ApplicationController
 
  def index
   @q = Theme.all.ransack(params[:q])
   @search = @q.result(distinct: true)
   @q.build_condition if @q.conditions.empty?
   @q.build_sort if @q.sorts.empty?    
  end

end
