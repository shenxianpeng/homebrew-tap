cask "keelhaven" do
  version "0.5.0"
  sha256 "58cc95d0c1e9994bd9c1f4c40208877919ab14207223812a9d87e4eb311d1bec"

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

  # Beta builds are ad-hoc signed, not Apple-notarized, so a Homebrew download
  # is quarantined and Gatekeeper would warn on first launch. Clearing the flag
  # here is the same thing the curl|bash installer does — it keeps `brew
  # install` frictionless. Drops out naturally once releases are notarized.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Keelhaven.app"]
  end

  zap trash: [
    "~/Library/Application Support/Keelhaven",
    "~/Library/Caches/com.keelhaven.Keelhaven",
    "~/Library/Preferences/com.keelhaven.Keelhaven.plist",
  ]

  caveats <<~EOS
    Repository passwords live in the macOS Keychain and are not removed by
    `brew uninstall --zap`.
  EOS
end
