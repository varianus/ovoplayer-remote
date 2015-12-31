set JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
cd /home/varianus/source/ovoplayer-remote
keytool -genkey -v -keystore ovoplayer-remote-release.keystore -alias ovoplayer-remotealiaskey -keyalg RSA -keysize 2048 -validity 10000 < /home/varianus/source/ovoplayer-remote/keytool_input.txt
