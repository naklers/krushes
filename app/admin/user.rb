ActiveAdmin.register User do

menu priority: 1

# Add menu option to upload CSV file
action_item :only => :index do
  link_to 'Import users from CSV file', :action => 'upload_users_csv'
end

# Menu action to launch the user import form
collection_action :upload_users_csv do
  render "admin/csv/import_users_csv"
end

# Form action to trigger user import and return to the users index in ActiveAdmin
collection_action :import_users_csv, :method => :post do
  # CsvDb.convert_save("user", params[:dump][:file])
  User.import(params[:dump][:file])
  redirect_to :action => :index, :notice => "CSV imported successfully!"
end

# Index definition: columns in the table
index do
  column :id
  column :name
  column :last_name
  column :email
  column :updated_at
  actions
end

# Sort by asc id
config.sort_order = 'id_asc'

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
#permit_params :name,:email
# or
#
permit_params [:name,:last_name,:email]

form do |f|
  f.inputs "User" do
    f.input :name
    f.input :last_name
    f.input :email
  end
  f.actions
end
#   permitted << :other if resource.something?
#   permitted
# end

# creat_after sends email to the User's email with a link to create a password
after_create { |user| user.send_reset_password_instructions }

# SO far the below is not required, for we are not yet creating admins
# def password_required?
#   new_record? ? false : super
# end

# Right-side filters enabled
filter :name, as: :select
filter :last_name, as: :string
filter :email, as: :string
filter :id, as: :string, label: 'User ID'

sidebar "Crushes", only: [:show, :edit] do
  ul do
    li link_to "Crushes", "/admin/users/#{user.id}/choices"
  end
end

end
