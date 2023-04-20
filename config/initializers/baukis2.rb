Rails.application.configure do
  config.baukis2 = {
    staff: { host: "baukis2.example.com", path: ""},
    admin: { host: "baukis2.example.com", path: "admin"},
    customer: { host: "example.com", path: "mypage"}
  }
end

# Rails.application.configureについて
# https://qiita.com/chshii/items/ffc26a4e3f3ef1d091d2
