# List of all recipes to be run, whenever a synch operation is done on a build-server.

Chef::Recipe.send(:include, ArchiveLog)
ArchiveLog.getLog(run_context, node)

include_recipe 'buildServer::repo_settings'
include_recipe 'buildServer::buildtools'
include_recipe 'buildServer::cmake'
include_recipe 'buildServer::ibm-sdk-nodejs'
include_recipe 'buildServer::autoportPackages'
include_recipe 'buildServer::java'
include_recipe 'buildServer::ant'
include_recipe 'buildServer::maven_binary'
include_recipe 'buildServer::protobuf_source'
include_recipe 'buildServer::scala'
include_recipe 'buildServer::gradle_binary'
include_recipe 'buildServer::ibm-java-sdk'
include_recipe 'buildServer::perl'
include_recipe 'buildServer::strict-perl'
case node['platform']
  when 'redhat'
    include_recipe 'buildServer::module-install'
    include_recipe 'buildServer::test-strict'
    include_recipe 'buildServer::yaml-tiny'
    include_recipe 'buildServer::py'
    include_recipe 'buildServer::pytest'
end
include_recipe 'buildServer::userpackages'
