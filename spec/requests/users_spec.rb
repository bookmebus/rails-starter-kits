 require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/users", type: :request do

  let(:profile_pic) do
    file = Rails.root.join('spec', 'support', 'assets', 'profile_pic.jpg')

    ActiveStorage::Blob.create_after_upload!(
      io: File.open(file, 'rb'),
      filename: 'profile_pic.jpg',
      content_type: 'image/jpeg' # Or figure it out from `name` if you have non-JPEGs
    ).signed_id
  end

  let!(:user) { create(:user) }

  describe "GET /index" do
    it "renders a successful response" do
      get users_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get user_url(user, locale: :en)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_user_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      get edit_user_url(user, locale: :en)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do

      it "creates a new User" do

        valid_attrs = build(:user).attributes.slice('email', 'phone_number')

        valid_attrs =  valid_attrs.merge(
          profile_pic: profile_pic,
          password: '123456789'
        )

        expect {
          post users_url(locale: :en), params: { user: valid_attrs }
        }.to change(User, :count).by(1)
      end

      it "redirects to the created user" do
        valid_attrs = build(:user).attributes.slice('email', 'phone_number')

        valid_attrs =  valid_attrs.merge(
          profile_pic: profile_pic,
          password: '123456789'
        )

        post users_url(locale: :en), params: { user: valid_attrs }
        expect(response).to redirect_to(user_url(User.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect {
          post users_url(locale: :en), params: { user: {password: nil} }
        }.to change(User, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post users_url(locale: :en), params: { user: {password: nil} }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do

      it "updates the requested user" do
        patch user_url(user, locale: :en), params: { user: { first_name: 'Joe', last_name: 'Ann' } }
        user.reload
        expect(user.first_name).to eq 'Joe'
        expect(user.last_name).to eq 'Ann'
      end

      it "redirects to the user" do
        patch user_url(user, locale: :en), params: { user: { first_name: 'Joe', last_name: 'Ann' } }
        user.reload
        expect(response).to redirect_to(user_url(user))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        patch user_url(user, locale: :en), params: { user: {email: nil} }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested user" do
      expect {
        delete user_url(user, locale: :en)
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      delete user_url(user, locale: :en)
      expect(response).to redirect_to(users_url)
    end
  end
end
