# Extensions to Ruby / Rails core classes, that I happen to like
class Dir
  def to_hash
    Hash[(self.entries - ['.', '..']).collect do |entry|
      if self.class.exists?(File.join(self.path, entry))
        d = Dir.new(File.join(self.path, entry))
        [entry, d.to_hash]
      else
        [entry, entry]
      end
    end].with_indifferent_access
  end
end

class ActiveRecord::Base
  def all_errors(join_str = "\n")
    self.errors.full_messages.join(join_str)
  end
end

class String
  def to_filename
    self.gsub(/\W/, '-').gsub(/-+/, '-')
  end
  
  def lchomp(sep = "/")
    self.dup.slice!(sep.length, length - 1) if length > sep.length && starts_with?(sep)
  end
end

module Rails
  def self.load_conf(file)
    YAML.load(File.read(Rails.root.join("config", file)))[Rails.env].with_indifferent_access
  end
end
