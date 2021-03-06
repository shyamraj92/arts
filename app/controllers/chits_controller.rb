class ChitsController < ApplicationController
	before_action :Admins_authorise, only:[:new, :create, :show]
  before_action :authorise, only:[:list]
  before_action :set_franchise, only: [:new, :create, :list, :show]
	include ApplicationHelper
	def new
    @chit = @franchise.chits.new
  end

  def create
    @chit = @franchise.chits.new(users_params)
    if @chit.save
      flash[:success] = "Chit details saved!"
      @caller = Member.find_by_name(@chit.person_called)
      @caller.update_attribute(:chit_id, @chit.id)
      #send_chit_details(@chit)
      redirect_to franchise_pages_path(@franchise)
    else
       redirect_to new_franchise_chit_path(@franchise)
    end
  end
  def list
 		@chits = @franchise.chits.all
 	end
  def show
    @chit =  @franchise.chits.find_by_id(params[:id])
  end
  private

  def users_params
    params.require(:chit).permit(:date, :amount_recieved, :person_called, :bar)
  end
end
