require "spec_helper"

describe String do
  describe "#<<" do
    example "nilの追加できない", :exception do
      # pending("調査中")
      s = "ABC"
      # s << "nil"
      # expect(s.size).not_to eq(4)
      expect { s<< nil }.to raise_error(TypeError)
    end
  end
end

# example以下の記述に関して、以下のように書き換えることもできる
# it "appends a character " do
#   s = "ABC"
#   s << "D"
#   expect(s.size).to eq(4)
# end

# example "nilの追加できない", :exception do
# 上記のような記述でタグによって絞り込みができて、exceptionのついたエグザンブルだけをまとめて実行できる
# 実行コマンドは以下のとおり
# rspec spec --tag=exception
