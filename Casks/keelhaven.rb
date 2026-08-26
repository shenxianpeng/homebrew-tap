cask "keelhaven" do
  version "0.1.0"
  sha256 "80c087f60adcd183364e108aa0ac3f32107e6d09c72d1965615b096b11f0b8dc"

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
