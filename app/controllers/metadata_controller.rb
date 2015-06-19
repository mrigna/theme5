class MetadataController < ThemesController
  before_action :set_theme, only: [:edit, :update]
  after_action :fetch_node, only: :edit
  before_action :save_my_previous_url, only: :edit

  def index
  end

  def edit
  end

  def update
    @meta.update(title: params[:metadata][:title])
    @meta.update(description: params[:metadata][:description])
    @meta.update(keywords: params[:metadata][:keywords])
    @meta.update(language: params[:metadata][:language])
    unless  @theme.node.nil?
      redirect_to node_themes_path(@theme.node_id)
    else 
      redirect_to root_path
    end
  end



end