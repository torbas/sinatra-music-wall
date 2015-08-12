helpers do 
  def current_user
    User.find(session[:id]) if session[:id]
  end
  def get_review(song_id)
    Review.find_by('user_id = ? AND song_id = ?', session[:id], song_id) if session[:id]
  end
end

# Homepage (Root path)
get '/' do
  @username = session[:username]
  @id = session[:id]
  @songs = Song.all.order(upvote: :desc)
  erb :index
end

get '/songs/new' do
  unless current_user
    redirect '/users/login'
  end
  erb :'songs/new'
end

get '/songs/show/?' do
  erb :'songs/show'
end

get '/songs/show/:id' do
  @song = Song.find(params[:id])
  @reviews = Review.where(song_id: params[:id])
  erb :'songs/show'
end

get '/users/signup' do
  if current_user
    redirect '/'
  end
  erb :'users/signup'
end

get '/users/login' do
  if current_user
    redirect '/'
  end
  erb :'users/login'
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
  session.clear
  redirect '/'
end

get '/users/:id' do
  unless current_user
    redirect '/'
  end
  @user = current_user
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

post '/songs/upvote' do
  updated = Upvote.new(
    song_id: params[:song_id],
    user_id: session[:id]
  )

  updated.save
  redirect '/'
end

post '/songs/review' do
  review = Review.new(
    song_id: params[:song_id],
    user_id: session[:id],
    content: params[:content].chomp
  )
  msg = 'Sorry but review wasn\'t saved'

  if check_review_exist(params[:song_id])
    msg = 'Sorry but you can only review once'
  end

  unless review.save 
    redirect '/songs/show/' << params[:song_id], notice: msg
  end

  redirect '/songs/show/' << params[:song_id]
end

post '/songs/reviews/delete' do
  get_review(params[:song_id]).destroy
  redirect '/songs/show/' << params[:song_id]
end