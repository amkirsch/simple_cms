class SubjectsController < ApplicationController

  layout false

  def index
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new(name: "Default")
  end

  def create
    # Instantiate a new object using form parameters, we are using Rails 4
    # require and permit methods for params.
    # @subject = Subject.new(params.require(:subject).permit(:name, :position, :visible)) # This is the looong way
    @subject = Subject.new(subject_params) # shorter way; see below for method
    # Save the object
    if @subject.save
      # If save succeeds, redirect to the index action
      redirect_to(action: 'index')
    else
      # If save fails, redisplay the form so user can fix problems
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def delete
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :position, :visible)
  end
end
