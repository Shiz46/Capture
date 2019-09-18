class User < ApplicationRecord
  has_many :courses
  has_many :enrollments
  has_many :enrolled_courses, through: :enrollments, source: :course
  # load all of these connected items in one action.
  # grabs different connected relationship from it.

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def enrolled_in?(course)
    #enrolled_courses = enrollments.collect(&:course)
      #N+1 Query, it reaches out to the database to load the enrollments first.
      #Then it reaches out to database n times, where n is the number of enrollments a user (student) has.
    return enrolled_courses.include?(course)
  end 



  
end
