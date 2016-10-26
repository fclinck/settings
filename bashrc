export PERCEPTION_KIT_PATH=/other/workspace/perception/perception_kit
export NEXUS_PATH=/other/workspace/nexus
export NRV_QCBOT_PATH=/other/workspace/nrv/qcbot
export NRV_6DOF_PATH=/other/workspace/nrv/6dof
export NRV_RPR_PATH=/other/workspace/nrv/rpr
export NRV_PATH=/other/workspace/nrv
export NRV_CORE_PATH=/other/workspace/nrv/core
export VROS_PATH=/other/workspace/vros
export ROBOT_SERVICES_HOST=localhost
export GAZEBO_MODEL_PATH=$VROS_PATH/src/original/vurdf:$VROS_PATH/src/original/vlaunch/config/models
HOSTNAME=`hostname`
if [ $HOSTNAME = "batman" ]; then
  source $VROS_PATH/setup.bash
fi
if [ $HOSTNAME = "gershwin" ]; then
  source $VROS_PATH/devel/setup.bash
  export ROS_WORKSPACE=$VROS_PATH
  export MAVENREPO_PATH=/other/maven/mavenRepository
  export ROS_MAVEN_DEPLOYMENT_REPOSITORY=$MAVENREPO_PATH
  export ROS_MAVEN_REPOSITORY=http://nexus.crl.vecna.com:8081/nexus/content/repositories/releases
  export ROS_MAVEN_PATH=$ROS_MAVEN_DEPLOYMENT_REPOSITORY:$ROS_MAVEN_PATH
  export ROS_SHARE_PATH=$ROS_WORKSPACE/devel/share:$ROS_PACKAGE_PATH
fi

export ROS_MASTER_URI=http://localhost:11311
export PATH=$NRV_QCBOT_PATH/scripts::$PATH

#perception path variables
export INCLUDE_PATH=/usr/include/eigen3:/opt/ros/fuerte/include:/opt/ros/fuerte/include/opencv
export CPATH=$CPATH:$INCLUDE_PATH
export C_INCLUDE_PATH=$INCLUDE_PATH:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=$INCLUDE_PATH:$
export ROS_HOME=/other/logs/.ros
TOMCAT_HOME=/opt/tomcat
export TOMCAT_HOME
CATALINA_BASE=$TOMCAT_HOME
export CATALINA_BASE
export CATALINE_PID=$CATALINA_HOME/pid
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'

export JRE_HOME=/other/jdk
export JAVA_HOME=/other/java


#VROS bash additions

source ~/.git-completion.sh
source ~/.git-prompt.sh
export PS1='\[\u@\h \W$(__git_ps1 " (%s)")\]\$ '
COLUMNS=250

HISTSIZE=25000



# Define a few Color's
BLACK='\[\e[0;30m\]'
BLUE='\[\e[0;34m\]'
GREEN='\[\e[0;32m\]'
CYAN='\[\e[0;36m\]'
RED='\[\e[0;31m\]'
PURPLE='\[\e[0;35m\]'
BROWN='\[\e[0;33m\]'
LIGHTGRAY='\[\e[0;37m\]'
DARKGRAY='\[\e[1;30m\]'
LIGHTBLUE='\[\e[1;34m\]'
IGHTGREEN='\[\e[1;32m\]'
LIGHTCYAN='\[\e[1;36m\]'
LIGHTRED='\[\e[1;31m\]'
LIGHTPURPLE='\[\e[1;35m\]'
YELLOW='\[\e[1;33m\]'
WHITE='\[\e[1;37m\]'
CLEAR='\[\e[0m\]'              # No Color

function highlight ()
{
${@:1} | GREP_COLORS='mt=01;31' grep -iE --color=always "Error|FAIL|$" | GREP_COLORS='mt=01;33' grep -iE --color=always "Warning|$" | GREP_COLORS='mt=01;35' grep -iE --color=always "Finished|$" | GREP_COLORS='mt=01;32' grep -iE --color=always "SUCCESS|$" | GREP_COLORS='mt=01;36' grep -iE --color=always "Starting|$";
}

export TWILIO_NUM='7742512317'
export PHONE_NUM='7749949609'
export NEIL_PHONE_NUM='7742173523'
export COMPUTER_NAME='jagermech'

function alert-on-message() {
  read a || exit;
  now=$(date +"%T");
  echo "$now:Robot Alert!";
    (send_text) & (aplay /other/workspace/nrv/qcbot/src/main/resources/audio/robot_alert.wav) &
    (sleep 0.5 && wmctrl -F -a "Alert" -b add,above) & (zenity --warning --title="Alert" --text="[$now]: Robot in Need of Help!");
    alert-on-message;
}

