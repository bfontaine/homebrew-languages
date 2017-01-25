class Kona < Formula
  desc "Open-source implementation of the K programming language"
  homepage "https://kona.github.io/"
  url "https://github.com/kevinlawler/kona/archive/Win.3.39-69.tar.gz"
  version "3.39-69"
  sha256 "846b586c89bb18048028a0d623c6322148e366b132ea73b288ea34ef1833d0ed"
  head "https://github.com/kevinlawler/kona.git"

  def install
    system "make"
    bin.mkpath
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"test.k").write "2+2+38\n\\\\\n"
    assert_equal "42", shell_output("#{bin}/k test.k").chomp
  end
end
