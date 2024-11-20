class AwsHelper < Formula
  desc "Helper functions for AWS SSO login management"
  homepage "https://github.com/YOUR_USERNAME/aws-helper"
  url "https://github.com/YOUR_USERNAME/aws-helper/archive/v1.0.0.tar.gz"
  sha256 "THE_SHA256_OF_YOUR_TARBALL"
  license "MIT"

  depends_on "aws-cli"
  depends_on "fzf"

  def install
    bin.install "src/aws-helper-functions.sh" => "awsm"
    
    # Install completion scripts
    bash_completion.install "completions/awsm.bash" => "awsm"
    zsh_completion.install "completions/awsm.zsh" => "_awsm"
  end

end