cask "go-livepeer" do
  version "0.5.38"

  license "MIT"

  if OS.mac?
    platform = "darwin"
    if on_intel
      sha256 "e2ef5fd9bd15d447181dcdf78634ad02ed2d5f4af39dbd9ef0651337cfddf835"
      arch = "amd64"
    elsif on_arm
      sha256 "152e776d28fa25472db98f4fd01c6735116482f63fafb393032f37f412b421f1"
      arch = "arm64"
    end
  end

  if OS.linux?
    platform = "linux"
    if on_intel
      sha256 "24fe5350a1179f7ca63815431173296fac1842f31088a4b70cfcb1a87b9677ff"
      arch = "amd64"
    elsif on_arm
      sha256 "508ec95f7a2a4b44a8da9704005f11d4ab9b23beab1156bfaeae9bf5a9a41ca8"
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
