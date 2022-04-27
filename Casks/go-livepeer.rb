cask "go-livepeer" do
  arch = Hardware::CPU.intel? ? "amd64" : "arm64"
  platform = OS.mac? ? "darwin" : "linux"
  version "0.5.29"

  if arch == "amd64" && OS.mac?
    sha256 "a342177e47e72bee030533271d69c1316cccf5784e6cf5638a5452bd3021eaeb"
  elsif arch == "amd64" && OS.linux?
    sha256 "276936a0d3d3dea9fbacfc464ee1c12deddc4262c20427e0c3f9a2cfeeb1a6ac"
  elsif arch == "arm64"
    sha256 "1cf2b2c606d18e4c515256b8b364777312b62dffa92075557adde0d9265feec2"
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
