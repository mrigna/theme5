class ThemesController < ApplicationController
  before_action :set_theme, only: [:show, :edit, :destroy, :new_entry, :create, :update, :mercury_update]
  after_action :generate, only: :create
  after_action :fetch_node, only: :new_entry
  after_action :fetch_lang, only: :new_entry


  def index
    @themes = Theme.node(params[:node_id]).order(id: :asc)
    session[:last_page] = request.env['HTTP_REFERER']
  end

  def show
  end

  def generate
     @theme = Theme.create
     @theme.contentID  = "new_"+ DateTime.now.to_s(:number)
     @theme.save!
  end

  def create
    @theme.metadata.title = Sanitize.clean(params[:content][:metadata_title][:value].gsub!("&nbsp;", ""))
    @theme.metadata.description = Sanitize.clean(params[:content][:metadata_description][:value].gsub!("&nbsp;", ""))
    @theme.metadata.keywords = Sanitize.clean(params[:content][:metadata_keywords][:value].gsub!("&nbsp;", ""))
    @theme.html_content = params[:content][:theme_content][:value]
    @theme.save!
    render text: ""
  end

  def new_entry
  end

  def update
    session[:last_page] = request.path
  end

  def fetch_node
     unless params[:node_id].blank? == true
        node = Node.find(params[:node_id])
        @theme.update(node_id: node.id)
      end
  end

  def fetch_lang
      unless params[:lang].blank? == true
        @theme.metadata.update(language: params[:lang])
     end
  end

  def mercury_update
    @theme.html_content = params[:content][:theme_content][:value]
    @theme.save
    render text: ""
  end

  def destroy
    @theme.destroy
    respond_to do |format|
      format.html { redirect_to node_themes_path(@theme.node_id), notice: 'Theme was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_theme
      @theme = Theme.find(params[:id])
      @theme.metadata ||= Metadata.new
      @meta = @theme.metadata
    end

    def theme_params
      params.require(:theme).permit(:node_id, :html_content, :node_attributes, :metadata_attributes)
      params.require(:node).permit(:id)
    end

end






