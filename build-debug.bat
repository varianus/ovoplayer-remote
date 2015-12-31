set Path=%PATH%;/usr/bin
set JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
cd /home/varianus/source/ovoplayer-remote
ant -Dtouchtest.enabled=true debug
