RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration
  config.included_models = ["Term", "Menu"]
  config.main_app_name = ['Taxonomy', 'Taxonomy Manager']
  
  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    #show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
    
     # Add the nestable action for configured models
    nestable
  end
  
  config.model Term do
  nestable_tree({
    position_field: :position,
    max_depth: 5
  })
    label_plural "Vocabulary"
  end
  
  config.model Menu do
  nestable_tree({
    position_field: :position,
    max_depth: 5
  })
    label_plural "Menu"
  end
 
end
