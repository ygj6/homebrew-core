require "language/node"

class FirebaseCli < Formula
  desc "Firebase command-line tools"
  homepage "https://firebase.google.com/docs/cli/"
  url "https://registry.npmjs.org/firebase-tools/-/firebase-tools-7.2.2.tgz"
  sha256 "f6464a91e24df20b86eb5d7218f346190d2df98651cb4de83615f5e5dc171bd2"
  head "https://github.com/firebase/firebase-tools.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "90d4393d5c91b38616448665a71434ad9f11437a941794aeb15da632cfcfa9e4" => :mojave
    sha256 "d7f2b7ee656dea27e573c2ca36f32147568dccadcb80effcc04d56aa431ba5b1" => :high_sierra
    sha256 "061c27677d130d8ca1b0b7d22a7b98f98c309d42422339a777373728ca901d0b" => :sierra
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"test.exp").write <<~EOS
      spawn #{bin}/firebase login:ci --no-localhost
      expect "Paste"
    EOS
    assert_match "authorization code", shell_output("expect -f test.exp")
  end
end
