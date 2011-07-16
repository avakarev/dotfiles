export JSTESTDRIVER_HOME=~/bin/jstestdriver
export SVN_EDITOR=vi
export NODE_PATH=/usr/local/lib/node
export YUI_JAR=~/bin/yuicompressor/yui-compressor-hacked.jar
export PERL5LIB=$PERL5LIB:~/bin/ycssjs
PATH=$PATH:~/bin:~/bin/ycssjs:~/bin/ycssjs/Yandex:~/bin/jslint4java:/Developer/usr/bin:/opt/local/bin
export PATH

function svndiff() { svn diff $@ | colordiff | less -SR; }