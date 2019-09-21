class LessonsController < ApplicationController 
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson
  def show 
  end 

  private
  
  def require_authorized_for_current_lesson
    if current_user.enrolled_in?!= current_user
      redirect_to course_path(current_course), alert: 'Not Enrolled'
    end 
  end

  helper_method :current_lesson 
  def current_lesson 
    @current_lesson.section.course ||= Lesson.find(params[:id])
  end 
end
