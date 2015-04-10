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
     @theme.save!
  end
  
  def create
    #@metadata.title = params[:content][:theme_title][:value].delete!("\n")
    #@metadata.description = params[:content][:theme_description][:value].delete!("\n")
    #@metadata.keywords = params[:content][:theme_keywords][:value].delete!("\n")
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
    end
    def theme_params
    params.require(:theme).permit(:html_content)
    end
  
    def counter
  
    end 
end


  
   


