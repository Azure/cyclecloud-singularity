#
# Cookbook:: singularity
# Recipe:: _install_v3.rb
#
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.

include_recipe 'build-essential'
package "squashfs-tools"
package "libarchive-devel"
include_recipe 'singularity::_golang'

VERSION = node['singularity']['version']

myplatform = node['platform']
myplatform = "centos" if myplatform == "redhat" or myplatform == "amazon"
platform_version = node['platform_version']


directory node['jetpack']['downloads'] do
  recursive true
end

# build from source
jetpack_download "singularity-#{VERSION}.tar.gz" do
  project "singularity"
  not_if { ::File.exists?("#{node['jetpack']['downloads']}/singularity-#{VERSION}.tar.gz") }
end


if myplatform == "centos"
  singularity_rpms=["singularity-#{VERSION}-1.el7.centos.x86_64.rpm"]
  singularity_rpm_path="#{node['jetpack']['downloads']}/#{singularity_rpms[1]}"
  
  %w"automake rpm-build golang openssl-devel libuuid-devel libseccomp-devel".each do |pkg|
    package pkg do
      not_if { ::File.exists?(singularity_rpm_path) }
    end
  end  

  bash 'make singularity rpms' do
    cwd "/tmp"
    code <<-EOH
         set -e
         rpmbuild -tb #{node['jetpack']['downloads']}/singularity-#{VERSION}.tar.gz && \
         mv ~/rpmbuild/RPMS/*/*rpm #{node['jetpack']['downloads']}/
         EOH
    not_if { ::File.exists?( singularity_rpm_path ) }
  end

  singularity_rpms.each do |singularity_rpm|
    singularity_rpm_path="#{node['jetpack']['downloads']}/#{singularity_rpm}"
    log "Installing #{singularity_rpm} from #{singularity_rpm_path}..." do level :info end

    yum_package singularity_rpm do
      source singularity_rpm_path
      action :install
    end
  end
  
else
  singularity_deb="singularity-container_#{VERSION}-1_amd64.deb"
  singularity_deb_path="#{node['jetpack']['downloads']}/#{singularity_deb}"
  

  %w"debhelper dh-autoreconf help2man build-essential libssl-dev uuid-dev libgpgme11-dev libseccomp-dev pkg-config".each do |pkg|
    package pkg do
      not_if { ::File.exists?(singularity_deb_path) }
    end
  end
  
  bash 'make and install singularity from source' do
    cwd "/tmp"
    code <<-EOH
         set -e
         export GOPATH=${HOME}/go
         export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin
         mkdir -p $GOPATH/src/github.com/sylabs
         cd $GOPATH/src/github.com/sylabs
         wget https://github.com/sylabs/singularity/releases/download/v${VERSION}/singularity-${VERSION}.tar.gz
         tar -xzf #{node['jetpack']['downloads']}/singularity-#{VERSION}.tar.gz
         cd ./singularity
         ./mconfig
         EOH
    not_if { ::File.exists?( singularity_deb_path ) }
  end
  
end




