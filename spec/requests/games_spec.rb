describe "Game API" do

  before do
    Player.create id: 1, name: 'Scott', wins: 0, losses: 0, win_percentage: 0
    Player.create id: 2, name: 'Zee', wins: 0, losses: 0, win_percentage: 0
    game_params = {
      "game" => {
        "winner" => "Zee",
        "loser" => "Scott"
      }
    }.to_json

    request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }

    post "/games", game_params, request_headers
  end

  it 'creates a game' do
    expect(response.status).to eq 201
    expect(Game.last.winner).to eq "Zee"
    expect(Game.last.loser).to eq "Scott"
  end

  it 'updates the scores' do
    zee = Player.find(2)
    scott = Player.find(1)
    expect(zee.wins).to eq 1
    expect(scott.losses).to eq 1
    expect(zee.losses).to eq 0
    expect(scott.wins).to eq 0
  end

  it 'updates the win percentage' do
    zee = Player.find(2)
    scott = Player.find(1)
    expect(zee.win_percentage).to eq 100
    expect(scott.win_percentage).to eq 0
  end
end
