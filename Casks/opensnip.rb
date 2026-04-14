cask "opensnip" do
  version "0.1.1"
  sha256 "f3cb536e53e615edb20b93a889e0b357f9be34471267657a765917e146feb650"

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
