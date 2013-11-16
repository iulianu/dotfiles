# === On Linux
# 43 15    * * *   iulian ruby /home/iulian/dotfiles/sync_bitbucket.rb
# chmod 644 /etc/cron.d/bitbucket
# chown root:root /etc/cron.d/bitbucket
# service cron reload
# === On OS X
# sudo crontab -u root -e
# SHELL=/bin/bash
# MAILTO=iulian
# PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
# 43 19    * * *   cd /Users/iulian/dotfiles/ && ruby sync_bitbucket.rb
# ===
# The file bitbucket_credentials.rb has to conform to this structure:
#BITBUCKET_USERNAME = "iulianu"
#BITBUCKET_PASSWORD = "lalala123"
#LOCAL_DIR = "~/Archive/bitbucket"
#

require 'net/https'
require 'yaml'
require './bitbucket_credentials'
require 'pp'

unless (defined?(LOCAL_DIR) && LOCAL_DIR.strip.size > 0)
  puts "ERROR: add a script called ~/dotfiles/bitbucket_credentials.rb"
  exit 2
end

`mkdir -p #{LOCAL_DIR}`

def assert_success(process_status)
  exit_code = process_status.exitstatus
  if(exit_code != 0)
    puts "Last command exited with code #{exit_code}"
    exit exit_code
  end
end

def update_or_clone_hg(slug)
  repo_url = "https://#{BITBUCKET_USERNAME}:#{BITBUCKET_PASSWORD}@bitbucket.org/#{BITBUCKET_USERNAME}/#{slug}"
  local_path = "#{LOCAL_DIR}/#{slug}"
  if File.exists?(File.expand_path("#{LOCAL_DIR}/#{slug}"))
    puts "Updating #{slug}"
    `cd #{local_path} && hg pull #{repo_url}`
  else
    puts "Cloning #{slug}"
    `hg clone -U #{repo_url} #{local_path}`
  end
  assert_success($?)
end

def update_or_clone_git(slug)
  repo_url = "https://#{BITBUCKET_USERNAME}:#{BITBUCKET_PASSWORD}@bitbucket.org/#{BITBUCKET_USERNAME}/#{slug}"
  local_path = "#{LOCAL_DIR}/#{slug}"
  if File.exists?(File.expand_path("#{LOCAL_DIR}/#{slug}"))
    puts "Updating #{slug}"
    `cd #{local_path} && git fetch #{repo_url}`
  else
    puts "Cloning #{slug}"
    `git clone -n #{repo_url} #{local_path}`
  end
  assert_success($?)
end


http = Net::HTTP.new("api.bitbucket.org", 443)
http.use_ssl = true
resp = nil
http.start do |http|
  req = Net::HTTP::Get.new "/1.0/users/#{BITBUCKET_USERNAME}/?format=yaml"
  req.basic_auth(BITBUCKET_USERNAME, BITBUCKET_PASSWORD)
  resp = http.request(req)
end
#p resp.body
tree = YAML.load(resp.body)
tree["repositories"].each do |repo_tree|
  slug = repo_tree["slug"]
  case repo_tree['scm']
    when "hg"
      puts "I will be syncing #{slug} via Hg"
      update_or_clone_hg(slug)
    when "git"
      puts "I will be syncing #{slug} via Git"
      update_or_clone_git(slug)
    else
      puts "Cannot sync #{slug}, unknown SCM: #{repo_tree['scm']}"
  end
end


