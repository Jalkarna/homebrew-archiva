class Archiva < Formula
  desc "Git-native decision memory for AI coding agents"
  homepage "https://github.com/Jalkarna/archiva"
  url "https://github.com/Jalkarna/archiva/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "a3e7e3769b80c6c8cdf4d564b0e341da55716e0fbfa054cf82471875d85fc175"
  license "MIT"
  head "https://github.com/Jalkarna/archiva.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/archiva --version")

    (testpath/"sample.rs").write <<~RUST
      pub fn smoke(value: i32) -> i32 {
          if value > 0 {
              value + 1
          } else {
              value
          }
      }
    RUST

    system bin/"archiva", "init"
    pipe_output "#{bin}/archiva write-decision", <<~JSON, 0
      {"file":"sample.rs","anchor":"fn:smoke","lines":[1,7],"chose":"homebrew formula smoke decision","because":"the formula test must prove the installed Rust binary can initialize storage, write a decision, read it back, and lint cleanly","rejected":[{"approach":"version-only formula test","reason":"that would not exercise Archiva storage or source-anchor behavior"}]}
    JSON

    assert_match "homebrew formula smoke decision", shell_output("#{bin}/archiva why sample.rs fn:smoke")
    assert_match "1 decisions", shell_output("#{bin}/archiva status")
    assert_match "No decision issues found", shell_output("#{bin}/archiva lint")
  end
end
