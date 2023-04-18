class StaffMember < ApplicationRecord
  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end
end

# passwordメソッドの本引数(raw_password)に呼び出し元から受け取った仮引数が格納される
# raw_passwordが文字列の場合はbcyptがハッシュにしてhashed_passwordの変数の中に値を格納する
# もし文字列でもなく値がnilの場合に関してはnilをhashed_passwordに格納する
# ここで出てくるselfはStaffMemberクラスから生成されたインスタンスを指している
# なのでモデルのインスタンス.raw_passwordの状態でカラムに値を代入することができるのだと思う
# 別にselfをつけなくてもいいけどhashed_passwordという変数名があるのならそれが優先されるから、その場合に関してはselfをつけないといけない

