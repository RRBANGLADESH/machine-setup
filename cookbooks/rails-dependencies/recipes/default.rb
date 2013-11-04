gem_package "bundler"

gem_package "therubyracer" do
  version '0.11.4'
end

#dependecies for nokogiri
#sudo apt-get install -y libxml2-dev libxslt1-dev imagemagick libmagickwand-dev libv8-dev

package "libxml2-dev"
package "libxslt1-dev"

#dependecies for rmagic
package "imagemagick"
package "libmagickwand-dev"

package "libv8-dev"

#install Redis
package "redis-server"

directory "/home/#{node['user']['name']}/projects" do
  owner node['user']['name']
end

node['rails-projects'].each do |proj|
  git "/home/#{node['user']['name']}/projects/#{proj['name']}" do
    repository proj['repo']
    reference proj['branch']
    action :sync
  end
end

package "ubuntu-restricted-extras"
package "openjdk-7-jdk"

apt_repository 'vlc' do
  uri "http://ppa:ed10vi86/video"
  notifies :run, 'execute[apt-get update]', :immediately
end

package "vlc"
package "gitg"

chrome_file_path = '/tmp/google-chrome-stable_current_amd64.deb'

remote_file chrome_file_path do
  source "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
end

bash 'install chrome' do
  cwd ::File.dirname('/tmp')
  code 'sudo dpkg -i google-chrome*.deb'
  not_if { ::File.exists?(chrome_file_path) }
end