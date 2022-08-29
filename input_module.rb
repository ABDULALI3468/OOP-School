module InputModule
  def numeric_input(text, valid_range)
    loop do
      print text
      input = gets.chomp.to_i
      return input if valid_range.include?(input)
    end
  end

  def letter_input(text, valid_options)
    loop do
      print text
      input = gets.chomp.upcase
      return input if valid_options.include?(input)
    end
  end
end
