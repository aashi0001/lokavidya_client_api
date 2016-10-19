class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :password, :phone, :password_confirmation, :confirmation_link, :is_active, :uuid
end
