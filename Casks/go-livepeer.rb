cask "go-livepeer" do
  version "0.5.34"

  license "MIT"

  if OS.mac?
    platform = "darwin"
    if Hardware::CPU.intel?
      sha256 "769a6a86c7ca7d507257f66fee90a660fd39378a09bd654c22161bb97e8b1dd9"
      arch = "amd64"
    elsif Hardware::CPU.arm?
      sha256 "54dadfa57a9d5bdbed761763ad60c4cbd60802c4add72df4e59b8f740925f021"
      arch = "arm64"
    end
  end

  if OS.linux?
    platform = "linux"
    if Hardware::CPU.intel?
      sha256 "1a53c8ee0be0c93b9f1f6a2458ce469401b7623e577a3c22708446c0c21df5a9"
      arch = "amd64"
    elsif Hardware::CPU.arm?
      sha256 "fb27c59063d14e686f844c08cbe28a44519e475b3b18c3901411d206ba446c2a"
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
