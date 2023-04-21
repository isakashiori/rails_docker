class Admin::StaffMembersController < Admin::Base
  class Admin::StaffMembersController < Admin::Base
    def index
      @staff_members = StaffMember.order(:family_name_kana, :given_name_kana)
    end

    def show
      staff_member = StaffMember.find(params[:id])
      redirect_to [ :edit, :admin, staff_member ]
    end

    def new
      @staff_member = StaffMember.new
    end

    def edit
      @staff_member = StaffMember.find(params[:id])
    end

    def create
      @staff_member = StaffMember.new(params[:staff_member])
      if @staff_member.save
        flash.notice = "職員アカウントを新規登録しました"
        redirect_to :admin_staff_members
      else
        render action: "new"
      end
    end

    def updated_at
      @staff_member = StaffMember.find(params[:id])
      @staff_member.assign_attributes(params[:staff_member])
      if @staff_member.save
        flash.notice = "職員アカウントを更新しました"
        redirect_to :admin_staff_members
      else
        render action: "edit"
      end
    end

    def destroy
      staff_member = StaffMember.find(params[:id])
      staff_member.destroy!
      flash.notice = "職員アカウントを削除しました"
      redirect_to :admin_staff_members
    end
  end
end

# StaffMemberのフォームオブジェクトからインスタンスを作成して
# ここでのパラメーターのキーはidを設定している
# newアクションにてフォームオブジェクトのインスタンスを作成している
# そのインスタンスをインスタンス変数に格納して、viewに渡す
# 中身は最初は空っぽやから、createアクションに飛ばされる
# params[:staff_member]にはフォームで登録されたすべての値が入ることになる
# ストロングパラメーターを設定していない
# それぞれのパラメーター名を引数に設定しているかなのか?不要ってことなのか？
# params[:モデル名]にすると入力情報がすべて取得してくることができる
# 上記のやり方はrequire.permitでも同じ結果になるけれど、前者はrequire: falseになっているので
# マスアサイメントによる不適切なデータを受け取ったりすることができる