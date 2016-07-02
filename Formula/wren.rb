class Wren < Formula
  desc "Small, fast, class-based concurrent scripting language"
  homepage "http://wren.io/"
  url "https://github.com/munificent/wren/archive/0.1.0.tar.gz"
  sha256 "ebf8687dfdb55997a3fc263d41f306c6f40d9562ccbd945d9c12c48795388eae"

  depends_on "libuv"

  # Enable verbose builds
  patch do
    url "https://github.com/munificent/wren/pull/375.patch"
    sha256 "e6710ee678e0d4dc403041620cd35f797a1bfda116fd29a566665d9bf216cf43"
  end

  def install
    libuv = "#{Formula["libuv"].lib}/libuv.a"

    # Trick the Makefile to let it think it installed libuv
    # https://github.com/munificent/wren/issues/374
    gyp = (buildpath/"deps/libuv/build/gyp/gyp")
    gyp.mkpath

    system "make", "-f", "util/wren.mk",
                   "-o", gyp,
                   "-o", libuv,
                   "VERBOSE=1",
                   "LIBUV=#{libuv}"

    prefix.install "lib"
    bin.install "bin/wren"
  end

  test do
    (testpath/"test.wren").write 'System.print("Hello, world!")'
    system bin/"wren", "test.wren"
  end
end
