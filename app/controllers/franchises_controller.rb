class FranchisesController < ApplicationController
	before_action :Admins_authorise, only:[:new, :create, :edit, :update, :destroy]
	def index
		@franchise = Franchise.all
	end
	def new
		@franchise = Franchise.new
	end
	def create
		@franchise = Franchise.new(franchise_params)
	    if @franchise.save
	      flash[:success] = "Kurry saved!"
	      redirect_to franchises_path
	    else
	    	flash[:error] = "Kurry not saved!, enter the details correctly"
	      render :new
    	end
	end
	
	def edit
		@franchise = set_franchise
	end
	def update
		@franchise = set_franchise
		@franchise.update_attributes(franchise_params)

	end
	def destroy
		Franchise.find_by(params[:user_id]).destroy
		render :index
	end

	def franchise_params
    params.require(:franchise).permit(:date, :amount, :person, :title, :chit_type_id)
  end
end
