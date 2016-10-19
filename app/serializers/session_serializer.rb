class SessionSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :token
end
