# Homepage (Root path)
get '/' do
  @songs = Song.all
  erb :index
end

get '/songs/new' do
  erb :'songs/new'
end

post '/' do
  @song = Song.new(
    author:  params[:author],
    title: params[:title],
    url: params[:url]
  )
  
  if @song.save
    redirect '/'
  else
    erb :'songs/new'
  end

end