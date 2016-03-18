describe "Players API" do

  it 'sends a list of players' do
    FactoryGirl.create :player, name: 'Zee'
    get "/", {}, { "Accept" => "application/json" }
    expect(response.status).to eq 200
    body = JSON.parse(response.body)
    player_name = body.map { |m| m["name"] }
    expect(player_name).to include 'Zee'
  end

end
