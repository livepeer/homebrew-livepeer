cask "go-livepeer" do
  version "0.5.34"

  license "MIT"

  if OS.mac?
    platform = "darwin"
    if Hardware::CPU.intel?
      sha256 "5d3dd7d9d18c9c488f433b74b11c84091fd474575b362bc0e06bd91e686e8e2e"
      arch = "amd64"
    elsif Hardware::CPU.arm?
      sha256 "e10685dab9d89dd14f8055f54e203189e7faa83abe268fcc643dbf5f6caef074"
      arch = "arm64"
    end
  end

  if OS.linux?
    platform = "linux"
    if Hardware::CPU.intel?
      sha256 "49ddf35ddef03f5a77ef1dff8431123a74bf7406b715d9d9e39aed57c36acf4b"
      arch = "amd64"
    elsif Hardware::CPU.arm?
      sha256 "8763dd84eb8c8740f216b884cf8d22fbbda062a28d7748f0318511c57e83f6b3"
      arch = "arm64"
    end
  end

  url "https://github.com/livepeer/go-livepeer/releases/download/v#{version}/livepeer-#{platform}-#{arch}.tar.gz",
      verified: "github.com/livepeer/go-livepeer/"
  name "go-livepeer"
  desc "Official Go implementation of the Livepeer protocol"
  homepage "https://livepeer.org/"

  container_type :gzip

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
