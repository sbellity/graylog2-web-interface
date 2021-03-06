class Configuration
  @general_config = YAML::load(File.read(Rails.root.to_s + "/config/general.yml"))
  @email_config = YAML::load(File.read(Rails.root.to_s + "/config/email.yml"))

  @alert_config = @general_config['alerts']
  @livetail_config = @general_config['livetail']

  def self.external_hostname
    return "localhost" if @general_config.blank? or @general_config['general'].blank? or @general_config['general']['external_hostname'].blank?
    return @general_config['general']['external_hostname']
  end

  def self.alert_from_address
    return @alert_config['from'] unless @alert_config.blank? or @alert_config['from'].blank?
    return "graylog2@example.org"
  end

  def self.alert_subject
    return @alert_config['subject'] unless @alert_config.blank? or @alert_config['subject'].blank?
    return "Graylog2 stream alert!"
  end

  def self.email_transport_type
    standard = :sendmail
    return standard if @email_config[Rails.env].blank? or @email_config[Rails.env]['via'].blank?
    # Only sendmail or SMTP allowed.
    allowed = ['sendmail', 'smtp']
    return standard unless allowed.include? @email_config[Rails.env]['via']

    return @email_config[Rails.env]['via'].to_sym
  end

  def self.email_smtp_settings
    return Hash.new if @email_config[Rails.env].blank? or @email_config[Rails.env]['via'].blank?
    config = @email_config[Rails.env]
    ret = Hash.new

    if config['via'] == 'smtp'
      ret[:host] = config['host'] unless config['host'].blank?
      ret[:port] = config['port'] unless config['port'].blank?
      ret[:user] = config['user'] unless config['user'].blank?
      ret[:password] = config['password'] unless config['password'].blank?
      ret[:auth] = config['auth'] unless config['auth'].blank?
      ret[:domain] = config['domain'] unless config['domain'].blank?
      return ret
    end

    return ret
  end

  def self.livetail_enabled
    return false if @livetail_config.blank? or @livetail_config['enable'].blank?
    return true if @livetail_config['enable'] == true
    return false
  end

  def self.livetail_secret
    return nil if @livetail_config.blank? or @livetail_config['secret'].blank?
    return @livetail_config['secret'].to_s
  end

end
