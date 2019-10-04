class LessonsController < ApplicationController 
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course

  def show 
  end 

  private
  
  def require_authorized_for_current_course
    if current_course.user != current_user
      #redirect_to course_path, alert: 'Not Enrolled'
      redirect_to "/"
    end 
  end

  helper_method :current_course

  def current_course 
    @current_lesson.section.course ||= Lesson.find(params[:id])
  end 

  #helper_method :current_course
    #def current_course
      #@current_course ||= Course.find(params[:id])
    #end
  #end 
end
