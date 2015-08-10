# Homepage (Root path)
get '/' do
  @songs = Song.all
  erb :index
end
