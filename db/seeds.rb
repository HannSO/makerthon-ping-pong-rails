player_list = [
  [ "Zeshan", 14,14,50 ],
  [ "Hannah", 7,7,50 ],
  [ "Scott", 98,0,100 ],
  [ "Mo", 0,0,0 ],
  [ "Arnold", 0,0,0 ],
  [ "Rufus", 0,0,0 ],
  [ "Rachel", 0,7,0 ],
  [ "Sean", 2,2,50 ],
  [ "Constantin", 0,0,0 ],
  [ "Marcus", 0,50,0 ],
  ["Nikesh", 0,100,0]
]

player_list.each do |name, wins, losses, win_percentage|
  Player.create( name: name, wins: wins, losses: losses, win_percentage: win_percentage)
end
