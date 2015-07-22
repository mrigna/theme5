class MetadataController < ThemesController
  before_action :set_theme, only: [:edit, :update]
  after_action :fetch_node, only: :edit

  def index
  end

  def edit
  end

  def update
    @meta.title = params[:metadata][:title]
    @meta.description = params[:metadata][:description]
    @meta.keywords = params[:metadata][:keywords]
    @meta.language = params[:metadata][:language]
    @theme.update(node_id: params[:node][:id]) unless params[:node][:id].blank?
    @meta.update(meta_params)
    render :js => "alert('Metadata updated!')"
  end

  private
    def meta_params
      params.require(:metadata).permit!
    end

end