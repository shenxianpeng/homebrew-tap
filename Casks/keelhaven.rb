cask "keelhaven" do
  version "0.9.1"
  sha256 "b9d19892487cd647ba56df831f6ba7688f1b547cded4ce92aadf9db62a0abd89"

  url "https://github.com/shenxianpeng/keelhaven/releases/download/v#{version}/Keelhaven-#{version}.dmg",
      verified: "github.com/shenxianpeng/keelhaven/"
  name "Keelhaven"
  desc "Privacy-first backups to storage you own"
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
