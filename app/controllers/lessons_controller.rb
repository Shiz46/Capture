class LessonsController < ApplicationController 
  before_action :authenticate_user!
  before_action :require_authorized_for_current_lesson

  def show 
  end 

  private
  
  def require_authorized_for_current_lesson
    if current_lesson.section.course.user != current_user
      redirect_to course_path, alert: 'Not Enrolled'
      #redirect_to "/"
    end 
  end

  helper_method :current_lesson

  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end 

  def lesson_params 
    params.require(:lesson).permit(:title,:subtitle,:video,  :row_order_position)
  end 
end
