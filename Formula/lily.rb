class Lily < Formula
  desc "Interpreted language with a focus on expressiveness and type safety"
  homepage "https://jesserayadkins.github.io/lily/"
  url "https://github.com/jesserayadkins/lily/archive/v0.16.tar.gz"
  sha256 "eabe9624154bc2080e2898dec0556ba2e89daf549f81b81cb66d4ffd277f4553"

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
