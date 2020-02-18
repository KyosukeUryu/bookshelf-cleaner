# server '3.114.215.170', user: 'app', roles: %w{app db web}
# set :ssh_options, keys: '/Users/lalalabaybay/.ssh/id_rsa'
server '3.114.215.170',
   user: "app",
   roles: %w{web db app},
   ssh_options: {
       port: 22022,
       user: "app", # overrides user setting above
       keys: %w(~/.ssh/id_rsa),
       forward_agent: true
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
   }
