class MetadataController < ThemesController
  before_action :set_theme, only: [:edit, :update, :vocabulary]
  before_action :vocabulary, only: :edit
  

  def index
  end
  
  def vocabulary
    @terms = ancestry_options(Term.to_depth(3).lang(@meta.language).dg(Node.find(Theme.find(@meta.theme_id).node_id).dg).arrange(:order => 'tid')) {|i| "#{'-' * i.depth} #{i.title}" }
  end

  def edit
  end

  def update
    @meta.title = params[:metadata][:title]
    @meta.description = params[:metadata][:description]
    @meta.keywords = params[:metadata][:keywords]
    @meta.language = params[:metadata][:language]
    @meta.term1_id = params[:metadata][:term1_id]
    @meta.term2_id = params[:metadata][:term2_id]
    if current_user.dg == "all"
      @theme.update(node_id: params[:node][:id]) unless params[:node][:id].blank?
    end
    @meta.update(meta_params)
    render :js => "alert('Metadata updated!')"
  end

  private
    def meta_params
      params.require(:metadata).permit!
    end
  
    def ancestry_options(items, &block)
      return ancestry_options(items){ |i| "#{'-' * i.depth} #{i.title}" } unless block_given?

      result = []
      items.map do |item, sub_items|
        result << [yield(item), item.id]
        #this is a recursive call:
        result += ancestry_options(sub_items, &block)
      end
      result
    end

end