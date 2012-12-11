class UsersController < ApplicationController

  # GET /users/new
  # GET /users/new.json
  def new
  
	# Se o usuario estiver logado, redireciona para o index do controller links
	if session[:user_id].to_i > 0 then
		redirect_to 'links#index'
	end
  
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end
  
  # Metodo responsavel por efetuar o login de um usuario
  def login
  
	# Verifica se o usuario ja esta logado
	if session[:user_id].to_i > 0 then
		redirect_to '/links'
	end
  
	# Verifica se o usuario existe
	@user = User.where(:email => params[:email], :password => params[:password]).first
	
	# Se o usuario nao existir, redireciona para a pagina inicial do controller links
	if not @user.nil? then
		session[:user_id] = @user.id
		redirect_to '/links/'
	end 
	
  end
  
  # Metodo responsavel por efetuar o logout de um usuario
  def logout
	session[:user_id] = nil
	redirect_to '/users/login'
  end
  
  # POST /users
  # POST /users.json
  def create
  
	@user = User.where(:email => params[:user][:email]).first
  
	if @user.nil? then
		@user = User.new(params[:user])
	

		respond_to do |format|
		  if @user.save
			format.html { redirect_to '/', notice: 'User was successfully created.' }
			#format.json { render json: @link, status: :created, location: @link }
		  else
			#format.html { render action: "new" }
			#format.json { render json: @user.errors, status: :unprocessable_entity }
		  end
		end
		
	else
		respond_to do |format|
			format.html { redirect_to '/users/new', notice: 'Usuario ja existente.' }
		end
	end
	
  end

end
