ActiveAdmin.register User do
  permit_params :email, :username, :first_name, :last_name, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :email
    column :username
    column :first_name
    column :last_name
    column :created_at
    column :updated_at
    actions
  end

  filter :email
  filter :username
  filter :first_name
  filter :last_name
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :username
      f.input :first_name
      f.input :last_name
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :email
      row :username
      row :first_name
      row :last_name
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
