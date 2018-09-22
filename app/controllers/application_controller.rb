class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    @recipe = Recipe.new
    erb :new
  end

# set up a controller action that will render a form to create a new recipe. This controller action should create and save this new recipe to the database.
  post '/recipes' do
   recipe = Recipe.create({name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time]})
   redirect "/recipes/#{recipe.id}"
  end

  # create a controller action that uses RESTful routes to display a single recipe.
get '/recipes/:id' do
  @recipe = Recipe.find_by_id(params[:id])
  erb :show
end

get '/recipes/:id/edit' do  #load edit form
  @recipe = Recipe.find_by_id(params[:id])
  erb :edit
end

patch '/recipes/:id' do   #update action
  @recipe = Recipe.create(params[:id])
  @recipe.name = params[:name]
  @recipe.ingredients = params[:ingredients]
  @recipe.cook_time = params[:cook_time]
  @recipe.save
  redirect to "/recipe/#{recipe.id}"
end

delete '/recipes/:id/delete' do
  Recipe.find_by_id(params[:id]).destroy
  redirect '/recipes'
end


end
