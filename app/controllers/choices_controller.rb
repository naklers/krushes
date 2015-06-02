class ChoicesController < ApplicationController
  before_action :check_owner, only: [:show, :edit, :update, :destroy ]

  def check_owner
    choice = Choice.find(params[:id])
    if choice.user_id != current_user.id
      redirect_to "/choices", notice: "You can only see your own personal choices!"
    end
  end

  def index
    @choices = current_user.choices
  end

  def show
    @choice = Choice.find(params[:id])
  end

  def new
    @choice = Choice.new
  end

  def create
    @choice = Choice.new

    @choice.user_id = current_user.id

    @choice.target_id = params[:target_id]

    @choice.rank = params[:rank]

    # HERE GOES THE KEY CODE!
    @choice.matched = false
    Choice.where({:user_id => @choice.target_id }).each do |their_choice|
      if their_choice.target_id == current_user.id
        # Set up this choice for a match
        @choice.matched = true
        # Set up the counterpart's choice for a match
        their_choice.matched = true
        their_choice.save
        break
      end
    end

    @choice.disclose_if_no_match = params[:disclose_if_no_match]

    if @choice.save
      redirect_to "/choices", :notice => "Choice created successfully."
    else
      render 'new'
    end

  end

  def edit
    @choice = Choice.find(params[:id])
  end

  def update
    @choice = Choice.find(params[:id])

    @choice.target_id = params[:target_id]

    @choice.rank = params[:rank]

    @choice.matched = params[:matched]

    @choice.disclose_if_no_match = params[:disclose_if_no_match]



    if @choice.save
      redirect_to "/choices", :notice => "Choice updated successfully."
    else
      render 'edit'
    end

  end

  def destroy
    @choice = Choice.find(params[:id])

    @choice.destroy


    redirect_to "/choices", :notice => "Choice deleted."

  end
end
