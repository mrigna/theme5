class MetadataController < ThemesController
  before_action :set_theme, only: [:edit, :update]

  def index
  end

  def edit
  end

  def update
    @meta.update(title: params[:metadata][:title])
    @meta.update(description: params[:metadata][:description])
    @meta.update(keywords: params[:metadata][:keywords])
    @meta.update(language: params[:metadata][:language])
    redirect_to node_themes_path(@theme.node_id)
  end



end