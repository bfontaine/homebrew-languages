class Ferret < Formula
  desc "Clojure implementation for real time embedded control systems"
  homepage "http://ferret-lang.org/"
  url "https://github.com/nakkaya/ferret/archive/0.2.6.tar.gz"
  sha256 "d72e9672c755eafec899b7d241447e73e443add0be10b6fe0513d34be546adf3"

  depends_on "emacs" => :build
  depends_on "leiningen" => :build

  def install
    system "./build"
    libexec.install "src/target/ferret.jar"
    bin.write_jar_script "#{libexec}/ferret.jar", "ferret"
  end

  test do
    (testpath/"core.clj").write '(println "hello")'
    system bin/"ferret", "-i", "core.clj"
    assert File.exist?("core.cpp")
    system ENV.cxx, "-std=c++11", "core.cpp", "-o", "test"
    assert_equal "hello", shell_output("./test").chomp
  end
end
