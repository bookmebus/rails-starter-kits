class UserAccessTokenSerializer < ActiveModel::Serializer
  attributes :id, :display_name, :profile_pic_collection_urls, :access_token, :account_name

  def access_token
    object.dispatched_jwt_access_token
  end
end
