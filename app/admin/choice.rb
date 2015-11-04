ActiveAdmin.register Choice do

belongs_to :user
navigation_menu :user

# Index definition: columns in the table
index do
  column "Crush rank", :rank
  column "Targer User ID", :target_id
  column "Matched?", :matched
  column "Disclose even if no match?", :disclose_if_no_match
  column :updated_at
  actions
end

#Sort by asc id
config.sort_order = 'target_id_asc'

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# UPDATING CRUSHES ALLOWED
permit_params :rank

# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

# No filtering, as crushes are only show on a per-user basis
config.filters = false

end
