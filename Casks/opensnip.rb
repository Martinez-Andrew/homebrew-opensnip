cask "opensnip" do
  version "0.1.0"
  sha256 "fa855e3ce998063fb7f692113782976ed763cfb3fe93e546ae18a338833cc23c"

  url "https://github.com/Martinez-Andrew/opensnip/releases/download/v#{version}/OpenSnip.zip"
  name "OpenSnip"
  desc "Capture screen regions and send them to Claude Code terminal sessions"
  homepage "https://github.com/Martinez-Andrew/opensnip"

  app "OpenSnip.app"

  binary "#{appdir}/OpenSnip.app/Contents/MacOS/OpenSnip", target: "opensnip-app"

  postflight do
    # Install the CLI script
    system_command "curl",
                   args: ["-fsSL", "-o", "/usr/local/bin/opensnip",
                          "https://raw.githubusercontent.com/Martinez-Andrew/opensnip/v#{version}/bin/opensnip"],
                   sudo: true
    system_command "chmod",
                   args: ["+x", "/usr/local/bin/opensnip"],
                   sudo: true
  end

  uninstall_postflight do
    system_command "rm",
                   args: ["-f", "/usr/local/bin/opensnip"],
                   sudo: true
  end

  zap trash: [
    "~/Library/Preferences/com.opensnip.app.plist",
  ]
end
