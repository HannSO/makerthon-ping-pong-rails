require 'spec_helper'

describe PlayersController do
  it "returns all the players" do
    FactoryGirl.create :player, name: "HANNAH"
    get('/')

    expect(response.status).to eq 200

    body = JSON.parse(response.body)
    username = body.map { |m| m["name"] }

    expect(username).to include("HANNAH")
  end
end
