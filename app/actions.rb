# Homepage (Root path)
get '/' do
  @username = session[:username]
  @id = session[:id]
  @songs = Song.all.order(upvote: :desc)
  erb :index
end

get '/songs/new' do
  erb :'songs/new'
end

post '/songs/upvote' do
  updated = Song.find(params[:song_id]).increment(:upvote)
  updated.save
  redirect '/'
end

get '/users/signup' do
  erb :'users/signup'
end

post '/users/signup' do 
  unless params[:password].empty?
    encrypted = Digest::MD5.hexdigest(APP_SECRET + params[:password])
  end
  @user = User.new(
    username: params[:username],
    email: params[:email],
    password: encrypted
  )

  if @user.save   
    redirect '/users/login'
  else
    @errors = @user.errors
    erb :'users/signup'
  end
end

get '/users/login' do
  erb :'users/login'
end

post '/users/login' do
  encrypted = Digest::MD5.hexdigest(APP_SECRET + params[:password])
  result = User.find_by('username = ? AND password = ?', params[:username], encrypted)
  if result.nil?
    @errors=["Username or password is not correct"]
    erb :'users/login'
  else
    session[:username] = result.username
    session[:id] = result.id
    redirect "/"
  end
end

post '/users/logout' do
  session[:username] = nil
  session[:id] = nil
  redirect '/'
end

get '/users/:id' do
  @user = User.find(params[:id])
  if @user.nil?
    redirect '/'
  end
  @songs = Song.where(user_id: params[:id]).order(upvote: :desc)
  erb :'users/index'
end

post '/' do
  @song = Song.new(
    author:  params[:author],
    title: params[:title],
    url: params[:url],
    user_id: session[:id],
    upvote: 0
  )
  
  if @song.save
    redirect '/'
  else
    @errors = @song.errors
    erb :'songs/new'
  end

end

get '/test' do
  session[:username]
end