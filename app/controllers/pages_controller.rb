class PagesController < ApplicationController
  def index
    @pages = Page.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new(name: "Default Page")
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:notice] = "Page successfully created."
      redirect_to(action: 'show', id: @page.id)
    else
      flash[:notice] = "Page failed to save!"
      render('new')
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  def destroy
  end

  private

  def page_params
    params.require(:page).permit(:name, :position, :visible, :permalink)
  end

end
