class LinksController < ApplicationController
  # GET /links
  # GET /links.json
  def index
    @links = Link.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @links }
    end
  end

  # GET /links/1
  # GET /links/1.json
  def show
    @link = Link.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @link }
    end
  end

  # GET /links/new
  # GET /links/new.json
  def new

    @link = Link.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @link }
    end

  end

  # GET /links/1/edit
  def edit
    @link = Link.find(params[:id])
  end

  # POST /links
  # POST /links.json
  def create

    # Gera o hash MD5 do link
    params[:link][:token] = Digest::MD5.hexdigest params[:link][:link]

    # Verifica se o link ja existe no banco
    @link = Link.find_by_token(params[:link][:token])
    
    # Link ainda nao foi salvo
    save = 0

    # Se o link nao for encontrado, salva o link no banco
    if @link.nil? then

      # Dados do usuario
      params[:link][:ip] = request.env["REMOTE_ADDR"]
      params[:link][:user_agent] = request.env["HTTP_USER_AGENT"]

      # Cria o link
      @link = Link.new(params[:link])

      # Tenta salvar
      save = @link.save ? 1 : 0

    end

    respond_to do |format|
      if save == 1
        format.html { redirect_to @link, :notice => 'Link salvo com sucesso.' }
        format.json { render :json => @link, :status => :created, :location => @link }
      else
        format.html { redirect_to @link, :notice => 'O link já foi criado anteriormente.' }
        format.json { render :json => @link.errors, :status => :unprocessable_entity }
      end
    end
  end


  # Metodo para redirecionamento
  def redirect
    @link = Link.find_by_token(params[:token])
    if @link.nil? then
	redirect_to '/'
    else
	redirect_to @link.link
    end
  end

end
