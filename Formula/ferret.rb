class Ferret < Formula
  desc "Clojure implementation for real time embedded control systems"
  homepage "http://ferret-lang.org/"
  url "https://github.com/nakkaya/ferret/archive/0.2.8.tar.gz"
  sha256 "bcf7011962a7acb7001c0038e0953fba5a95980b79308c7433a7032016aa1b9e"

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
