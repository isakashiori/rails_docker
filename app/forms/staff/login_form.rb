class Staff::LoginForm
  include ActiveModel::Model

  attr_accessor :email, :password
end

# ActiveRecord::Baseクラスを継承しないこと
# ActiveModel::Modelをincludeすること
# 上記がフォームオブジェクトを作成する上で条件になる