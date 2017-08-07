class Lily < Formula
  desc "Interpreted language with a focus on expressiveness and type safety"
  homepage "https://fascinatedbox.github.io/lily-site/"
  url "https://github.com/FascinatedBox/lily/archive/v1.1.tar.gz"
  sha256 "8d243707c8ee796d492644235134da0edb6b29231f06c568824e1e424e74b64f"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.lily").write 'print("Hello, world!")'
    system bin/"lily", "test.lily"
  end
end
