class LinksController < ApplicationController

  # GET /links
  # GET /links.json
  # Metodo da pagina inicial. Responsavel por consultar os links
  # mais acessados do dia, os ultimos cadastrados e tambem um form
  # para cadastro de links
  def index
    @link = Link.new
	
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @links }
    end
  end

  # GET /links/1
  # GET /links/1.json
  # Metodo responsavel por exibir os detalhes de um link
  def show
    @link = Link.find(params[:id])
	
	@clicks = Click.count(:all, :conditions => ["link_id = :link_id", :link_id => @link.id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @link }
    end
  end

  # POST /links
  # POST /links.json
  # Metodo responsavel por inserir um link no banco de dados
  def create
  
	# Cria o hash MD5 da string do link
    params[:link][:token] = Digest::MD5.hexdigest(params[:link][:link]).encode('UTF-8')
	
	# Verifica se este hash ja nao existe no banco. MD5 gera conflitos, mas como sao 
	# poucos links, isto nao sera problema.
	@link = Link.find_by_token params[:link][:token]
	
	# Variavel de verificacao para saber se o link foi salvo
	save = 0
	
	# Se o link nao existir no banco...
	if @link.nil? then
	
		# Obtem os dados do usuario (IP e user agent)
	  params[:link][:ip] = request.env["REMOTE_ADDR"].encode('UTF-8')
	  params[:link][:user_agent] = request.env["HTTP_USER_AGENT"].encode('UTF-8')
	  
	  # Cria o registro
	  @link = Link.new(params[:link]) 
	  
	  # Salva, verifica o salvamento e atualiza a variavel para verificacao do salvamento
	  save = @link.save ? 1 : 0
	end
 	
    respond_to do |format|
      if save == 1
        format.html { redirect_to @link, notice: 'Link adicionado com sucesso!' }
        format.json { render json: @link, status: :created, location: @link }
      else
        format.html { redirect_to @link, notice: 'Link ja adicionado anteriormente!' }
        format.json { render json: @link, status: :created, location: @link }
      end
    end
  end
  
  
  # Metodo responsavel por redirecionar o usuario ate o endereco
  # de um link
  def redirect
  
	# Obtem o token
	token = params[:token]
	
	# Pesquisa os dados do link
	@link = Link.find_by_token token
	
	# Se o link existir, redireciona, senao redireciona para a pagina
	# inicial
	if @link.nil? then
		redirect_to '/'
	else
		
		# Obtem os dados do usuario e armazena o click
		ip = request.env["REMOTE_ADDR"].encode('UTF-8')
		user_agent = request.env["HTTP_USER_AGENT"].encode('UTF-8')
		@click = Click.new({:link_id => @link.id, :ip => ip, :user_agent => user_agent})
		@click.save
		
		# Redireciona o usuario para o link correto
		redirect_to @link.link
		
	end
	
  end
  
  # Metodo responsavel por pesquisar um link cadastrado
  def search
  
	# Verifica se os parametros nao estao nulos
    if not params[:description].nil? and not params[:link][:category_id].nil? then
	
		# Formata a variavel descricao para fazer a consulta com LIKE corretamente
		description = "%" + params[:description] + "%"
		
		# Define as condicoes de busca
		conditions = "category_id = :category AND description LIKE :description"
		
		# Realiza a busca no banco de dados
		@links = Link.where(conditions, {:category => params[:link][:category_id], :description => description})
		
	end
  end

end
