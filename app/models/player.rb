class Player < ActiveRecord::Base
  has_many :games
  validates :name, length: {minimum: 3}

  def self.update_results(winner, loser)
    update_wins(winner)
    update_losses(loser)
    calculate_win_percentage(winner)
    calculate_win_percentage(loser)
  end

  def self.update_wins(winner)
    id = Player.find_by(name: winner).id
    Player.increment_counter(:wins, id)
  end

  def self.update_losses(loser)
    id = Player.find_by(name: loser).id
    Player.increment_counter(:losses, id)
  end

  def self.calculate_win_percentage(player)
    wins = Player.find_by(name:player).wins
    losses = Player.find_by(name:player).losses
    record = Player.find_by(name: player)
    percentage_calculation = ((wins /(wins + losses.to_f)) * 100).round(2)
    record.update_columns(win_percentage: percentage_calculation)
  end

  def self.add_slack_users
    uri = URI.parse("https://slack.com/api")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new("/users.list?token="+ENV['TOKEN']+"&pretty=1")
    response = http.request(request)
    parsed_matches = JSON.parse(response.body)["id"]
    parsed_matches.each do |key, val|
      if val != "slackbot" && !Player.exists?(val)
        Player.create(name: val, wins: 0, losses: 0, win_percentage: 0)
      end
    end
  end
end
