require 'rails_helper'
require 'ostruct'

RSpec.describe AuthorizePolicyController, type: :controller do

  controller do
    def index
      head :ok
    end

    def new
      head :ok
    end

  end

  context "with no cookies" do
    it "raise policy not allows" do
      expect { get :index }.to raise_error(UnauthorizedError)
    end

    it 'ok policy match' do
      context = OpenStruct.new("success?": true)
      allow(AuthorizePolicy).to receive(:call).and_return(context)
      get :new
    end
  end

end
