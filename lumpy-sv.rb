class LumpySv < Formula
  homepage "https://github.com/arq5x/lumpy-sv"
  # doi "10.1186/gb-2014-15-6-r84"
  # tag "bioinformatics"
  url "https://github.com/arq5x/lumpy-sv/releases/download/0.2.11/lumpy-sv-0.2.11.tar.gz"
  sha1 "ad4bbd5054d1a98fa2974217459bd61e0d5f255f"

  resource "bamkit" do
    url "https://github.com/cc2qe/bamkit/archive/6b8c20.zip"
    sha1 "b70bd6749247558bdf94ed258491e1712034cb51"
  end

  bottle do
    root_url "https://downloads.sf.net/project/machomebrew/Bottles/science"
    cellar :any
    sha1 "76b8040a6bb5586829cee50723ada9b0a08c95db" => :yosemite
    sha1 "347569ef2f558c13cc860857113e287ed046fb31" => :mavericks
    sha1 "9a951d727f67fc9a315d26a260d0ad4f1b69cd6f" => :mountain_lion
  end

  depends_on "samblaster" => :optional
  depends_on "samtools" => :optional
  depends_on "sambamba" => :optional
  depends_on "bwa" => :optional

  def install
    ENV.deparallelize
    inreplace 'scripts/lumpyexpress.config' do |s|
      s.change_make_var! "LUMPY_HOME", "#{HOMEBREW_PREFIX}/share/lumpy-sv"
    end
    system "make"
    bin.install "bin/lumpy"
    bin.install Dir['scripts/lumpyexpress*']
    (share/"lumpy-sv/scripts").install Dir["scripts/*"]
    resource("bamkit").stage {
      (share/"lumpy-sv/scripts/bamkit").install Dir["*"]
    }
  end

  test do
    system "#{bin}/lumpy 2>&1 |grep -q structural"
    system "#{bin}/lumpyexpress 2>&1 |grep -q lumpyexpress"
  end
end
