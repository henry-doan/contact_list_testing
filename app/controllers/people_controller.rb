class PeopleController < ApplicationController
	before_action :person, only: [ :edit, :show, :update, :destroy]
	# skip_before_action :this will skip before actions

	def generate_list
		name = person.name
		render partial: 'shopping_list', locals: { name: name }
	end

  def index
  	@people = Person.all
  end

  def new
  	@person = Person.new
  end

  def create
  	@person = Person.new(person_params)
  	if @person.save
  		redirect_to person_path(@person), flash: { notice: "Person on #{@person.email} created" }
  	else
  		flash[:error] = @person.errors.full_messages.join("\n")
  		render :new
  	end
  end

  def edit
  end

  def update
  	if @person.update(person_params)
  		redirect_to person_path(@person)
  	else
  		render :edit
  	end
  end

  def show
  end

  def destroy
  	if @person.destroy
  		redirect_to people_path
  	else
  		flash[:error] = @person.errors.full_messages.join("\n")
  		redirect_to people_path
  		#TODO send back error message
  		#rediect to wherever you put the delte buttons
  	end
  end

  private

  def person_params
  	params.require(:person)
  	.permit(
  		:email,
  		:phone,
  		:first_name,
  		:last_name,
  		:age,
  		:relationship_status
  	)
  end

  def person
  	@person = Person.find(params[:id])
  	# @person = Person.find_by(id: params[:id]) || Person.new
  	# this will clean up new
  end

end
