<p align="center"><img src="https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fxiv3r%2FKali-Linux-Termux&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=%F0%9F%91%81%EF%B8%8F%F0%9F%91%81%EF%B8%8F&edge_flat=false">

<img width="1100" height="500" src="https://github.com/xiv3r/Kali-Linux-Termux/blob/main/kali_nethunter/vnc.png">

# <h1 align="center"> Kali Nethunter Termux </h1>
 
<p align="center">Kali Linux NetHunter on Termux is a powerful tool for security professionals and enthusiasts. It allows users to perform a variety of security assessments on their Android devices without rooting them.</p>

<br></br>

<h1 align="center">

| [Termux 0.119.1](https://github.com/xiv3r/Kali-Linux-Termux/releases/download/Apps/Termux_v0.119.1.apk)
|
| [VNC Kex App](https://store.nethunter.com/repo/com.offsec.nethunter.kex_11525001.apk)
|
</h1>

<br>

# Auto Install
> stable on termux v.0.119.1
```sh
apt update && apt install wget bsdtar axel proot -y && wget -qO- https://raw.githubusercontent.com/xiv3r/Kali-Linux-Termux/refs/heads/main/kali_nethunter/kali-full | sh && kali -r
```
> [!Note]
> - script include Auto Run Kali and VNC in every startup
> - Only the Full nethunter image support vnc service, choose 1 and hit enter.
> - User terminal `kali`
> - Root terminal `kali -r`

- After the kali is installed
> - Auto login
```
echo "kali && kali vnc &" >>/etc/bash.bashrc
```
> - ( to configure your vnc password )
```
kali vnc password 
```        
> - ( to enable vnc service )
```
kali vnc &
```

> - [Next Open the VNC and place `kali` as username and your vnc `password`](http://127.0.0.1:5901)

 <details><summary>
  
 <div align="center">
  
 # Prevent Termux VNC service from being Killed
 </div>
  
 <p align="center">" Process completed (signal 9) - press Enter "</p>

 </summary>

- Without PC Using Wireless debugger [VIDEO](https://www.youtube.com/watch?v=vK1Jx9ydi5c)

- Install adb in termux:
```sh
apt install android-tools -y
```
- Install adb and fastboot in [linux and windows](https://developer.android.com/tools/adb#:~:text=To%20use%20adb%20with%20a,connect%20your%20device%20with%20USB.):

- Auto Fixed
```sh
curl https://raw.githubusercontent.com/xiv3r/Kali-Linux-Termux/refs/heads/main/adb.sh | sudo sh
```
- Maual install 
```sh
apt install adb fastboot -y
```
- Note: Connect your mobile to the computer then enable [Developer Option](https://www.digitaltrends.com/mobile/how-to-get-developer-options-on-android/) and enable USB Debugging
  
- Now Execute
```sh
adb devices
```
Note:Popup and Pair your device  
- Execute the commands below, These commands will disable the phantom process killer:
```sh
adb shell /system/bin/device_config set_sync_disabled_for_tests persistent

adb shell /system/bin/device_config put activity_manager max_phantom_processes 2147483647

adb shell settings put global settings_enable_monitor_phantom_procs false
```
- To verify:
```sh
adb shell /system/bin/dumpsys activity settings | grep max_phantom_processes

adb shell /system/bin/device_config get activity_manager max_phantom_processes
```

</details>


