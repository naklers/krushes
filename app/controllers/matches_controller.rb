class MatchesController < ApplicationController
  def index
    @matches = Match.all
  end

  def show
    @match = Match.find(params[:id])
  end

  def new
    @match = Match.new
  end

  def create
    @match = Match.new

    @match.user1_id = params[:user1_id]

    @match.user2_id = params[:user2_id]

    @match.user1_active = params[:user1_active]

    @match.user2_active = params[:user2_active]



    if @match.save
      redirect_to "/matches", :notice => "Match created successfully."
    else
      render 'new'
    end

  end

  def edit
    @match = Match.find(params[:id])
  end

  def update
    @match = Match.find(params[:id])


    @match.user1_id = params[:user1_id]

    @match.user2_id = params[:user2_id]

    @match.user1_active = params[:user1_active]

    @match.user2_active = params[:user2_active]



    if @match.save
      redirect_to "/matches", :notice => "Match updated successfully."
    else
      render 'edit'
    end

  end

  def destroy
    @match = Match.find(params[:id])

    @match.destroy


    redirect_to "/matches", :notice => "Match deleted."

  end
end
