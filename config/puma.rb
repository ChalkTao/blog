environment "production"

daemonize true
threads 0,16
workers 2

deploy_to = '/home/lead/rails'
shared_path = 'shared'
bind       "unix://#{deploy_to}/#{shared_path}/tmp/sockets/puma.sock"
state_path        "#{deploy_to}/#{shared_path}/tmp/sockets/puma.state"
pidfile           "#{deploy_to}/#{shared_path}/tmp/pids/puma.pid"
preload_app!
activate_control_app

on_worker_boot do
  puts 'On worker boot...'
end
