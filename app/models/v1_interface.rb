module V1
  # include the java stuffs
  include_package 'com.versionone.om'
  include_package 'com.versionone.om.filters'

  class V1Interface
    def initialize(username, password)
      @v1 = V1Instance.new('https://www15.v1host.com/RACKSPCE', username, password)
    end

    def test_auth
      @v1.validate
    end

    def projects
      @v1.projects
    end

    def project_by_name(name)
      @v1.get.project_by_name(name)
    end

    def project_by_id(id)
      @v1.get.project_by_id(id)
    end

    def iteration_by_name(project, iteration_name)
      iter_f = IterationFilter.new
      iter_f.name.add iteration_name #TODO: put this in a config var or something
      iters = project.get_iterations(iter_f)
      if iters.size != 1
        raise "Unable to find iteration, or found more than one iteration by that name (HOW?!?!)"
      end
      iters.first
    end

    # returns a list of work for an iteration
    def all_work_for_iteration(project, iteration)
      wf = PrimaryWorkitemFilter.new
      wf.state.add(BaseAssetFilter::State::Active)

      iteration.get_primary_workitems(wf)
    end

  end
end