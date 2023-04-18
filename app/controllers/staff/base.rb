class Staff::Base < ApplicationController
  private def current_staff_member
    if session[:staff_member_id]
      @current_staff_member ||=
        StaffMember.find_by(id: session[:staff_member_id])
    end
  end

  helper_method :current_staff_member
end

# session[:staff_member_id]にnilがfalse以外の値が入っているのなら処理が行われる
# staffmemberのモデルの中から今ログインしているスタッフのidを探してきてインスタンス変数の中に格納する
# これでどこでも今ログインしているスタッフの情報を使うことができる
# ||=を使って遅延初期化というテクニックを使っている
# これは初回時にcurrent_staff_memberメソッドを呼んだ時の@current_staff_memberには何も
# 入っていないから右辺の処理が走るが
# 2回目以降は@current_staff_memberには値がもう格納されているので右辺の処理は行われず
# データペースへのアクセス回数を減らすことができてパフォーマンスの向上が狙えるらしい