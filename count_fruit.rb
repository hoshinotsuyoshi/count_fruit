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

  #separate_using_delimiter
  def split
    #open_delimiterでsplit
    array = inner_string.split(open_delimiter)
    #最初の要素は不要
    array.shift
    #それぞれの要素において閉じ括弧が無いものを削除
    array.select!{|e|e.include? close_delimiter}
    #閉じ括弧でsplitして最初の要素を取り出す
    array.map{|e|e.split(close_delimiter).first}
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


