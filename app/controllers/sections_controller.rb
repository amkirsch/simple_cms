class SectionsController < ApplicationController

  layout 'admin'

  before_action :confirm_logged_in

  def destroy
    section = Section.find(params[:id])
    section.destroy
    flash[:notice] = "Section was deleted."
    redirect_to(action: 'index')
  end

  def delete
    @section = Section.find(params[:id])
  end

  def edit
    @section = Section.find(params[:id])
    @pages = Page.order('position ASC')
    @section_count = Section.count + 1
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      flash[:notice] = "Section updated successfully."
      redirect_to(action: 'show', id: @section.id)
    else
      flash[:notice] = "Section was not updated."
      @pages = Page.order('position ASC')
      @section_count = Section.count + 1
      render('edit')
    end
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      flash[:notice] = "Section created successfully."
      redirect_to(action: 'show', id: @section.id)
    else
      flash[:notice] = "Section was not created."
      @section_count = Section.count + 1
      @pages = Page.order('position ASC')
      render('new')
    end
  end

  def new
    @section = Section.new(name: "Default Section")
    @pages = Page.order('position ASC')
    @section_count = Section.count + 1
  end

  def index
    @sections = Section.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  private

  def section_params
    params.require(:section).permit(:name, :position, :visible, :content_type, :content)
  end
end
