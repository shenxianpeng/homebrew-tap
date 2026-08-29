cask "keelhaven" do
  version "0.4.0"
  sha256 "cb0d774fa36048180a32738c7afb18f40b6e433dbe617637803c953b166e26ef"

  url "https://github.com/shenxianpeng/keelhaven/releases/download/v#{version}/Keelhaven-#{version}.dmg",
      verified: "github.com/shenxianpeng/keelhaven/"
  name "Keelhaven"
  desc "Privacy-first backup menu bar app built on restic"
  homepage "https://keelhaven.app/"

  livecheck do
    url "https://github.com/shenxianpeng/keelhaven"
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Keelhaven.app"

  zap trash: [
    "~/Library/Application Support/Keelhaven",
    "~/Library/Caches/com.keelhaven.Keelhaven",
    "~/Library/Preferences/com.keelhaven.Keelhaven.plist",
  ]

  caveats <<~EOS
    Beta builds are not notarized by Apple, so macOS warns on first launch.
    Allow it once: System Settings > Privacy & Security > Open Anyway
    (macOS 15), or right-click the app > Open > Open (macOS 14).

    Repository passwords live in the macOS Keychain and are not removed by
    `brew uninstall --zap`.
  EOS
end
