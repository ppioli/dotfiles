## Setting Wireguard on OpenWRT
1. Installing the packages
~~~
ssh root@192.168.1.1
# opkg update
# opkg install luci-proto-wireguard luci-app-wireguard wireguard \
    kmod-wireguard wireguard-tools
# reboot
~~~
2. Creating a firewall rule (Network>Firewall>Port Forwards)
```
Name: WireGuard
Protocol: UDP
External Zone: WAN
External Port: 51820
Internal Zone: LAN
Internal IP Address: 192.168.1.1
Internal Port: 51820
```
3. Generating the keys
```
umask 077 && wg genkey > privkey
cat privkey | wg pubkey > pubkey
cat privkey | xclip -selection clipboard
```

4. Create WireGuard interface (Network>Interfaces)
Create new interface wg0, type WireGuard
```
PriveKey = <paste private key>
Listen Port = 51820
IP Addresses = 10.0.10.1/24
Firewall Zone = <select LAN>
```
## Setting up Android client
1. Download the WireGuard app and create a connection from scratch
```
[Interface]
PrivateKey=<click generate>
Address=10.0.10.2/32
DNS=<DNS server of your choice (e.g. 8.8.8.8)>

[Peer]
PublicKey = <public key from the server> (cat pubkey | xclip -selection clipboard)
Allowed IPs = 192.168.1.1/24,10.0.10.0/24
Endpoint = <server_address>:51820
Persistent Keepalive = 25
```

2. Adding a peer to OpenWRT 
Edit the WireGuard interface and add a peer
```
Public Key = <paste the pub key generated on the android client>
Allowed IPs = 10.0.10.2/32
Route Allowed IPs = <checked>
Persistent Keepalive=25
```

## Setting up Linux
1. Install required packages
```
sudo apt install wireguard
sudo pacman -S wireguard-tools
```
2. Create keys 
```
umask 077 && wg genkey > privkey
cat privkey | wg pubkey > pubkey
cat privkey | xclip -selection clipboard
```
3. Create interface conf file at `/etc/wireguard/wg0.conf` 
```
[Interface]
PrivateKey=<paste privkey>
Address=10.0.10.3/32
DNS=<DNS server of your choice (e.g. 8.8.8.8)>

[Peer]
PublicKey=<server's public key> (cat pubkey | xclip -selection clipboard)
Endpoint=<server address>:51820
AllowedIPs=192.168.1.0/24,10.0.10.0/24
Persistent Keepalive=25
```

4. Bring interface up/down
```
wg-quick up wg0
wg-quick down wg0
```
Sources
1. https://www.reddit.com/r/openwrt/comments/bahhua/openwrt_wireguard_vpn_server_tutorial/
2. https://blog.linuxserver.io/2019/11/24/connect-an-ubuntu-client-to-opnsense-wireguard-tunnel-with-a-gui-toggle-in-gnome/