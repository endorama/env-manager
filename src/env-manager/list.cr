module Env::Manager
  def self.list
    enabled_envs = [] of String
    enabled_env_path = Env::Manager::ENABLED_ENV_PATH
    Dir["#{enabled_env_path}/*"].each do |file|
      enabled_envs << File.basename(file, ".sh")
    end
    disabled_envs = [] of String
    disabled_env_path = Env::Manager::DISABLED_ENV_PATH
    Dir["#{disabled_env_path}/*"].each do |file|
      env = File.basename(file, ".sh")
      disabled_envs << env unless enabled_envs.includes?(env)
    end

    [enabled_envs.sort, disabled_envs.sort]
  end
end
