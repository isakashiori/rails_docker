class Staff::LoginForm
  include ActiveModel::Model

  attr_accessor :email, :password
end

# ActiveRecord::Baseクラスを継承しないこと
# ActiveModel::Modelをincludeすること
# 上記をincludeすることによってform_withのmodelオプションに指定できるようになる

# 上記がフォームオブジェクトを作成する上で条件になる
# https://qiita.com/alpaca_taichou/items/bebace92f06af3f32898
# ここの処理はログイン処理になっていて、DBに保存処理になっている