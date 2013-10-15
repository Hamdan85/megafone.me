class StatementsController < ApplicationController

  before_filter :authenticate_user!, :only => [:listuncleared, :cleared]

  # GET /statements
  # GET /statements.json
  def index
    @statement = Statement.last

    @statement.name = @statement.name.split(' ')
    @statement.name = @statement.name.first + ' ' + @statement.name.last

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statements }
    end
  end

  # GET /statements/1
  # GET /statements/1.json
  def show

    #lembrar do case sensitive
    @statement = Statement.find_by_name(params[:id].gsub('-', ' '))

    if @statement
      if @statement.cleared == false
        respond_to do |format|
          format.html { redirect_to notcleared_path }
        end
      end
    else
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
        format.xml  { head :not_found }
        format.any  { head :not_found }
      end
    end
  end

  # GET /statements/new
  # GET /statements/new.json
  def new
    @statement = Statement.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @statement }
    end
  end

  # GET /statements/1/edit
  def edit
    @statement = Statement.find(params[:id])
  end

  # POST /statements
  # POST /statements.json
  def create
    @statement = Statement.new(params[:statement])

    respond_to do |format|
      if @statement.save
        format.html { thanks(@statement.name) }
      else
        format.html { render action: "new" }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /statements/1
  # PUT /statements/1.json
  def update
    @statement = Statement.find(params[:id])

    respond_to do |format|
      if @statement.update_attributes(params[:statement])
        format.html { redirect_to @statement, notice: 'Statement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statements/1
  # DELETE /statements/1.json
  def destroy
    @statement = Statement.find(params[:id])
    @statement.destroy

    respond_to do |format|
      format.html { redirect_to statements_url }
      format.json { head :no_content }
    end
  end

  def showstate
    @statement = Statement.find_by_name(params[:id].gsub('-', ' '))

    if @statement
      if @statement.cleared == false
        respond_to do |format|
          format.html { redirect_to 'statement#notcleared' }
        end
      end
    else
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
        format.xml  { head :not_found }
        format.any  { head :not_found }
      end
    end

  end

  def listuncleared

    if current_user.id == 1
      @statements = Statement.where("cleared = ?", false).all

    else
      respond_to do |format|
        format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
        format.xml  { head :not_found }
        format.any  { head :not_found }
      end
    end
  end

  def cleared

    @statement = Statement.find(params[:id])

    if current_user.id == 1
      @statement.cleared = true
    end

    respond_to do |format|
      if @statement.save!
        format.html { redirect_to '/review', notice: 'Statement was successfully created.' }
        format.json { render json: @statement, status: :created, location: @statement }
      else
        format.html { redirect_to '/review' }
        format.json { render json: @statement.errors, status: :unprocessable_entity }
      end
    end
  end

  def notcleared

  end
end
