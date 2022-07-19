cask "go-livepeer" do
  arch = Hardware::CPU.intel? ? "amd64" : "arm64"
  platform = OS.mac? ? "darwin" : "linux"
  version "0.5.33"

  if arch == "amd64" && OS.mac?
    sha256 "b3c045f0d0764247d299e4c3f94fdb01cbdf65fec059853e4ec0426d9059982f"
  elsif arch == "amd64" && OS.linux?
    sha256 "93207cba5d5ea15cb0e9396811d15bcf039b351db53bef522626fd42d0afd877"
  elsif arch == "arm64"
    sha256 "0f4f486c30b48bc86355c36af26db06a74fd8dd4ca2264360bbdcdf0d5692987"
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
