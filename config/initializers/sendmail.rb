# configure action_mailer
mailer_config = File.open("#{RAILS_ROOT}/config/mailer.yml")
mailer_options = YAML.load(mailer_config)

ActionMailer::Base.delivery_method = :sendmail
ActionMailer::Base.smtp_settings = mailer_options
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_charset = 'utf-8'