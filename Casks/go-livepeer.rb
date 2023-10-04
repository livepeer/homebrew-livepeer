cask "go-livepeer" do
  version "0.7.0"

  license "MIT"

  if OS.mac?
    platform = "darwin"
    if on_intel
      sha256 "573ca09dbeb2a6455dcd246d9a51f412196b0f331db20af08fc54574c0b6a8fc"
      arch = "amd64"
    elsif on_arm
      sha256 "7069882a7650150939311695f4c16d93743dfecfc754338ab27a06c71e0db997"
      arch = "arm64"
    end
  end

  if OS.linux?
    platform = "linux"
    if on_intel
      sha256 "398c04d063030200452bfffeb9d24b7ec0a585c7e514f53dc14001142f6690bb"
      arch = "amd64"
    elsif on_arm
      sha256 "27df7a9ae166d4d4cdf59e85e05bf7cf32192060be1ceb14cf65b81e202bbcf3"
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
