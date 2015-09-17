class NodesController < ApplicationController
  before_action :set_scope, only: [:home, :index, :edit]
  before_action :set_node, only: [:new, :edit, :update, :update_group, :destroy, :remove_group, :documents, :contacts, :update_contacts]
  before_action :check_language_contacts, only: [:contacts, :update_contacts]
  after_action :create, only: :update
      
  def index
    @node_select =  @q.result(distinct: true).page(params[:page]).per(20).order(nodeID: :asc)
    @title = @dg
    @last = Node.maximum(:id)
  end
  
  def check_language_contacts
    @fr = @contacts.where(xlanguage: "fr")
    @nl = @contacts.where(xlanguage: "nl")
    @de = @contacts.where(xlanguage: "de")
    @en = @contacts.where(xlanguage: "en")
    @lang = [@fr, @nl, @de, @en]
  end
  def contact
  end
    
  def update_contacts    
    lang = ["fr", "nl", "de", "en"]
   
    for i in 0..3   
    l = @lang[i]
      unless l.empty?
      puts l.first.update(body: params[:content][:"#{'contact_content_' + lang[i]}"][:value])
      end
    i += 1
    end
    render text:""
  end
    
  def documents
    @law = Document.find_by_sql "SELECT * FROM documents WHERE  xwebsitesection = #{@node.nodeID} and ddoctype = 'IE2Law'"
    @form = Document.find_by_sql "SELECT * FROM documents WHERE  xwebsitesection = #{@node.nodeID} and ddoctype = 'IE2Form'"
    @faq = Document.find_by_sql "SELECT * FROM documents WHERE  xwebsitesection = #{@node.nodeID} and ddoctype = 'IE2FAQ'"
    @divers = Document.find_by_sql "SELECT * FROM documents WHERE  xwebsitesection = #{@node.nodeID} and ddoctype = 'IE2Divers'"
    @contact = Document.find_by_sql "SELECT * FROM documents WHERE  xwebsitesection = #{@node.nodeID} and ddoctype = 'IE2Contact'"
    @link = Document.find_by_sql "SELECT * FROM documents WHERE  xwebsitesection = #{@node.nodeID} and ddoctype = 'IE2Link'"
  end
  
  def create
    @node = Node.create
  end
  
  def update
    @node.update(nodeID: Node.maximum(:nodeID) + 1)
    dg = params[:node][:dg]
    @node.update(dg: dg)
    @node.update(url_label: params[:node][:url_label])
      if params[:node][:hidden] == "1"
        @node.update(hidden: true) 
      else
        @node.update(hidden: false)
      end
    redirect_to dg_nodes_path(@node.dg)
  end
      
  def update_group
    @node.update(group: params[:node][:group]) unless params[:node][:group].blank?
    redirect_to dg_nodes_path(@node.dg)
  end

  def remove_group
    @node.update(group: nil)
    redirect_to dg_nodes_path(@node.dg)
  end
  
  def destroy
    @node.themes.update_all(node_id: 0)
    @node.destroy!
    respond_to do |format|
      format.html { redirect_to dg_nodes_path(current_user.dg), notice: 'Node was successfully destroyed.' }
    end
    
  end

  private

  def set_node
  @node = Node.find(params[:id])
      unless current_user.dg == "all"
        @group_select = Node.user(@user).where.not(group: nil).pluck(:group).uniq.sort
      else
        @group_select = Node.all.where.not(group: nil).pluck(:group).uniq.sort
      end
    @contacts  = Contact.where(node_id: @node.nodeID).order(dindate: :desc)
  end

  def set_scope
    @user = current_user.dg
     if @user == "all"
        @dg = params[:dg]
        unless @dg == "all"
        @q = Node.dg(@dg).ransack(params[:q])
        else
        @q = Node.unscoped.load.ransack(params[:q])
        end
      else
      @q = Node.user(@user).ransack(params[:q])
      end
  end

end