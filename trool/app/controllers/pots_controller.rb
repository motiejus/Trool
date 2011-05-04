require ::Rails.root.to_s+'/app/models/pot.rb'

class PotsController < ApplicationController
  # GET /pots
  # GET /pots.xml
  def index
    @pots = Pot.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pots }
    end
  end

  # GET /pots/1
  # GET /pots/1.xml
  def show
    @pot = Pot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pot }
    end
  end

  # GET /pots/new
  # GET /pots/new.xml
  def new
    @pot = Pot.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pot }
    end
  end

  # GET /pots/1/edit
  def edit
    @pot = Pot.find(params[:id])
  end

  # POST /pots
  # POST /pots.xml
  def create
    # Parse pot file header
    potdata = params[:pot][:filedata]
    parser = PotInputParser.new potdata

    # Form a hash for creating a Pot object
    data = {
      :filedata => potdata,
    }.merge parser.parse_meta
    @pot = Pot.new(data)

    respond_to do |format|
      if @pot.save
        format.html { redirect_to(@pot, :notice => 'Pot was successfully created.') }
        format.xml  { render :xml => @pot, :status => :created, :location => @pot }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pots/1
  # PUT /pots/1.xml
  def update
    potdata = params[:pot][:filedata]
    @pot = Pot.find(params[:id])

    respond_to do |format|
      if @pot.update_data potdata
        format.html { redirect_to(@pot, :notice => 'Pot was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pots/1
  # DELETE /pots/1.xml
  def destroy
    @pot = Pot.find(params[:id])
    @pot.destroy

    respond_to do |format|
      format.html { redirect_to(pots_url) }
      format.xml  { head :ok }
    end
  end
end
