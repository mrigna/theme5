class MetadataController < ApplicationController
  before_action :set_theme, only: :update

  def index
    @themes = Theme.node(1).order(id: :asc)
  end
  
  def update

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_theme
      @theme = Theme.find(params[:id])
      @theme.metadata ||= Metadata.new
    end

    def theme_params
      params.require(:theme).permit(:node_id, :html_content, :node_attributes, :metadata_attributes)
      params.require(:node).permit(:id)
    end
end