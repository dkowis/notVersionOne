class ProjectsController < ApplicationController
  def work
  end

  def show
    @project = v1.project_by_id(params[:project_id])
    # TODO: get this from somewhere sane...
    @iteration = v1.iteration_by_name(@project, "CC Sprint 23")
    tasks = v1.all_work_for_iteration(@project,@iteration)
    #TODO: how do I get any kind of relative sort in there... Le CRAP, should probably build a hash out of these guys.
    @wrapped_tasks = Array.new
    index = 1
    tasks.each do |task|
      # TODO: not all things have links :( stupid types...
      blocking_issues = task.blocking_issues
      @wrapped_tasks << {
        :order => index,
        :id => task.id,
        :estimate => task.estimate,
        :blocked => blocking_issues.empty? ? false : true,
        :status => task.status.current_value,
        :owners => task.owners,
        :name => task.name,
        :change_date => task.change_date,
        :description => task.description
      }
      index += 1
    end
  end

  def list
  end
end
