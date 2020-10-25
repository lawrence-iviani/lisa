#!/bin/bash
# Try to find a clever way to pass arguments to tmux script.
# All try i did with tmux failed, so the only feasible way to avoid scripts multiplication seems to use env variable

default_session="lisa_rhasspy_full_start"
default_platform="DummyBoard"
default_pattern="Alexa"
default_ros_master_ip="192.168.0.104:11311"

# looking for parsing the follow argument
in_arg_session="session_name" 
in_arg_platform="platform"
in_arg_pattern="led_pattern"
in_arg_ros_master_ip="ros_master"

# from https://stackoverflow.com/questions/21336126/linux-bash-script-to-extract-ip-address
lisa_ip=$(ip route get 8.8.8.8 | awk -F"src " 'NR==1{split($2,a," ");print a[1]}')
lisa_interface=$(ip route get 8.8.8.8 | awk -F"dev " 'NR==1{split($2,a," ");print a[1]}')

# parsing input argument
for ARGUMENT in "$@"
do
    if [ "$ARGUMENT" = "-h" ]; then
		echo "Usage: ./lisa_start [-h] [$in_arg_session=TMUX_SESSION] [$in_arg_platform=BOARD] [$in_arg_pattern=LED_PATTERN] [$in_arg_ros_master_ip=ROS_MASTER_IP]"
		echo "		-h: print this help and exit. "
		echo "		TMUX_SESSION: lisa_rhasspy_full_start|lisa_rhasspy_full_start_LAB (Optional)"
		echo "		BOARD: Respeaker4MicArray|MatrixVoice|DummyBoard (Optional)"
		echo "		LED_PATTERN: GoogleHome|Alexa (Optional)"
		echo "		ROS_MASTER_IP: the ip of the ros master to connect"
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
done

# setting required env variables
export LISA_PLATFORM=$default_platform
export LISA_LED_PATTERN=$default_pattern
export ROS_MASTER_URI="http://"$default_ros_master_ip
export ROS_IP=$lisa_ip


# wrapping up
echo "Starting session _>$default_session<- with follow: "
echo "	local ip on interface	: "$ROS_IP " interface is " $lisa_interface
echo "	ros master				: "$ROS_MASTER_URI
echo "	platform				: "$LISA_PLATFORM
echo "	led pattern				: "$LISA_LED_PATTERN
echo 

# finally, start
tmuxinator start $default_session
