enable :sessions

# Homepage (Root path)
get '/' do
  @songs = Song.all
  erb :index
end

get '/songs/new' do
  erb :'songs/new'
end

get '/songs/new' do
  erb :'songs/new'
end

get '/users' do
  session[:username] = "test" #params[:username]
  erb :'users/index'
end

get '/users/signup' do
  erb :'users/signup'
end

post '/users/signup' do 
  @user = User.new(
    username: params[:username],
    email: params[:email],
    password: params[:password]
  )

  if @user.save
    redirect '/users'
  else
    erb :'users/signup'
  end
end

get '/users/login' do
  erb :'users/login'
end

post '/users/login' do
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