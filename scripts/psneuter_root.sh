#!/bin/bash

function checkIfRoot {
	if ADB/adb shell id = "uid=0(root) gid=0(root)"; then
		echo "Device is rooted!"
		return 0
	else
		echo "Device is not rooted!"
		return 1
	fi
}
	
	
	
function rootDevice {

	echo "Pushing files to your Android device"

	ADB/adb push exploits/psneuter /data/local/tmp &&
	ADB/adb push root/su /data/local/tmp &&
	ADB/adb push root/Superuser.apk /data/local/tmp &&


	#device part

	ADB/adb shell chmod 755 /data/local/tmp/psneuter &&
	ADB/adb shell /data/local/tmp/psneuter
	
	#checks if device is rooted. otherwise repeats process
	while [checkIfRoot = 1]
	do
		echo "Trying again. Please make sure that you have enabled USB Debugging" &&
		rootDevice
	done
	
	
	ADB/adb shell mount -o remount,rw /dev/block/mtdblock0 /system &&
	ADB/adb shell cat /data/local/tmp/su > /system/bin/su &&
	ADB/adb shell cat /data/local/tmp/Superuser.apk > /system/app/Superuser.apk && 
	ADB/adb shell chmod 06755 /system/bin/su &&
	ADB/adb shell chmod 0755 /system/app/Superuser.apk &&
	
	echo "Voila!"
}


rootDevice;


	
