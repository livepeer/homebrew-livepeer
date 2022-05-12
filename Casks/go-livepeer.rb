cask "go-livepeer" do
  arch = Hardware::CPU.intel? ? "amd64" : "arm64"
  platform = OS.mac? ? "darwin" : "linux"
  version "0.5.30"

  if arch == "amd64" && OS.mac?
    sha256 "a9ae50224263215dc747c850b8ed62ce33207778cfd4c6b351b5b5459481c44e"
  elsif arch == "amd64" && OS.linux?
    sha256 "e3c77841c96a17ddf950e0870099c3060d0680e471023d2cef4a8ebfbde16cf8"
  elsif arch == "arm64"
    sha256 "6e8aa09842d5700a059f71b1ceec81600959866a60132a292cb763a5b908bf8b"
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
