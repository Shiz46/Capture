class LessonsController < ApplicationController 
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson

  def show 
    
  end 

  private
  
  def require_authorized_for_current_lesson
    if current_user.enrolled_in?(current_course)!= current_user
      redirect_to course_url, alert: 'Not Enrolled'
      #redirect_to "/"
    end 
  end

  #helper_method :current_lesson 
  #def current_lesson 
    #@current_lesson.section.course ||= Lesson.find(params[:id])

  helper_method :current_course
    def current_course
      @current_course ||= Course.find(params[:id])
    end
  #end 
end
