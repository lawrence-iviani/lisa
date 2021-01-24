#!/bin/bash
# Try to find a clever way to pass arguments to tmux script.
# All try i did with tmux failed, so the only feasible way to avoid scripts multiplication seems to use env variable

default_session="lisa_production"
default_platform="DummyBoard"
default_pattern="Alexa"
default_ros_master_ip="192.168.0.104:11311"
default_rh_profile="en"


# looking for parsing the follow argument
in_arg_session="session_name" 
in_arg_platform="platform"
in_arg_pattern="led_pattern"
in_arg_ros_master_ip="ros_master"
in_arg_rh_profile="rhasspy_profile"


# from https://stackoverflow.com/questions/21336126/linux-bash-script-to-extract-ip-address
# and https://unix.stackexchange.com/questions/8518/how-to-get-my-own-ip-address-and-save-it-to-a-variable-in-a-shell-script
# lisa_ip=$(ip route get 8.8.8.8 | awk -F"src " 'NR==1{split($2,a," ");print a[1]}') # wont work if there is not a valid internet connecction
lisa_ip=$(ifconfig | grep -A 1 'eth0' | tail -1 | awk -F"inet " 'NR==1{split($2,a," ");print a[1]}')
lisa_interface=$(ip route get 8.8.8.8 | awk -F"dev " 'NR==1{split($2,a," ");print a[1]}')

# parsing input argument
for ARGUMENT in "$@"
do
    if [ "$ARGUMENT" = "help" ]; then
		echo "Usage: ./lisa_start [help] || [$in_arg_session=TMUX_SESSION] [$in_arg_platform=BOARD] [$in_arg_pattern=LED_PATTERN] [$in_arg_ros_master_ip=ROS_MASTER_IP]  [$in_arg_rh_profile=RHASSPY_PROFILE]  "
		echo "		help: print this help and exit. "
		echo "		TMUX_SESSION: lisa_production|lisa_dev (Optional)"
		echo "		BOARD: Respeaker4MicArray|MatrixVoice|DummyBoard (Optional)"
		echo "		LED_PATTERN: GoogleHome|Alexa (Optional)"
		echo "		ROS_MASTER_IP: the ip of the ros master to connect, in the form ip:port (e.g 192.168.0.104:11311)"
		echo "		RHASSPY_PROFILE: the name of the rhasspy profile to load (deafault is en, at the moment rqt and Motek_2018 are possible candidates)" 
		exit
	fi
	KEY=$(echo $ARGUMENT | cut -f1 -d=)
	VALUE=$(echo $ARGUMENT | cut -f2 -d=) 
	echo key=$KEY - value=$VALUE
	if [ "$KEY" = $in_arg_session ]; then
		default_session=$VALUE
	fi
	if [ "$KEY" = $in_arg_platform ]; then
		default_platform=$VALUE
	fi
	if [ "$KEY" = $in_arg_pattern ]; then
		default_pattern=$VALUE
	fi
	if [ "$KEY" = $in_arg_ros_master_ip ]; then
		default_ros_master_ip=$VALUE
	fi
	if [ "$KEY" = $in_arg_rh_profile ]; then
                default_rh_profile=$VALUE
        fi
done

# setting required env variables
export LISA_PLATFORM=$default_platform
export LISA_LED_PATTERN=$default_pattern
export ROS_MASTER_URI="http://"$default_ros_master_ip
export ROS_IP=$lisa_ip
export RH_SESSION=$default_rh_profile


# wrapping up
echo "Use $ ./start_lisa help for a list of options"
echo "Starting session _>$default_session<- with follow: "
echo "	local ip on interface			: "$ROS_IP " interface is " $lisa_interface
echo "	ros master				: "$ROS_MASTER_URI
echo "	platform				: "$LISA_PLATFORM
echo "	led pattern				: "$LISA_LED_PATTERN
echo "	rhasspy profile				: "$RH_SESSION
echo 
 
# finally, start
tmuxinator start $default_session
