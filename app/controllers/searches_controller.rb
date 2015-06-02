class SearchesController < ApplicationController
 
  def index
    @q = Theme.all.ransack(params[:q])
    
    ##### Grouping queries by OR instead of AND #####
    #@q = Theme.all.ransack(params[:q].try(:merge, m: 'or'))
    #  Normally, if you wanted users to be able to toggle between AND and OR query grouping, you would probably set up your search form so that m was in the URL params hash  

    
   @search = @q.result(distinct: true).includes(:node, :metadata)
   @q.build_condition if @q.conditions.empty?
   @q.build_sort if @q.sorts.empty?    
  end

end
