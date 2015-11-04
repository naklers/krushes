ActiveAdmin.register User do

menu priority: 1



# Index definition: columns in the table
index do
  column :id
  column :name
  column :email
  column :updated_at
  actions
end

# Sort by asc id
config.sort_order = 'id_asc'

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name,:email
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

# Right-side filters enabled
filter :name, as: :select
filter :email, as: :string
filter :id, as: :string, label: 'User ID'

sidebar "Crushes", only: [:show, :edit] do
    ul do
      li link_to "Crushes", "/admin/users/#{user.id}/choices"
    end
  end

end
