cask "keelhaven" do
  version "0.3.0"
  sha256 "1cd90f670f413c4052eac8392233072e1086f88b914423de3cb357ef93014d83"

  url "https://github.com/keelapps/keelhaven/releases/download/v#{version}/Keelhaven-#{version}.dmg",
      verified: "github.com/keelapps/keelhaven/"
  name "Keelhaven"
  desc "Privacy-first backup menu bar app built on restic"
  homepage "https://keelhaven.app/"

  livecheck do
    url "https://github.com/keelapps/keelhaven"
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
