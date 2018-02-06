
export JAVA_HOME=/home/joshliu/dev_tools/jdk1.7.0_79
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib:$CLASSPATH
export NDK_HOME=/home/joshliu/dev_tools/android-ndk-r8e
export ANDROID_HOME=/home/joshliu/dev_tools/adt-bundle-linux-x64/sdk
export PATH=$JRE_HOME:$NDK_HOME:$JAVA_HOME/bin:$JRE_HOME/bin:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/tools:$PATH
export PATH=$PATH:/home/joshliu/Developer/depot_tools
#export CHROMIUM_BUILDTOOLS_PATH=/workdisk/git/blink_db_for_tbs_for_chromium_57/blink_core/lib/chromium_org/buildtools/

allcscope(){
find . -name "*.h" -o -name "*.cc" -o -name "*.cpp" -o -name "*.java" ! -path "*test*" ! -path "*Test*" > cscope.files
cscope -Rbq -i cscope.files
}

allctags(){
ctags -R --exclude=.git* --exclude=*test* --exclude=*Test* -f .tags
}

so2tags(){
    rm gdb.txt
    gdb $1 -ex "set logging redirect on" -ex "set pagination off" -ex "set logging on" -ex "info sources" -ex "quit"
    sed 's/,\s*/\n/g' gdb.txt > file_list.txt
    ctags --c++-kinds=+p --c-kinds=+p --fields=+iaS --extra=+q -L file_list.txt
    rm file_list.txt gdb.txt
    echo "Done."
}

jlog(){
if [ $# == 1 ]; then
    if [ "$1" == "-c" ]; then
        adb logcat -c
    else
        adb logcat|grep $1
    fi
else
    adb logcat
fi
}

run_nc(){
local_ip=`hostname -I`
nc_port=3456
echo "telnet $local_ip $nc_port"
nc -l $nc_port
}

git_alias(){
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.jcl 'clean -fd -e cscope* -e .tags -e *sublime*'
}

git_proxy(){
if [ "$1" == "reset" ]; then
  git config --global --unset http.proxy
  git config --global --unset https.proxy
elif [ "$1" == "set" ]; then
  git config --global http.proxy http://dev-proxy.oa.com:8080
  git config --global https.proxy https://dev-proxy.oa.com:8080
fi
}

git_alias

export PATH=$PATH:/home/joshliu/Developer/gradle-3.3/bin
export CCACHE_DIR=/harddisk/ccache_tmp/

source ~/git-completion.bash

