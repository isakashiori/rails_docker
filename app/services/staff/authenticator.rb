class Staff::Authenticator
  def initialize(staff_member)
    @staff_member = staff_member
  end

  def authenticate(raw_password)
    @staff_member &&
      # !@staff_member.suspended? && 
      @staff_member.hashed_password &&
      @staff_member.start_date <= Date.today &&
      (@staff_member.end_date.nil? || @staff_member.end_date > Date.today) &&
      BCrypt::Password.new(@staff_member.hashed_password) == raw_password
  end
end

# sessionコントローラーの方で条件に当てはまったレコードのパスワードを引数に投げる
# ログイン不可フラグの判断をしているところを削除（本はなんか間違っているところを削除しているからムカつく）
# そうすることによってパスワードやメアドが間違っていない以上はsuspendedの条件分岐に行くから
# ここでフラッシュメッセージが発動される形になる
