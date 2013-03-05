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
  end
end