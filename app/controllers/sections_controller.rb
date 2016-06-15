class SectionsController < ApplicationController

  layout 'admin'

  before_action :confirm_logged_in
  before_action :find_page

  def destroy
    section = Section.find(params[:id])
    section.destroy
    flash[:notice] = "Section was deleted."
    redirect_to(action: 'index', page_id: @page.id)
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
      redirect_to(action: 'show', id: @section.id, page_id: @page.id)
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
      redirect_to(action: 'show', id: @section.id, page_id: @page.id)
    else
      flash[:notice] = "Section was not created."
      @section_count = Section.count + 1
      @pages = Page.order('position ASC')
      render('new')
    end
  end

  def new
    @section = Section.new({page_id: @page.id, name: "Default Section"})
    # @pages = Page.order('position ASC')  # used for ALL pages as options
    # @pages = @page.subject.pages.sorted  # used for pages ONLY for this subject
    @pages = [@page]  # used to give only THIS page as option, must be array due to map function
    @section_count = Section.count + 1 # increment count within new (for display)
  end

  def index
    @sections = @page.sections.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  private

  def section_params # strong params
    params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
  end

  # used to define the current pages, since we will be passing object_id's
  # around -- the passing around is to help with our nesting behavior!
  def find_page
    if params[:page_id]
      @page = Page.find(params[:page_id])
    end
  end

end
