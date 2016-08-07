class StringToHashConverter
  def self.convert(hash_string)
    array = hash_string[1..-2].split(/\s*[,:]\s*/)
    Hash[*array].symbolize_keys
  end
end