alias send_text="curl -X  POST 'https://api.twilio.com/2010-04-01/Accounts/ACfa516552d234c7fdb0e3fa2fb5b0893a/Messages.json' -u 'ACfa516552d234c7fdb0e3fa2fb5b0893a:1049232d1b03c409372ca48dc4eb0897' -d 'From=${TWILIO_NUM}' -d 'To=${PHONE_NUM}' -d 'Body=ROBOT NEEDS HELP.  GO HELP IT.'"
alias robot_alerts="ssh vecna@${COMPUTER_NAME} 'export ROS_MASTER_URI=http://localhost:11311; rostopic echo /remote_assist_alert' | alert-on-message"
alias rosmk='highlight rosmake'
alias mk='highlight make'
alias ls='/bin/ls --color=auto'
alias buildAll='DIR=$(pwd);roscd vlaunch/scripts; ./buildAllCode.sh; cd $DIR'
alias mvbuild='DIR=$(pwd); cd /other/workspace/nrv/core;mvn clean install; cd /other/workspace/nrv/qcbot; mvn clean install;  cd $DIR'
# Nexus Shorcuts
alias cdnexus='cd /other/workspace/nexus/'
alias cdplatform='cd /other/workspace/nexus/platform'
alias cdbeauvais='cd /other/workspace/nexus/clients/beauvais'
alias cdwoburn='cd /other/workspace/nexus/clients/woburn'
alias cdecle='cd /other/workspace/nexus/clients/fedex-ecle'
alias cdmanc='cd /other/workspace/nexus/clients/fedex-manc'
alias cdcrl='cd /other/workspace/nexus/clients/crl'
alias cddana='cd /other/workspace/nexus/clients/danafarber'

alias cdros='cd /other/workspace/vros/'
alias cdnrv='cd /other/workspace/nrv/'
alias cdworld='cd /other/workspace/nrv/qcbot/src/main/resources/worlds'
alias cdnav='cd /other/workspace/nrv/qcbot/src/main/resources/navigation'
alias cdrun='cd /other/workspace/nrv/qcbot/target/classes/'
alias cpnav='cp -r /other/workspace/nrv/qcbot/src/main/resources/navigation /other/workspace/nrv/qcbot/target/classes'
alias cpworld='cp -r /other/workspace/nrv/qcbot/src/main/resources/worlds /other/workspace/nrv/qcbot/target/classes'
alias runless='rosrun vlaunch vlaunch environment:=beauvais run_headless:=false'
alias mdr='md -re; md -te; md -tb;roscd;catkin_make --pkg task_layer; runless'
alias runsim='rosrun vlaunch vlaunch environment:=beauvais'
alias runrqt='rosrun vlaunch rqt_gui'
alias build='md -te; mvn clean install -Pinit-db,populate'
alias deploy='md -tb; mvn tomcat:exploded'
alias endtom='DIR=$(pwd);cd /other/tomcat/bin; ./shutdown.sh; cd $DIR'

alias starttom='DIR=$(pwd);cd /other/tomcat/bin; ./startup.sh; cd $DIR'
alias runvlaunch='rm /other/logs/ros/ros.log; rosrun vlaunch vlaunch'

alias pkg_make='roscd; catkin_make -DCMAKE_BUILD_TYPE=RelWithDebInfo --pkg'
alias cat_make='DIR=$(pwd); roscd; catkin_make -DCMAKE_BUILD_TYPE=RelWithDebInfo; cd $DIR'
alias rm_msgs='DIR=$(pwd);roscd rosjava_messages;cd ..; rm -rf */*/build; rm -rf ~/.gradle; rm -fr $MAVENREPO_PATH/org/ros/rosjava_*; cd $DIR'

alias eclipse='env LIBOVERLAY_SCROLLBAR=1 eclipse'
alias viros='vi /other/logs/ros/ros.log'
alias vinrv='vi /other/logs/qcbot/nrv-qcbot.log'

# this script provides convenient syntax highlighting for maven
alias mvn="/other/dev/colorize-maven.sh"

#show your current git branch on the command prompt
function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "("${ref#refs/heads/}")"
}

FOREGROUND="\[\033[0m\]"
PS1="$GREEN\w$YELLOW \$(parse_git_branch)$GREEN\$ $FOREGROUND"

#TDL/TCM Based variables
#export BASE_ROOT_DIR=~/other/workspace/vros/third-party/cmu_tdl/src
