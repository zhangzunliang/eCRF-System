class CoursesController < ApplicationController
  layout 'patients'
  before_action :authenticate_user!
  load_resource :patient
  load_resource :course, :through => :patient

  def new
    @course.blood_biochemistry_thes.new
    @course.blood_routine_thes.new
    @course.course_medications.new

    @available_experimental_medication=@patient.research.experimental_medications.all
  end

  def create
    respond_to do |format|
      if @course.save

        format.html { redirect_to patient_course_path(@patient, @course) }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @available_experimental_medication=@patient.research.experimental_medications.all
  end

  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to patient_course_path(@patient, @course) }
      else
        format.html { render :edit }
      end
    end
  end

  def show
    @available_experimental_medication=@patient.research.experimental_medications.all
  end

  def destroy
    @course.destroy
    redirect_to patient_path(params[:patient_id]),  notice: "删除成功"
  end

  private
  def course_params
    params.require(:course).permit(
        :interview,:height,:weight,:body_surface_area,

        blood_biochemistry_thes_attributes: [:id,:name, :value,:sample_date,:unit,:is_local_hospital,:_destroy],
        blood_routine_thes_attributes: [:id,:name, :value,:sample_date,:unit,:is_local_hospital,:_destroy],
        course_medications_attributes: [:id,:experimental_medication_id,:dose,:date_of_administration,:if_delay_administration,
                                        :reason_for_delay,:description_for_delay,:if_change_dose,:reason_for_change,
                                        :description_for_change,:_destroy]
    )
  end
end
