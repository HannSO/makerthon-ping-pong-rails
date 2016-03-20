class Player < ActiveRecord::Base
  has_many :games
  validates :name, length: {minimum: 3}

  def self.update_results(winner_name, loser_name)
    winner = Player.find_by(name: winner_name)
    winner.update_wins
    winner.calculate_win_percentage

    loser = Player.find_by(name:loser_name)
    loser.update_losses
    loser.calculate_win_percentage
  end

  def update_wins
    Player.increment_counter(:wins, id)
  end

  def update_losses
    Player.increment_counter(:losses, id)
  end

  def calculate_win_percentage
    percentage_calculation = ((self.wins/(self.wins + self.losses).to_f) * 100).round(2)
    self.update_columns(win_percentage: percentage_calculation)
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
