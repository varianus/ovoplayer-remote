export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
cd /home/varianus/source/ovoplayer-remote
jarsigner -verify -verbose -certs /home/varianus/source/ovoplayer-remote/bin/ovoplayer-remote-release.apk
