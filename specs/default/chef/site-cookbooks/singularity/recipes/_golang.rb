#
# Cookbook:: singularity
# Recipe:: _golang
#
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.


go_version = "1.11.4"
go_os = "linux"
go_arch = "amd64"

bash "fetch_golang" do
  cwd "/tmp"
  code <<-EOH
       cd /tmp
       wget https://dl.google.com/go/go#{go_version}.#{go_os}-#{go_arch}.tar.gz
       tar -C /usr/local -xzf go#{go_version}.#{go_os}-#{go_arch}.tar.gz
       EOH

  not_if { ::File.exists?("/tmp/go#{go_version}.#{go_os}-#{go_arch}.tar.gz") }
end



file "/etc/profile.d/golang.sh" do
  content <<-EOH
          export PATH=${PATH}:/usr/local/go/bin
          EOH
  mode 0755
end


