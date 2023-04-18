class Staff::SessionsController < Staff::Base
  def new
    if current_staff_member
      redirect_to :staff_root
    else
      @form = Staff::LoginForm.new
      render action: "new"
    end
  end

  def create
    @form = Staff::LoginForm.new(params[:staff_login_form])
    if @form.email.present?
      staff_member =
        StaffMember.find_by("LOWER(email) = ?", @form.email.downcase)
    end
    if staff_member
      session[:staff_member_id] = staff_member.id
      redirect_to :staff_root
    else
      render action: "new"
    end
  end
end

# staff::baseクラスから継承しているので、current_staff_memberメソッドが使える
# そのメソッドの戻り値があればredirect_toでスタッフページのトップページに飛ばす
# もしメソッドの戻り値がないならフォームオブジェクトのインスタンスを作ってそれをインスタンス変数に格納
# そのインスタンス変数を保持したままnewページに飛ばす

# createメソッドにおいて
# params[:staff_login_form]でなぜパラメータ名が:staff_login_formになっているのか
# なぜならformオブジェクトではクラス名がStaff::LoginFormになるのでフォームを送ってきた時の
# ハッシュ名はstaff_login_formになる、これでメアドとパスワードが取得できる
# いつもやっているparams.requireの書き方じゃないけどこういう書き方もあるということ