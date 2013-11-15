module CountFruit
  extend self
  attr_accessor :str
  Delimiter = {
    "{" => ["{","}"],
    "(" => ["(",")"],
    "[" => ["[","]"],
  }
  ReplaceRegExp = {
    "{" => /[\(\)\[\]]/,
    "(" => /[\{\}\[\]]/,
    "[" => /[\(\)\{\}]/,
  }
  def init(str,delimiter)
    @str = @inner_str = str
    @delimiter = delimiter
    @cut_begin,@cut_end = Delimiter[@delimiter]
  end

  def delimiter=(delimiter)
    @delimiter = delimiter
    @cut_begin,@cut_end = Delimiter[@delimiter]
  end

  def cut
    replace
    split.map{|e|e ? e.split(" ") : []}
  end

  def split
    array = @inner_str.split(@cut_begin)
    array.shift
    array.select!{|e|e.include? @cut_end}
    array.map{|e|e.split(@cut_end).first}
  end

  def replace
    @inner_str = @str.gsub(ReplaceRegExp[@delimiter]," ")
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
  CountFruit.str = string
  puts CountFruit.solve
end
# -> 3 6 3 5 4


