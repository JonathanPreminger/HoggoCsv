require 'rails_helper'
include SearchBroker

RSpec.describe BrokersController, type: :controller do
  describe "#search" do
    subject { post :create, :params => { :broker => { :siren => "123456789" } } }

    it "redirects to widget_url(@widget)" do
      search = search(123456789)
      expect(search).to redirect_to(broker_url(assigns(:broker)))
    end

  end
end
