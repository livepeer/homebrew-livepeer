class GoLivepeer < Formula
  desc "Official Go implementation of the Livepeer protocol"
  homepage "https://livepeer.org/"
  url "https://github.com/livepeer/go-livepeer.git",
      tag:      "v0.5.29",
      revision: "d85cb21937a0c302f0929889151ad7b3351994d2"
  license "MIT"
  head "https://github.com/livepeer/go-livepeer.git",
       branch: "master"

  option "with-dev", "build with support for only development networks"

  depends_on "autoconf" => :build
  depends_on "go" => :build
  depends_on "pkg-config" => :build

  on_macos do
    depends_on "coreutils" => :build
    depends_on "llvm" => :build
  end

  def install
    tags = ((build.with? "dev") && "dev") || "mainnet"
    system "./install_ffmpeg.sh", (ENV["HOME"]).to_s
    ENV["BUILD_TAGS"] = tags
    ENV["PKG_CONFIG_PATH"] = "#{ENV["HOME"]}/compiled/lib/pkgconfig"
    system "make", "livepeer"
    bin.install "livepeer"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test go-livepeer`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
