cask "go-livepeer" do
  arch = Hardware::CPU.intel? ? "amd64" : "arm64"
  platform = OS.mac? ? "darwin" : "linux"
  version "0.5.32"

  if arch == "amd64" && OS.mac?
    sha256 "08ee39bdbaf3276c3372a378872023645f1dd770091af52e6f2cebfcd9681f34"
  elsif arch == "amd64" && OS.linux?
    sha256 "bb0db5e296bfff0d1d0b00de11787bd6e3aebdc9acb9d4a08614710687e48f1e"
  elsif arch == "arm64"
    sha256 "3a808fafbd53631a52f722fc7e03cea0cff580be02fb5526cb27c4f28030b352"
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
