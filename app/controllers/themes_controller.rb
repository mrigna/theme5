class ThemesController < ApplicationController
  before_action :set_theme, only: [:show, :edit, :destroy, :new_entry, :create, :update, :mercury_update, :check]
  after_action :generate, only: :create
  after_action :fetch_node, only: :new_entry
  after_action :fetch_lang, only: :new_entry

  def index
    if current_user.dg == Node.find(params[:node_id]).dg or current_user.dg == "all"
    @themes = Theme.node(params[:node_id]).order(id: :asc)
    session[:last_page] = request.env['HTTP_REFERER']
    else
      render 'not_allowed'
    end
  end  

  def check
    if  params[:theme][:check_com] == "1"
      @theme.update_column(:check_com, true)
    elsif params[:theme][:check_com] == "0"
      @theme.update_column(:check_com, false)
    elsif  params[:theme][:check_dg] == "1"
      @theme.update_column(:check_dg, true)
    elsif params[:theme][:check_dg] == "0"
      @theme.update_column(:check_dg, false)
    end
    render text: ""
  end

  def show
  end

  def generate
     @theme = Theme.create
     @theme.contentID  = "new_"+ DateTime.now.to_s(:number)
     @theme.save!
  end

  def create
    ### update metadata ####
    @theme.update(html_content: params[:content][:theme_content][:value])
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
      params.require(:theme).permit(:node_id, :html_content, :check_com, :check_dg, :node_attributes, :metadata_attributes)
      params.require(:node).permit(:id)
    end

end






