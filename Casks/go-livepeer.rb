cask "go-livepeer" do
  arch = Hardware::CPU.intel? ? "amd64" : "arm64"
  platform = OS.mac? ? "darwin" : "linux"
  version "0.5.31"

  if arch == "amd64" && OS.mac?
    sha256 "bd018ba81c91d76c6525546e242ce672187cc168aa34f80b9d66670a7418ee5b"
  elsif arch == "amd64" && OS.linux?
    sha256 "40e605422b0a7d0f26275d9c8e0de02fc4b1005844259c36f84ca0a53bf19f3e"
  elsif arch == "arm64"
    sha256 "119ee9ffd4a92084b29ca1b264301817b627e236ac947e4d78385ff21a3e92fc"
  end

  url "https://github.com/livepeer/go-livepeer/releases/download/v#{version}/livepeer-#{platform}-#{arch}.tar.gz",
      verified: "github.com/livepeer/go-livepeer/"
  name "go-livepeer"
  desc "Official Go implementation of the Livepeer protocol"
  homepage "https://livepeer.org/"

  livecheck do
    url "https://github.com/livepeer/go-livepeer/releases/latest/"
    strategy :header_match do |headers|
      id = headers["location"][/(\d+\.\d+\.\d+)$/, 1]

      id.to_s
    end
  end

  conflicts_with formula: "go-livepeer"

  binary "livepeer-#{platform}-#{arch}/livepeer"
  binary "livepeer-#{platform}-#{arch}/livepeer_bench"
  binary "livepeer-#{platform}-#{arch}/livepeer_cli"
  binary "livepeer-#{platform}-#{arch}/livepeer_router"
end
