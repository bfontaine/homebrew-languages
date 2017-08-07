class Clean < Formula
  desc "General purpose, pure and lazy functional programming language"
  homepage "https://wiki.clean.cs.ru.nl/Clean"
  url "http://clean.cs.ru.nl/download/Clean24/linux/Clean2.4Sources.tar.gz"
  version "2.4"
  sha256 "92201d738bde0508ca5621b5cdd552e2016df6bf11425f67c7762aac532d7acc"

  resource "bootstrap" do
    url "http://clean.cs.ru.nl/download/Clean24/linux/clean2.4_64_boot.tar.gz"
    sha256 "f9d4fac27ebea994f3fc3458cdbcb1acd5a350778c21a808fc9e172a6f50fa21"
  end

  def install
    inreplace "compiler/unix/make.macosx64.sh",
      "CLM=clm", "CLM=#{bin}/clm"

    # This fails on modern compilers
    inreplace "backendC/CleanCompilerSources/backend.h",
      "int inline,", "int inlineFlag,"

    system "make", "-C tools/clm", "-f Makefile.linux64"
    bin.install "tools/clm/clm"

    # TODO
    # See also http://wiki.clean.cs.ru.nl/Clean_on_Mac_OS_X (broken)
    #          http://wiki.clean.cs.ru.nl/Clean2.2_on_64bit_Xubuntu
    raise

    cd "compiler" do
      system "./unix/make.macosx64.sh"
    end
    # TODO
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test clean`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
