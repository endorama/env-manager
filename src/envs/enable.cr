module Envs
  def self.enable(env)
    enabled_env_path = Envs::ENABLED_ENV_PATH
    disabled_env_path = Envs::DISABLED_ENV_PATH

    if File.exists? "#{enabled_env_path}/#{env}.sh"
      return true
    elsif File.exists? "#{disabled_env_path}/#{env}.sh"
      `sudo ln -s #{disabled_env_path}/#{env}.sh #{enabled_env_path}/#{env}.sh`
      return true
    end

    false
  end
end
