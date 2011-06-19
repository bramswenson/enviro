class Hash
  def deep_symbolize_keys
    inject({}) do |hash, item|
      key, value = item
      new_key = key.to_sym rescue key
      hash[new_key] = self[key]
      hash[new_key].deep_symbolize_keys if hash[new_key].kind_of?(Hash)
      hash
    end
  end
end
