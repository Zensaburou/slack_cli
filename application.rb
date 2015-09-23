require 'dotenv'

class Application
  def load
    Dotenv.load
    ApplicationLoader.new.load_dirs
  end
end

module AppRoot
  def application_root
    File.expand_path File.dirname(__FILE__)
  end
end

class ApplicationLoader
  include AppRoot

  def load_dirs
    dir_paths.each { |path| require_dir(path) }
  end

  private

  def require_dir(path)
    Dir[path << '/*.rb'].each { |file| require file }
  end

  def dir_paths
    dirs.map { |dir| application_root + "/#{dir}" }
  end

  def dirs
    %w(lib)
  end
end

Application.new.load
