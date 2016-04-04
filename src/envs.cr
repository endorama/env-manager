require "commander"
require "ambience"
require "colorize"

Envs.load_envs

require "./envs/*"

module Envs
  def self.load_envs
    env_file = nil
    local_env_file = File.expand_path(".env", __DIR__)
    global_env_file = File.expand_path("~/.env-manager.rc")

    # puts local_env_file
    # puts global_env_file

    env_file = local_env_file if File.exists? local_env_file
    env_file = global_env_file if File.exists? global_env_file
    if env_file
      Ambience.application(env_file, "development")
      Ambience.load
    end
  end
end
