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
  
  def self.random(n = 1)
    if n >= self.count
      return self.first if n == 1
      return self.all.to_a
    end
    max = self.last.id
    records = []
    begin
      r = self.find_by_id(rand(max))
      records << r if r.present?
      records.uniq!
    end while records.count < n
    return records.first if n == 1
    records
  end
  
end

class String
  def to_filename
    self.gsub(/\W/, '-').gsub(/-+/, '-')
  end
  
  def lchomp(sep = $/)
    rchomp(sep)
  end

  def rchomp(sep = $/)
    self.start_with?(sep) ? self[sep.size..-1] : self
  end
  
  def to_bool
    return true if self == true || self =~ (/(true|t|yes|y|1)$/i)
    return false if self == false || self.blank? || self =~ (/(false|f|no|n|0)$/i)
    raise ArgumentError.new("invalid value for Boolean: \"#{self}\"")
  end

  def utf_strip
    self.gsub(/[[:space:]]/, ' ').strip
  end

  def utf_strip!
    self.gsub!(/[[:space:]]/, ' ')
    self.strip!
    self
  end
end

module Rails
  def self.load_conf(file)
    YAML.load(File.read(Rails.root.join("config", file)))[Rails.env].with_indifferent_access
  end
end

# from http://blog.hulihanapplications.com/browse/view/50-mysql-datetime-and-rails
class Time  
  def to_mysql # add custom time formatting  
   self.strftime("%Y-%m-%d %H:%M:%S")  
  end  
end