# coding: utf-8
require './count_fruit'

describe CountFruit do
  it "split" do
    string,delimiter = "{apple melon}","{"
    CountFruit.string = string
    CountFruit.delimiter = delimiter
    expect(
      CountFruit.split
    ).to eq ["apple melon"]
  end
  it "split" do
    string,delimiter = "xx {)x {yy z)z aa bb{apple()   melon aka}{tak  }xxx yyy","{"
    CountFruit.string = string
    CountFruit.delimiter = delimiter
    expect(
      CountFruit.split
    ).to eq ["apple     melon aka", "tak  "]
  end
end

describe CountFruit do
  it "cut" do
    string,delimiter = "{apple melon}","{"
    CountFruit.string = string
    CountFruit.delimiter = delimiter
    expect(
      CountFruit.cut
    ).to eq [["apple","melon"]]
  end
  it "cut" do
    string,delimiter = "{apple melon aka}{tak}","{"
    CountFruit.string = string
    CountFruit.delimiter = delimiter
    expect(
      CountFruit.cut
    ).to eq [ ["apple", "melon", "aka"], ["tak"]]
  end
  it "cut" do
    string,delimiter = "{apple   melon aka}{tak  }","{"
    CountFruit.string = string
    CountFruit.delimiter = delimiter
    expect(
      CountFruit.cut
    ).to eq [["apple", "melon", "aka"], ["tak"]]
  end
  it "cut" do
    string,delimiter = "xxx {yy zz aa bb{apple()   melon aka}{tak  }xxx yyy","{"
    CountFruit.string = string
    CountFruit.delimiter = delimiter
    expect(
      CountFruit.cut
    ).to eq [["apple", "melon", "aka"], ["tak"]]
  end
  context "複雑な文字列の時" do
    before do
      string = "{()apple} melon strawberry(melon{apple apple} melon strawberry)"
      CountFruit.string = string
    end
    # "("
    it "cut" do
      CountFruit.delimiter = "("
      expect(
        CountFruit.cut
      ).to eq  [[], ["melon", "apple", "apple", "melon", "strawberry"]]
    end
    # "{"
    it "cut" do
      CountFruit.delimiter = "{"
      expect(
        CountFruit.cut
      ).to eq  [["apple"], ["apple", "apple"]]
    end
    # "("
    it "cut" do
      CountFruit.delimiter = "["
      expect(
        CountFruit.cut
      ).to eq []
    end
  end
  context "例題1の場合" do
    before do
      CountFruit.string = "{melon (()melon strawberry)][apple}"
    end
    # "("
    it "count_by '('" do
      CountFruit.delimiter = "("
      expect(
        CountFruit.count
      ).to eq 0
    end
    it "count_by '{'" do
      CountFruit.delimiter = "{"
      expect(
        CountFruit.count
      ).to eq 4
    end
    it "count_by '['" do
      CountFruit.delimiter = "["
      expect(
        CountFruit.count
      ).to eq 0
    end
    it "solve" do
      expect(
        CountFruit.solve
      ).to eq 4
    end
  end
  context "例題2の場合" do
    before do
      CountFruit.string = "[apple apple }{melon](strawberry}(melon]]"
    end
    it "count_by '('" do
      CountFruit.delimiter = "("
      expect(
        CountFruit.count
      ).to eq 0
    end
    it "count_by '{'" do
      CountFruit.delimiter = "{"
      expect(
        CountFruit.count
      ).to eq 2
    end
    it "count_by '['" do
      CountFruit.delimiter = "["
      expect(
        CountFruit.count
      ).to eq 3
    end
    it "solve" do
      expect(
        CountFruit.solve
      ).to eq 3
    end
  end
  context "例題3の場合" do
    before do
      CountFruit.string = "({}apple) melon strawberry{melon(apple apple) melon strawberry}"
    end
    it "count_by '('" do
      CountFruit.delimiter = "("
      expect(
        CountFruit.count
      ).to eq 2
    end
    it "count_by '{'" do
      CountFruit.delimiter = "{"
      expect(
        CountFruit.count
      ).to eq 5
    end
    it "count_by '['" do
      CountFruit.delimiter = "["
      expect(
        CountFruit.count
      ).to eq 0
    end
    it "solve" do
      expect(
        CountFruit.solve
      ).to eq 5
    end
  end
end
