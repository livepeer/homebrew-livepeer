cask "go-livepeer" do
  version "0.5.33"

  license "MIT"

  if OS.mac?
    platform = "darwin"
    if Hardware::CPU.intel?
      sha256 "b3c045f0d0764247d299e4c3f94fdb01cbdf65fec059853e4ec0426d9059982f"
      arch = "amd64"
    elsif Hardware::CPU.arm?
      sha256 "0f4f486c30b48bc86355c36af26db06a74fd8dd4ca2264360bbdcdf0d5692987"
      arch = "arm64"
    end
  end

  if OS.linux?
    platform = "linux"
    if Hardware::CPU.intel?
      sha256 "93207cba5d5ea15cb0e9396811d15bcf039b351db53bef522626fd42d0afd877"
      arch = "amd64"
    elsif Hardware::CPU.arm?
      sha256 "7d062d106272bbf1645a2b5d8a276a1a5944fdbbb530b0def1c9c3b5d2d247b4"
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
