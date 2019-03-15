#
# Cookbook:: singularity
# Recipe:: default
#
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.

include_recipe 'build-essential'

VERSION = node['singularity']['version']

myplatform = node[:platform]
myplatform = "centos" if myplatform == "redhat" or myplatform == "amazon"
platform_version = node[:platform_version]

package "squashfs-tools"
package "libarchive-devel"

directory node[:jetpack][:downloads] do
  recursive true
end

# TODO : First check if pre-built packages exist
#      : Need to figure out rpm and deb package naming

if myplatform == "centos"
  singularity_rpms=["singularity-runtime-#{VERSION}-1.el7.centos.x86_64.rpm", "singularity-#{VERSION}-1.el7.centos.x86_64.rpm"]
  singularity_rpm_path="#{node[:jetpack][:downloads]}/#{singularity_rpms[1]}"
  
  # Check if the RPM is available
  singularity_rpms.each do |singularity_rpm|
    singularity_rpm_path="#{node[:jetpack][:downloads]}/#{singularity_rpm}"

#     jetpack_download singularity_rpm do
#       project "singularity"
#       not_if { ::File.exist?(singularity_rpm_path) }
#     end
    execute "#{node['cyclecloud']['jetpack']['executable']} download #{singularity_rpm} #{singularity_rpm_path}  --project singularity" do
      returns [0, 1]
      not_if { ::File.exists?(singularity_rpm_path) }
    end
  end


else
  singularity_deb="singularity-container_#{VERSION}-1_amd64.deb"
  singularity_deb_path="#{node[:jetpack][:downloads]}/#{singularity_deb}"
  
  # Check if the DEB is available
#   jetpack_download singularity_deb do
#     project "singularity"
#     not_if { ::File.exist?(singularity_deb_path) }
#   end
  execute "#{node['cyclecloud']['jetpack']['executable']} download #{singularity_deb} #{singularity_deb_path}  --project singularity" do
    returns [0, 1]
    not_if { ::File.exists?(singularity_deb_path) }
  end

end


# ELSE build from source
if ! File.exists?(singularity_rpm_path) && ! File.exists?(singularity_deb_path)
  if Gem::Version.new(VERSION) < Gem::Version.new('3.0')
    include_recipe 'singularity::_install_v2'
  else
    include_recipe 'singularity::_install_v3'
  end
end


