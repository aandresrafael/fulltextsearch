module Parser
  def self.parse_text(text)
  	text.downcase.gsub(/[\,\.;\:]/, ' ').split(/\s/).reject { |item| item.empty? }
  end
end