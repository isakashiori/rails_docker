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
        # staffmemberモデルの中からfind_byでマッチしたレコードを取得してstaff_member変数の中に格納している
      # find_byはカラム名もしくは検索条件によってデータを探しに行く
      # 上記は検索条件によってデータを探しにいっている
      # またfind_byは最初にマッチしたデータしか取得してこない
      # それでもいい理由に関しては、メアドはユニークで設定しているから重複がないから
      # @formで取得してきたレコードのメアドをプレスホルダーに格納して検索していく
      # それをstaf_member変数の中に格納していく
    end
    if Staff::Authenticator.new(staff_member).authenticate(@form.password)
      # Staff::Authenticatorモデルのインスタンスを作成して引数にstaff_memberを入れる
      # staff_memberの変数とは一個上のif文の中で定義されている
      # authenticateメソッドはサービスオブジェクトに定義されているメソッドになっている

      if staff_member.suspended?
        flash.now.alert = "アカウントが停止されています"
        render action: "new"
      else
        session[:staff_member_id] = staff_member.id
        flash.notice = "ログインしました"
        redirect_to :staff_root
      end
    else
      flash.now.alert = "メールアドレスまたはパスワードが正しくありません"
      render action: "new"
    end
  end

  def destroy
    session.delete(:staff_member_id)
    flash.notice = "ログアウトしました"
    redirect_to :staff_root
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




