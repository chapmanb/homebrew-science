require 'formula'

class Qualimap < Formula

  homepage 'http://qualimap.bioinfo.cipf.es/'
  url 'http://qualimap.bioinfo.cipf.es/release/qualimap_v0.7.1.zip'
  sha1 '65be770802797998fa1a96fb3c12558b8b741052'

  depends_on 'r' => :optional

  def patches
    # fixes path setup for java libs and qualimap bin
    DATA
  end

  def install
    bin.install 'qualimap'
    libexec.install 'scripts'
    libexec.install 'species'
    libexec.install Dir['lib/*.jar']
    libexec.install 'qualimap.jar'
    (share/'java').install_symlink '../../libexec/qualimap.jar'
    doc.install 'QualimapManual.pdf'
  end

  def test
    system 'qualimap', '-h'
  end
end
__END__
--- a/qualimap	2013-04-19 14:07:42.000000000 -0500
+++ b/qualimap	2013-10-13 20:38:01.138915373 -0400
@@ -51,6 +51,7 @@
 
 # check if symbolic link
 
+if false; then
 while [ -h "$prg" ] ; do
     ls=`ls -ld "$prg"`
     link=`expr "$ls" : '.*-> \(.*\)$'`
@@ -61,6 +62,7 @@
     fi
 done
 
+fi
 
 shell_path=`dirname "$prg"`;
 absolute=`echo $shell_path | grep "^/"`;
@@ -76,8 +78,10 @@
 
 #echo $QUALIMAP_HOME
 #echo "ARGS are ${ARGS[@]}"
+export BREWDIR=$(echo $QUALIMAP_HOME | sed -e 's/bin$//g')
+export QUALIMAP_LIBDIR=$(dirname $(readlink -f $BREWDIR/share/java/qualimap.jar))
 
-java $java_options -classpath $QUALIMAP_HOME/qualimap.jar:$QUALIMAP_HOME/lib/* org.bioinfo.ngs.qc.qualimap.main.NgsSmartMain "${ARGS[@]}"
+java $java_options -classpath $QUALIMAP_LIBDIR/qualimap.jar:$QUALIMAP_LIBDIR/* org.bioinfo.ngs.qc.qualimap.main.NgsSmartMain "${ARGS[@]}"
 
 if [ -n "$OUTPUT_ADDITIONAL_HELP" ]; then 
     echo "Special arguments: "
