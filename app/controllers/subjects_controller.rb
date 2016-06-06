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
      flash[:notice] = "Subject created successfully."
      redirect_to(action: 'index')
    else
      # If save fails, redisplay the form so user can fix problems
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    # Find an existing object using form parameters, we are using Rails 4
    # require and permit methods for params.
    # @subject = Subject.new(params.require(:subject).permit(:name, :position, :visible)) # This is the looong way
    @subject = Subject.find(params[:id])
    # Update the object
    if @subject.update_attributes(subject_params)
      # If update succeeds, show the updated subject
      flash[:notice] = "Subject updated successfully." # "flash hash"
      redirect_to(action: 'show', id: @subject.id)
    else
      # If update fails, redisplay the form so user can fix problems
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    # using local variables since this will never display a template!
    subject = Subject.find(params[:id])
    # Delete the object
    subject.destroy
    flash[:notice] = "Subject #{subject.name} deleted successfully."
    redirect_to(action: 'index')
  end

  private

  def subject_params
    # same as using "params[:subject]", except that it:
    # - raises an error if :subject is not present
    # - allows listed attributed to be mass assigned
    params.require(:subject).permit(:name, :position, :visible)
  end
end
