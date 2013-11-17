# coding: utf-8
# fruit_solver.rb 

# usage:
#
# 同じディレクトリに fruits.logを配置し、
# ruby fruit_solver.rb 

module FruitSolver
  extend self

  # interface:
  #
  # 1,スキャンする文字列をstring=でインプットし
  # FruitSolver.string = ")apple {apple }[strawberry}strawberry melon]}"
  #
  # 2,solveで最大となるfruitsの個数を返します。
  # FruitSolver.solve
  #  # -> 3

  attr_accessor :string

  def solve
    ["[","(","{"].map{|delimiter|
      count_by_delimiter(delimiter)
    }.max
  end

  #private

  attr_accessor :delimiter

  # delimiter毎に最大となるフルーツの数を返す
  def count_by_delimiter(delimiter)
    self.delimiter = delimiter
    fruits_array.map(&:size).max || 0
  end

  # 文字列を空白で区切り、整理された単語（フルーツ）の配列を返す
  def fruits_array
    strings_separated_by_delimiter.map{|e|e ? e.split(" ") : []}
  end

  # {...}の形の文字列をスキャンし、...の部分だけの配列を返す
  def strings_separated_by_delimiter
    open,close = "\\" + open_delimiter, "\\" + close_delimiter
    trim_other_delimiters.scan(/#{open}[^#{open}]*?#{close}/).map{|e|e[1...-1]}
  end

  private

  # セットされているdelimiterそのものを返す
  def open_delimiter
    @delimiter
  end

  # セットされているdelimiterに対応する閉じ括弧を返す
  def close_delimiter
    { "{" => "}", "(" => ")","[" => "]",}[@delimiter]
  end

  # 不要な括弧（セットされているdelimiter以外の括弧）を取り除く
  def trim_other_delimiters
    @string.gsub(other_delimiters," ")
  end

  # セットされているdelimiter以外の括弧
  def other_delimiters
    {
      "{" => /[\(\)\[\]]/,
      "(" => /[\{\}\[\]]/,
      "[" => /[\(\)\{\}]/,
    }[@delimiter]
  end

end

#handler
File.open("./fruits.log","r"){|f|f.read}.split("\n").each do |string|
  FruitSolver.string = string
  puts FruitSolver.solve
end
# -> 3 6 3 5 4
