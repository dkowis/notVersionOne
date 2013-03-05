class ProjectsController < ApplicationController
  def work
  end

  def show
    @projects = v1.projects
  end

  def list
  end
end
