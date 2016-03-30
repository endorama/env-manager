require "../src/env-manager"

puts Env::Manager::ENABLED_ENV_PATH
puts Env::Manager::DISABLED_ENV_PATH

cli = Commander::Command.new do |cmd|
  cmd.use = "env-manager"
  cmd.long = "env-manager lets you manager environment variables securely and in a modular way"

  cmd.run do |options, arguments|
    puts "Nothing to do. Use -h"
  end

  cmd.commands.add do |cmd|
    cmd.use = "disable"
    cmd.short = "disable specidied env"
    cmd.long = cmd.short
    cmd.run do |options, arguments|
      if arguments.size < 1
        STDERR.puts "Required env to disable"
        exit 1
      end

      env = arguments[0]

      if Env::Manager.disable env
        puts %{#{"✔".colorize(:green)} #{env} disabled}
        puts "link #{Env::Manager::ENABLED_ENV_PATH}/#{env}.sh removed"
      else
        STDERR.puts %{#{"✖".colorize(:red)} Cannot disable #{env}}
        exit 1
      end
    end
  end

  cmd.commands.add do |cmd|
    cmd.use = "enable"
    cmd.short = "enable specidied env"
    cmd.long = cmd.short
    cmd.run do |options, arguments|
      if arguments.size < 1
        STDERR.puts "Required env to enabled"
        exit 1
      end

      env = arguments[0]

      if Env::Manager.enable env
        puts %{#{"✔".colorize(:green)} #{env} enabled}
        puts "link #{Env::Manager::ENABLED_ENV_PATH}/#{env}.sh created"
      else
        STDERR.puts %{#{"✖".colorize(:red)} Cannot enable #{env}}
        exit 1
      end
    end
  end

  cmd.commands.add do |cmd|
    cmd.use = "list"
    cmd.short = "list all available envs"
    cmd.long = cmd.short
    cmd.run do |options, arguments|
      envs = Env::Manager.list
      envs[0].each do |enabled_env|
        puts %{#{"✔".colorize(:green)} #{enabled_env}}
      end
      envs[1].each do |disabled_env|
        puts %{#{"✖".colorize(:yellow)} #{disabled_env}}
      end
    end
  end

  cmd.commands.add do |cmd|
    cmd.use = "version"
    cmd.short = "display version"
    cmd.long = cmd.short
    cmd.run do |options, arguments|
      puts Env::Manager::VERSION
    end
  end
end

Commander.run(cli, ARGV)
