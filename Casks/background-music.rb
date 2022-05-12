cask "background-music" do
  version "0.3.2"
  sha256 "0cd7b488b5ab97a1ecb496e484a6c209c29f35ab503e6f73b45e56719a7aba18"

  url "https://github.com/kyleneideck/BackgroundMusic/releases/download/v#{version}/BackgroundMusic-#{version}.pkg"
  name "Background Music"
  desc "Audio Utility"
  homepage "https://github.com/kyleneideck/BackgroundMusic"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :yosemite"

  pkg "BackgroundMusic-#{version}.pkg"

  uninstall pkgutil:   "com.bearisdriving.BGM",
            quit:      "com.bearisdriving.BGM.App",
            launchctl: "com.bearisdriving.BGM.XPCHelper",
            delete:    "/usr/local/libexec/BGMXPCHelper.xpc",
            script:    {
                         executable: "/usr/bin/dscl . -delete /Users/_BGMXPCHelper",
                         sudo: true
                       },
            script:    {
                         executable: "/usr/bin/dscl . -delete /Groups/_BGMXPCHelper",
                         sudo: true
                       },
            script:    {
                         executable: "/bin/launchctl kickstart -kp system/com.apple.audio.coreaudiod",
                         sudo: true
                       }

  zap trash: "~/Library/Preferences/com.bearisdriving.BGM.App.plist"
end
