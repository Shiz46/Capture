class Instructor::SectionsController < ApplicationController
  #make sure there is a  user.
  before_action :authenticate_user!
    #ensure the user who created the course is the same user who logged in
  before_action :require_authorized_for_current_course

  def new 
    @section = Section.new
  end 

  def create 

    @section = current_course.sections.create(section_params)
    redirect_to instructor_course_path(current_course)
  end 

  private

  def require_authorized_for_current_course
    if current_course.user != current_user
      render plain: "Unauthorized", status: :unauthorized
    end 
  end 


  helper_method :current_course
  #method used to make it accessible to each action instead of repetition.
  #remember to add to the view .html.erb file as well. 
  def current_course
      @current_course ||= Course.find(params[:course_id])
  end 

  def section_params
    params.require(:section).permit(:title)
  end
end
