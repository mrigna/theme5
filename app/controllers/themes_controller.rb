class ThemesController < ApplicationController
  before_action :set_theme, only: [:show, :edit, :edit, :destroy, :new_entry, :create, :update, :mercury_update]
  after_action :count, only: :create
  after_action :fetch_node, only: :new_entry
  after_action :fetch_lang, only: :new_entry

  def index
    @select = []
    @@count = Theme.last.id
    @id = @@count
    @themes = Theme.node(params[:id]).order(id: :asc)
    @dg = @themes.first.node.dg
  end
   
  def show
  end
  
  def generate
     @theme = Theme.new
     @theme.id = @@count
     @theme.contentID  = "new_"+ DateTime.now.to_s(:number)
     @theme.save!
  end
  
  def create   
    @theme.metadata.title = params[:content][:metadata_title][:value].delete!("\n")
    @theme.metadata.description = params[:content][:metadata_description][:value].delete!("\n")
    @theme.metadata.keywords = params[:content][:metadata_keywords][:value].delete!("\n")
    @theme.html_content = params[:content][:theme_content][:value]
    @theme.save!   
   render text: ""
  end  
  
  def count
    @@count = Theme.last.id + 1
    generate
  end
  
  def new_entry
  end
  
  def update    
  end
      
  def fetch_node
      n = params[:node_id]
      unless n.nil?
        node = Node.find(n)
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
    format.html { redirect_to root_path, notice: 'Theme was successfully destroyed.' }
    end
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


  
   


