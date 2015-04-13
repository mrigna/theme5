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
     @meta = Metadata.create
     @theme.id = @@count
     @theme.contentID  = "new_"+ DateTime.now.to_s(:number)
     @meta.contentID = @theme.contentID
     @theme.save!
     @meta.save!
  end
  
  def create
    @meta.language = params[:content][:meta_language][:value].delete!("\n")
    @meta.title = params[:content][:meta_title][:value].delete!("\n")
    @meta.description = params[:content][:meta_description][:value].delete!("\n")
    @meta.keywords = params[:content][:meta_keywords][:value].delete!("\n")
    @theme.html_content = params[:content][:theme_content][:value].gsub!('&nbsp;','')    
    @theme.save!
    @meta.save!
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
    @meta = Metadata.find_by(:contentID => @theme.contentID)
    @node = Node.find_by(:nodeID => @theme.nodeID)
    end
    
    def theme_params
    params.require(:theme).permit(:html_content)
    params.require(:metadata).permit(:language, :title, :description, :keywords)
    params.require(:node).permit(:dg)
    end

end


  
   


