class CoursesController < ApplicationController
  def show
    @course = Course.find params[:id]
    @title = @course.to_s
    add_breadcrumb @course
  end

  def evaluate
    @course = Course.find params[:course_id]
    @evaluation = Evaluation.where(student: current_student, course: @course).first_or_initialize
    @title = "Evaluation de \"#{@course}\""
    add_breadcrumb @course, @course
    add_breadcrumb 'Evaluation'
  end

  def update_evaluation
    @course = Course.find params[:course_id]
    @evaluation = Evaluation.where(student: current_student, course: @course).first_or_initialize
    if @evaluation.update evaluation_params
      redirect_to @course, notice: 'Evaluation mise à jour.'
    else
      render :evaluate
    end
  end

  protected

  def evaluation_params
    params.require(:evaluation).permit(:comment, :relevant_content, :content_to_add, :content_to_remove, :quality, :technical_skills_acquired, :soft_skills_acquired, :knowledge_acquired)
  end
end
