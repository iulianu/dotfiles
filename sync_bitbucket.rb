require 'net/https'
require 'yaml'
require '~/bitbucket_credentials.rb'

unless (defined?(LOCAL_DIR) && LOCAL_DIR.strip.size > 0)
  puts "ERROR: add a script called ~/bitbucket_credentials.rb"
  exit 2
end

`mkdir -p #{LOCAL_DIR}`

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
  repo_url = "https://#{BITBUCKET_USERNAME}:#{BITBUCKET_PASSWORD}@bitbucket.org/#{BITBUCKET_USERNAME}/#{slug}"
  local_path = "#{LOCAL_DIR}/#{slug}"
  if File.exists?(File.expand_path("#{LOCAL_DIR}/#{slug}"))
    puts "Updating #{slug}"
    `cd #{local_path} && hg pull #{repo_url}`
  else
    puts "Cloning #{slug}"
    `hg clone -U #{repo_url} #{local_path}`
  end
end


