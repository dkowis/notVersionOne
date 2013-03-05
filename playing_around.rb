require 'config/application'

module M
  # include the package of version one crap
  include_package 'com.versionone.om'
  # include the package of filtering
  include_package 'com.versionone.om.filters'

  v1 = V1Instance.new('https://www15.v1host.com/RACKSPCE', 'davi3906', 'okak5vea')

  # list all projects you have access to
  #puts "you have projects:"
  #v1.projects.each do |project|
  #  puts "project name: #{project.name}"
  #end

  # get the cloud control project by name
  puts "but we're only going to play with cloud_control right now"
  cc_project = v1.get.project_by_name("Cloud Control")

  puts "does it have an ID: #{cc_project.id.token}"

  # lets get stuff for the iteration as named:
  iter_filter = IterationFilter.new
  iter_filter.name.add "CC Sprint 23"

  iterations = cc_project.get_iterations(iter_filter)
  puts "cloud control has #{iterations.size} iterations"
  iterations.each do |iter|
    puts "#{iter.get_name}"
  end

  sprint_23 = iterations.first

  df = DefectFilter.new
  # this is somehow pulling in things that are also closed, because these filters are all or :(
  # blargh, using the right state is a pain!
  df.state.add(BaseAssetFilter::State::Active) #how do I get the ones in "(None)"
  #df.state.add(State::FUTURE) #combination of FUTURE state and nil in the status column
  df.status.add(nil)
  df.status.add("Future")
  df.status.add("In Dev")
  df.status.add("Dev Done")
  df.status.add("In QE")

  sf = StoryFilter.new
  sf.state.add(BaseAssetFilter::State::Active)
  defects = sprint_23.get_primary_workitems(df)
  stories = sprint_23.get_primary_workitems(sf)

  puts "stuff to do in sprint 23"
  puts "there are #{defects.size} defects"
  puts "there are #{stories.size} stories"
  defects.each do |defect|
    puts "defect: #{defect.name} -- #{defect.active?}"
  end

  exit 1
  puts "getting defects"
  defect_filter = DefectFilter.new
  defect_filter.project.add(cc_project)
  defect_filter.state.add(State::ACTIVE)

  results = v1.get.defects(defect_filter)
  results.each do |result|
    # list of defects!
    puts "#{result.get_name}"
  end

  puts "getting stories"
  cc_filter = StoryFilter.new
  cc_filter.project.add(cc_project)
  cc_filter.state.add(State::ACTIVE)
  #cc_filter.type.add("Defect")
  results = v1.get.story(cc_filter)
  results.each do |result|
    # should be a list of stories!
    #type appears to be what kind of request, not if it's a defect or a backlog item...
    puts "#{result.source.current_value} : #{result.get_name}"
  end
end