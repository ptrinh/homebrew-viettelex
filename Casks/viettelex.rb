cask "viettelex" do
  version "1.6.5"
  sha256 "a5864c791c996984d7d4c774e5bc0167ce9d2bea748665e81486c1e274e9d507"

  url "https://github.com/ptrinh/viettelex/releases/download/v#{version}/VietTelex-#{version}.app.zip"
  name "ViệtTelex"
  desc "Vietnamese Telex input method"
  homepage "https://github.com/ptrinh/viettelex"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  # Input methods must live in ~/Library/Input Methods (the pkg installer is
  # user-home domain, which `installer -target /` can't run — hence artifact).
  artifact "VietTelex.app", target: "~/Library/Input Methods/VietTelex.app"

  postflight do
    lsregister = "/System/Library/Frameworks/CoreServices.framework/Frameworks/" \
                 "LaunchServices.framework/Support/lsregister"
    system_command lsregister,
                   args: ["-f", "#{Dir.home}/Library/Input Methods/VietTelex.app"]
  end

  uninstall quit: "com.viettelex.inputmethod.telex"

  zap trash: "~/Library/Preferences/com.viettelex.settings.plist"

  caveats <<~EOS
    Thêm bộ gõ: System Settings → Keyboard → Input Sources → ＋ →
    Vietnamese → ViệtTelex → Add.
    (Nếu chưa thấy ViệtTelex trong danh sách, đăng xuất/đăng nhập một lần.)

    Gõ tiếng Việt trong Terminal/iTerm/Chrome: bật quyền Accessibility cho
    VietTelex trong System Settings → Privacy & Security → Accessibility.
  EOS
end
