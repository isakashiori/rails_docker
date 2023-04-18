table_names = %w(staff_members administrators)

table_names.each do |table_names|
  path = Rails.root.join("db", "seeds", Rails.env, "#{table_names}.rb")
  if File.exist?(path)
    puts "Creating #{table_names}...."
    require(path)
  end
end

# Rails.rootはrailsアプリのルートディレクトリからのパスを生成する
# join以降で任意のファイルパスも繋げることもできる
# Rails.envはdevelopやtestなどの現在の実行環境に応じていづれかの文字列が入る
# File.exist?のメソッドの引数にはファイルパスが入るが、絶対パスでなくても相対パスでも大丈夫だそう
# 相対パスを使用する場合には、現在のディレクトリがrailsアプリのルートディレクトリであることが前提
# そうでないのであれば絶対パスで指定すること、なのでRails.root.が使われていたということ