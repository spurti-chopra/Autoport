# Recipe would uninstall/remove ant package installed via binary source

include_recipe 'buildServer::get_log'

version       = node['buildServer']['apache-ant']['version']
install_dir   = node['buildServer']['apache-ant']['install_dir']
ant_pkg       = "apache-ant-#{version}"
archive_dir   = node['buildServer']['download_location']
ext           = node['buildServer']['apache-ant']['ext']
arch          = node['kernel']['machine']

if ext.empty?
  ext = ArchiveLog.getExtension('apache-ant', version)
end

file "#{archive_dir}/#{ant_pkg}-bin#{ext}" do
   action :delete
   ignore_failure true
end

directory "#{install_dir}/#{ant_pkg}" do
  action     :delete
  recursive  true
  ignore_failure true
end

file "/etc/profile.d/ant.sh" do
  action :delete
  only_if "grep -w #{version} /etc/profile.d/ant.sh"
  ignore_failure true
end

buildServer_log "apache-ant" do
  name         "apache-ant"
  log_location node['log_location']
  log_record   "apache-ant,#{version},ant_binary,ant,#{arch},#{ext},#{ant_pkg}-bin#{ext}"
  action       :remove
  ignore_failure true
end
