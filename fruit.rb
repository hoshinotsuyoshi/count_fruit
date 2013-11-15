module CountFruit
  extend self
  attr_accessor :string,:delimiter
  Delimiters = {
    "{" => ["{","}"],
    "(" => ["(",")"],
    "[" => ["[","]"],
  }
  ReplaceRegExp = {
    "{" => /[\(\)\[\]]/,
    "(" => /[\{\}\[\]]/,
    "[" => /[\(\)\{\}]/,
  }
  def init(string,delimiter)
    @string = @inner_string = string
    @delimiter = delimiter
  end

  def open_delimiter
    Delimiters[@delimiter].first
  end

  def close_delimiter
    Delimiters[@delimiter].last
  end

  def cut
    replace
    split.map{|e|e ? e.split(" ") : []}
  end

  def split
    array = @inner_string.split(open_delimiter)
    array.shift
    array.select!{|e|e.include? close_delimiter}
    array.map{|e|e.split(close_delimiter).first}
  end

  def replace
    @inner_string = @string.gsub(ReplaceRegExp[@delimiter]," ")
  end

  def max
    cut.map(&:size).max || 0
  end

  def solve
    ["[","(","{"].map{|dilimiter|
      self.delimiter = dilimiter
      max
    }.max
  end

end

#handler
File.open("./fruits.log","r"){|f|f.read}.split("\n").each do |string|
  CountFruit.string = string
  puts CountFruit.solve
end
# -> 3 6 3 5 4


