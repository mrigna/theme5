class ThemesController < ApplicationController
  before_action :set_theme, only: [:show, :edit, :edit, :destroy, :new_entry, :create, :update, :mercury_update]
  after_action :count, only: :create
        
  def index
    @@count = Theme.last.id
    @id = @@count
    @themes = Theme.all.order(id: :asc)
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
    # fix multiple choice view for language    
    @theme.metadata.language = params[:content][:metadata_language][:value].delete!("\n")
    @theme.metadata.title = params[:content][:metadata_title][:value].delete!("\n")
    @theme.metadata.description = params[:content][:metadata_description][:value].delete!("\n")
    @theme.metadata.keywords = params[:content][:metadata_keywords][:value].delete!("\n")
    # fix node choice for existing nodeID in Node model 
    @theme.node_id = params[:node_id]
    @theme.html_content = params[:content][:theme_content][:value].gsub!('&nbsp;','')    
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
  
  def mercury_update
    @theme.html_content = params[:content][:theme_content][:value]
    @theme.save!   
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
      params.require(:theme).permit(:html_content, :node_attributes, :metadata_attributes)
    end

end


  
   


