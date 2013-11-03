apt_repository 'sublime-text' do
  uri "http://ppa:webupd8team/sublime-text-3"
  notifies :run, 'execute[apt-get update]', :immediately
end

package "sublime-text-installer"