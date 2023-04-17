class ApplicationController < ActionController::Base
  layout :set_layout
  # 上記のようにレイアウトをシンボルで指定すると、
  # リクエストが実際に処理されるまでレイアウトの選択を先延ばしにすることができる
  # なのでコントローラーの名前がstaffでリクエストが来たときにset_layoutのレイアウトを表示させてあげる仕組み
  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end

  include ErrorHandlers if Rails.env.production?

  private def set_layout
    if params[:controller].match(%r{\A(staff|admin|customer)/})
      Regexp.last_match[1]
    else
      "customer"
    end
  end

end
# if以後のコードの意味に関しては、以下の通りになる
# params[:controller]で今リクエストを送っているコントローラーの名前を取得してくる（staff#top）
# matchはレシーバー（staff#top)がmatch以下の引数の条件にマッチするかを確認するメソッド、引数には正規表現をとる
# %rは正規表現を作るパーセント記法
# \Aは取得してきたコントローラー名（レシーバー）がstaff,admin,customerのいづれかの文字列が文頭にくるのか確認する正規表現
# Regexp.last_match[1]この意味としては以下のとおり
# もし、staff/topのコントローラー名で来た時、match以下の正規表現の記述ではstaff/までの内容を取得してくる
# なぜか\以下では()で囲っていることからキャプチャが効いている、また最後の/があることからmatchの結果としてはstaff/までを取得
# そしてキャプチャした内容は配列[1]から取得できる、なのでインデックスは[1]を指定してあげないといけない
# [2]がnilになる理由として、キャプチャしたものが一つしかないから、もし最後の/をキャプチャしてくるのであれば[2]にスラッシュが入ると思われる
# 結果的にset_layoutメソッドの戻り値はstaff、admin、customerのいづれかになり
# layout :admin layout :staff layout :customerみたいな感じなって
# app/views/layouts/admin.html.erbみたいな感じで該当のコントローラーに対応してレイアウトも呼ばれる形になる

# p Regexp.last_match[0] =>staff/  
# p Regexp.last_match[1] =>staff  
# p Regexp.last_match[2] =>nil


