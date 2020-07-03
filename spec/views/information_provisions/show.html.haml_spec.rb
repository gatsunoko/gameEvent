require 'rails_helper'

RSpec.describe "information_provisions/show", type: :view do
  before(:each) do
    @information_provision = assign(:information_provision, InformationProvision.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
