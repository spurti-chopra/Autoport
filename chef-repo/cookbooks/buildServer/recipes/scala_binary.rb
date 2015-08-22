# Install scala using tarball hosted over autoport_repo.

Chef::Recipe.send(:include, CommandBuilder)

version       = node['buildServer']['scala']['version']
install_dir   = node['buildServer']['scala']['install_dir']
scala_pkg     = "scala-#{version}"
archive_dir   = node['buildServer']['download_location']
scala_home    = "#{install_dir}/#{scala_pkg}"
extension     = node['buildServer']['scala']['extension']
repo_url      = node['buildServer']['repo_url']

remote_file "#{archive_dir}/#{scala_pkg}#{extension}" do
  source "#{repo_url}/archives/#{scala_pkg}#{extension}"
  owner 'root'
  group 'root'
  action :create
  mode '0644'
end

execute "Extracting scala #{version}" do
  cwd install_dir
  user 'root'
  group 'root'
  command <<-EOD
    #{CommandBuilder.command(extension, run_context)} #{archive_dir}/#{scala_pkg}#{extension}
  EOD
  creates "#{install_dir}/#{scala_pkg}"
end

template '/etc/profile.d/scala.sh' do
  owner 'root'
  group 'root'
  source 'scala_source.sh.erb'
  mode '0644'
  variables(
    scala_home: scala_home
  )
end

buildServer_log 'scala' do
  name         'scala'
  log_location node['log_location']
  log_record   "scala,#{version},scala_binary,scala,#{scala_pkg}#{extension}"
  action       :add
end