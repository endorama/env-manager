module Envs
  def self.disable(env)
    enabled_env_path = Envs::ENABLED_ENV_PATH
    disabled_env_path = Envs::DISABLED_ENV_PATH

    if File.exists?("#{enabled_env_path}/#{env}.sh") && File.symlink?("#{enabled_env_path}/#{env}.sh")
      `sudo unlink #{enabled_env_path}/#{env}.sh`
      return true
    elsif File.exists? "#{disabled_env_path}/#{env}.sh"
      puts "Already disabled"
      return true
    end

    false
  end
end
