cask "go-livepeer" do
  version "0.5.36"

  license "MIT"

  if OS.mac?
    platform = "darwin"
    if Hardware::CPU.intel?
      sha256 "fb70d2c148f389e95873422222021044126a7ad2c053e367c3ac78c9c3e0a37e"
      arch = "amd64"
    elsif Hardware::CPU.arm?
      sha256 "f5de617f09260cf254c6e90fe104dfda93dbf793ff7073b70bc09d2f62e36bba"
      arch = "arm64"
    end
  end

  if OS.linux?
    platform = "linux"
    if Hardware::CPU.intel?
      sha256 "8ab170ef849fa6e6324868733d6f6162f2fe066bd4b7348749194bb3e6257f08"
      arch = "amd64"
    elsif Hardware::CPU.arm?
      sha256 "76f28875465f9081af64b9b69d3ad9a94e627717cc43b77dd43ffe3254518e90"
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
