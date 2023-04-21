StaffMember.create!(
  email: "taro@example.com",
  family_name: "山田",
  given_name: "太郎",
  family_name_kana: "ヤマダ",
  given_name_kana: "タロウ",
  password: "password",
  start_date: Date.today
)

family_name = %w{
  大道:オオミチ:omitci
  鈴木:スズキ:suzuki
  高橋:タカハシ:takahashi
  田中:タナカ:tanaka
}

given_name = %w{
  二郎:ジロウ:jiro
  山廊:サンロウ:sanrou
  松子:マツコ:matsuko
  梅子:ウメコ:umeko
}

4.times do |n|
  fn = family_name[n % 4].split(":")
  gn = given_name[n % 4].split(":")

# 上記のコード何しているんかいに不明やねんけど
# だってtimesで0からnに格納されていって
# 例えば0やったら0/4=0になってfamily_name[0]になって佐藤さんの配列がsplitで区切られるってことやろ
# 次は1が来て4の余りは丸め誤差で1になる感じでfamily_name[1]って感じになる

  StaffMember.create!(
    email: "#{fn[2]}.#{gn[2]}@example.com",
    family_name: fn[0],
    given_name: gn[0],
    family_name_kana: fn[1],
    given_name_kana: gn[1],
    password: "password",
    start_date: (100 - n ).days.ago.to_date,
    end_date: n == 0 ? Date.today : nil,
    suspended: n == 1
  )
end
# fnの中には例えば、佐藤,サトウ,satoの状態で配列で格納されている
# だからfn[2]となればローマ字を取得してくる
# gn[2]も同じ

# これ上記のコードについて、何回もdb:seedするときに重複エラーが発生する理由として
# マイグレーションファイルの方でメールアドレスはユニーク制約しているから
# 何回やってもエラーになるで合ってると思う
# ほんまにこの教科書むかつくやけどちゃんと校閲したんか
# じゃどうするかめんどくさいからtimesのところの回数だけ変えたらいいか
# そしたら重複することないか
# 回数を減らしたらうまくいったぽいやっぱり上の仮説であってた
