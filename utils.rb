def make_slug(text)
  text.downcase.strip.gsub(' ', '-')
end
