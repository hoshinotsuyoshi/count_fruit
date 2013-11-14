module CountFruit
  extend self
  attr_accessor :str
  Cutter = {
    "{" => ["{","}"],
    "(" => ["(",")"],
    "[" => ["[","]"],
  }
  ReplaceRegExp = {
    "{" => /[\(\)\[\]]/,
    "(" => /[\{\}\[\]]/,
    "[" => /[\(\)\{\}]/,
  }
  def init(str,cutter)
    @str = @inner_str = str
    @cutter = cutter
    @cut_begin,@cut_end = Cutter[@cutter]
  end

  def cutter=(cutter)
    @cutter = cutter
    @cut_begin,@cut_end = Cutter[@cutter]
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
    @inner_str = @str.gsub(ReplaceRegExp[@cutter]," ")
  end

  def max
    cut.map(&:size).max || 0
  end

  def solve
    ["[","(","{"].map{|dilimiter|
      self.cutter = dilimiter
      max
    }.max
  end

end

