require 'formula'

class Delly < Formula
  homepage 'https://github.com/tobiasrausch/delly'
  version '0.3.3'
  url 'https://github.com/tobiasrausch/delly/releases/download/v0.3.3/delly_v0.3.3_linux_x86_64bit'
  sha1 '50db4727dc5d163338d59b48f79d9f7041b2bfd9'

  resource 'delly-source' do
    url 'https://github.com/tobiasrausch/delly/archive/v0.3.3.tar.gz'
    sha1 'b3537ee3276784356019fbb5c1b624d64f82469e'
  end

  def install
    raise 'delly not yet supported for MacOSX' if OS.mac?
    bin.install 'delly_v0.3.3_linux_x86_64bit' => 'delly'
    resource('delly-source').stage do
      (share/'delly').install Dir['src/*.py']
    end
  end

  test do
    system 'delly 2>&1 |grep -q delly'
  end
end
