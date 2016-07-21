export PATH=/usr/bin:$PATH
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
cd /home/varianus/source/ovoplayer-remote
ant -Dtouchtest.enabled=true debug
