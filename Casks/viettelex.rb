cask "viettelex" do
  version "1.7.9"
  sha256 "1a081fc4ef38b2a544d5c75c019f9bfd5af8128ddf097e133b7051cb15a4c4cf"

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

  # Không còn postflight: Homebrew deprecate block Ruby `postflight` (issue #81,
  # 14/09/2026) và `postflight_steps` mới không cho system_command. lsregister -f
  # chỉ là best-effort — TIS tự quét ~/Library/Input Methods; caveat bên dưới đã
  # dặn đăng xuất/đăng nhập nếu chưa thấy.

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
