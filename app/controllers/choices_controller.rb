class ChoicesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_owner, only: [:show, :edit, :update, :destroy ]

  def check_owner
    choice = Choice.find(params[:id])
    if choice.user_id != current_user.id
      redirect_to "/choices", notice: "You can only see your own personal choices!"
    end
  end

  def dual_update(choice1, choice2)
    Choice.transaction do
      choice1.save!
      choice2.save!
    end
    return true
  rescue Exception => ex
    return false
  end

  def index
    # This user's crushes and matches
    @choices = current_user.choices.order(:rank)
    # Non-matched crushes from others on this user
    @their_crushes = Choice.where({:target_id => current_user.id}).where({:matched => !true}).where({:disclose_if_no_match => true})
  end

  def show
    @choice = Choice.find(params[:id])
  end

  def new
    # All users to choose from
    # *************Pending some sort of filtering********
    @other_users = User.all_except(current_user)
    @choice = Choice.new
  end

  def create
    our_choices = current_user.choices
    our_choices_count = our_choices.count
    if our_choices_count<5
      @choice = Choice.new

      @choice.user_id = current_user.id

      @choice.target_id = params[:target_id]

      if our_choices_count>0
        @choice.rank = our_choices.maximum(:rank) + 1
      else
        @choice.rank = 1
      end

      # Matching algorithm
      @choice.matched = false
      Choice.where({:user_id => @choice.target_id }).each do |their_choice|
        # If there's a match...
        if their_choice.target_id == current_user.id
          # Create new match object
          match = Match.create!(user1_id: current_user.id, user2_id: their_choice.user_id, user1_active: true, user2_active: true)
          # Set up this choice for a match
          @choice.matched = true
          @choice.match_id = match.id
          # Set up the counterpart's choice for a match
          their_choice.matched = true
          their_choice.match_id = match.id
          their_choice.save
          break
        end
      end

      # Watch out,this currently results in lack of choice generating a "nil" value! Sort of works but is not consistent
      @choice.disclose_if_no_match = params[:disclose_if_no_match]

      if @choice.save
        redirect_to "/choices", :notice => "Choice created successfully."
      else
        render 'new', :notice => "Error when creating. Please try again"
      end
    else
      render 'new', :notice => "Reached max number of choices"
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

    # Watch out,this currently results in lack of choice generating a "nil" value! Sort of works but is not consistent
    @choice.disclose_if_no_match = params[:disclose_if_no_match]



    if @choice.save
      redirect_to "/choices", :notice => "Choice updated successfully."
    else
      render 'edit'
    end

  end

  def rank_up
    @this_choice = Choice.find(params[:id])
    this_rank = @this_choice.rank

    # Find next-higher-ranked choice
    upper_rank = this_rank - 1
    upper_choice = current_user.choices.find_by({ :rank => upper_rank})

    # Switch ranks
    @this_choice.rank = upper_rank
    upper_choice.rank = this_rank
    puts(@this_choice.rank.to_s + "turning into" + upper_choice.rank.to_s)

    if dual_update(@this_choice,upper_choice)
      redirect_to "/choices"
    else
      redirect_to "/choices", :notice => "Could not update ranking"
    end
  end

  # PENDING logic to destroy matches if the choice is removed
  def destroy
    @choice = Choice.find(params[:id])
    this_rank = @choice.rank
    this_target = @choice.target_id
    @choice.destroy

    # Remove match from counterpart choice
    Choice.where({:user_id => this_target }).each do |their_choice|
      if their_choice.target_id == current_user.id
        their_choice.matched = false
        their_choice.save
        break
      end
    end

    # Update remaining choices' ranks
    current_user.choices.each do |remaining_choice|
      if remaining_choice.rank > this_rank
        remaining_choice.rank -= 1
        remaining_choice.save
      end
    end
    redirect_to "/choices", :notice => "Crush deleted."

  end
end
