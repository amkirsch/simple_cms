class PagesController < ApplicationController

  layout 'admin'

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
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_params)
      flash[:notice] = "Page successfully updated."
      redirect_to(action: 'index')
    else
      flash[:notice] = "Page failed to update!"
      render('update')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    page = Page.find(params[:id])
    page.destroy
    flash[:notice] = "Page was deleted successfully!"
    redirect_to(action: 'index')
  end

  private

  def page_params
    params.require(:page).permit(:name, :position, :visible, :permalink)
  end

end
