SimpleCov.start do
  add_group 'Decorators', 'app/decorators'
  add_group 'Serializers', 'app/serializers'
  add_filter 'app/models/application_record.rb'
  add_filter 'app/jobs/application_job.rb'
  add_filter 'app/mailers/application_mailer.rb'
  add_filter 'app/channels/application_cable/channel.rb'
  add_filter 'app/channels/application_cable/connection.rb'
end