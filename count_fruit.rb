module CountFruit
  extend self
  attr_accessor :string,:delimiter
  ReplaceRegExp = {
    "{" => /[\(\)\[\]]/,
    "(" => /[\{\}\[\]]/,
    "[" => /[\(\)\{\}]/,
  }

  def open_delimiter
    @delimiter
  end

  def close_delimiter
    { "{" => "}", "(" => ")","[" => "]",}[@delimiter]
  end

  #trim_unrelevant_delimiter
  def inner_string
    @string.gsub(ReplaceRegExp[@delimiter]," ")
  end

  #strings_separated_by_delimiter
  def split
    open,close = "\\" + open_delimiter, "\\" + close_delimiter
    inner_string.scan(/#{open}[^#{open}]*?#{close}/).map{|e|e.gsub(/[#{open}#{close}]/,"")} 
  end

  #separate_by_space -> to_fruits_array
  def cut
    split.map{|e|e ? e.split(" ") : []}
  end

  def count
    cut.map(&:size).max || 0
  end

  def solve
    ["[","(","{"].map{|delimiter|
      self.delimiter = delimiter
      count
    }.max
  end

end

#handler
File.open("./fruits.log","r"){|f|f.read}.split("\n").each do |string|
  CountFruit.string = string
  puts CountFruit.solve
end
# -> 3 6 3 5 4


