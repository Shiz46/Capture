class Instructor::SectionsController < ApplicationController
  #make sure there is a  user.
  before_action :authenticate_user!
    #ensure the user who created the course is the same user who logged in
  before_action :require_authorized_for_current_course, only: [:create]
  before_action :require_authorised_for_current_section, only: [:update]



  def create 
    @section = current_course.sections.create(section_params)
    redirect_to instructor_course_path(current_course)
  end 


  def update 
    current_section.update_attributes(section_params)
    render plain: 'ok!'
  end 

  private

  def current_section 
    @current_section ||= Section.find(params[:id])
  end 

  def require_authorized_for_current_course
    if current_course.user != current_user
      render plain: "Unauthorized", status: :unauthorized
    end 
  end 

  def require_authorized_for_current_section
    if current_section.course.user != current_user
      render plain: "Unauthorized", status: :unauthorized 
    end 
  end 


  helper_method :current_course
  #method used to make it accessible to each action instead of repetition.
  #remember to add to the view .html.erb file as well. 
  def current_course
      if (params[:course_id])
        @current_course ||= Course.find(params[:course_id])
      else 
        current_section.course 
      end 
  end 

  helper_method :current_section

  def current_section
    @current_section ||= Section.find(params[:section_id])
  end 

  def section_params
    params.require(:section).permit(:title, :row_order_position)
  end
end
