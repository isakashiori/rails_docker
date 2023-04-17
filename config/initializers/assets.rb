
Rails.application.config.assets.version = '1.0'
# 上記設定はアセットに対するダイジェストの生成に関わっている
# 逆に言えばこのバージョンを変更することでアセットを強制的に期限切れにすることも可能

Rails.application.config.assets.paths << Rails.root.join('node_modules')

# 上記の設定は探索パスの設定になる
# 初期状態ではyarnというパッケージマネージャーのnode_modulesディレクトリが追加されるようになっている

Rails.application.config.assets.precompile += %w( staff.css customer.css admin.css )

# プリコンパイルするファイルを配列で指定する
# デフォルトではapplicaion.js,application.css,app/assetsは以下のjs,css以外の全てのファイルがデフォルトで対象となっている

# https://qiita.com/shizuma/items/1980bf885906c73238b6
