From: Douglas Gilbert <dgilbert@interlog.com>
Subject: 4.19.0-rc1 rtsx_pci_sdmmc.0: error: data->host_cookie = 62,
 host->cookie = 63
Date: Tue, 28 Aug 2018 23:47:10 +0200
Message-ID: <6c696030-51a5-9ab9-47a9-d6fa3000a8a3@interlog.com>
Reply-To: dgilbert@interlog.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------06F0B649E77BC948D6D1482E"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This is a multi-part message in MIME format.
--------------06F0B649E77BC948D6D1482E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

I usually boot my Lenovo X270 with a SD card in its:
   # lspci
02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS522A PCI 
Express Card Reader (rev 01)
...

In lk 4.19.0-rc1 the boot locks up solid, almost immediately and nothing in
the logs. If I remove the SD card my machine boots and works okay until I
insert the SD card. Then:

Aug 28 23:30:38 xtwo70 kernel: mmc0: cannot verify signal voltage switch
Aug 28 23:30:38 xtwo70 kernel: mmc0: new ultra high speed SDR104 SDXC card at 
address aaaa
Aug 28 23:30:38 xtwo70 kernel: mmcblk0: mmc0:aaaa ACLCE 59.5 GiB
Aug 28 23:30:38 xtwo70 kernel: mmcblk0: p1 p2
Aug 28 23:30:38 xtwo70 kernel: rtsx_pci_sdmmc rtsx_pci_sdmmc.0: error: 
data->host_cookie = 62, host->cookie = 63
Aug 28 23:30:38 xtwo70 kernel: BUG: unable to handle kernel NULL pointer 
dereference at 0000000000000018
Aug 28 23:30:38 xtwo70 kernel: PGD 0 P4D 0
Aug 28 23:30:38 xtwo70 kernel: Oops: 0000 [#1] SMP
Aug 28 23:30:38 xtwo70 kernel: CPU: 3 PID: 1571 Comm: kworker/3:2 Not tainted 
4.19.0-rc1 #78
Aug 28 23:30:38 xtwo70 kernel: Hardware name: LENOVO 20HNCTO1WW/20HNCTO1WW, BIOS 
R0IET53W (1.31 ) 05/22/2018
Aug 28 23:30:38 xtwo70 kernel: Workqueue: events sd_request [rtsx_pci_sdmmc]
Aug 28 23:30:38 xtwo70 kernel: RIP: 0010:rtsx_pci_dma_transfer+0x6e/0x260 [rtsx_pci]
Aug 28 23:30:38 xtwo70 kernel: Code: 49 89 fe 45 89 c5 c7 87 90 00 00 00 00 00 
00 00 8d 6a ff 81 c9 00 00 00 88 31 d2 41 89 cc 45 31 ff eb 07 41 8b 96 90 00 00 
00 <8b> 78 18 48 63 ca 31 f6 44 39 fd 48 8b 50 10 40 0f 94 c6 41 83 c7
Aug 28 23:30:38 xtwo70 kernel: RSP: 0018:ffffc90000217d78 EFLAGS: 00010202
Aug 28 23:30:38 xtwo70 kernel: RAX: 0000000000000000 RBX: 0000000000000003 RCX: 
0000000000000000
Aug 28 23:30:38 xtwo70 kernel: RDX: 0000000000000001 RSI: 0000000000000021 RDI: 
ffff8801b6328000
Aug 28 23:30:38 xtwo70 kernel: RBP: 0000000000000002 R08: ffff880036000400 R09: 
0000000000000000
Aug 28 23:30:38 xtwo70 kernel: R10: 0000000000000000 R11: 0000000000000000 R12: 
00000000a8000000
Aug 28 23:30:38 xtwo70 kernel: R13: 0000000000002710 R14: ffff88021fd35400 R15: 
0000000000000001
Aug 28 23:30:38 xtwo70 kernel: FS:  0000000000000000(0000) 
GS:ffff880227380000(0000) knlGS:0000000000000000
Aug 28 23:30:38 xtwo70 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Aug 28 23:30:38 xtwo70 kernel: CR2: 0000000000000018 CR3: 000000000400f006 CR4: 
00000000003606e0
Aug 28 23:30:38 xtwo70 kernel: Call Trace:
Aug 28 23:30:38 xtwo70 kernel: ? mark_held_locks+0x50/0x80
Aug 28 23:30:38 xtwo70 kernel: ? _raw_spin_unlock_irqrestore+0x2d/0x40
Aug 28 23:30:38 xtwo70 kernel: sd_request+0x385/0x81a [rtsx_pci_sdmmc]
Aug 28 23:30:38 xtwo70 kernel: process_one_work+0x287/0x5e0
Aug 28 23:30:38 xtwo70 kernel: worker_thread+0x28/0x3d0
Aug 28 23:30:38 xtwo70 kernel: ? process_one_work+0x5e0/0x5e0
Aug 28 23:30:38 xtwo70 kernel: kthread+0x10e/0x130
Aug 28 23:30:38 xtwo70 kernel: ? kthread_park+0x80/0x80
Aug 28 23:30:38 xtwo70 kernel: ret_from_fork+0x3a/0x50
Aug 28 23:30:38 xtwo70 kernel: Modules linked in: mmc_block fuse msr bnep ccm 
btusb btrtl btbcm btintel bluetooth squashfs ecdh_generic binfmt_misc intel_rapl 
nls_iso8859_1 nls_cp437 x86_pkg_temp_thermal vfat intel_powerclamp fat coretemp 
kvm_intel arc4 snd_hda_codec_hdmi kvm snd_hda_codec_realtek 
snd_hda_codec_generic irqbypass crct10dif_pclmul crc32_pclmul 
ghash_clmulni_intel pcbc iwlmvm aesni_intel aes_x86_64 crypto_simd cryptd 
glue_helper mac80211 intel_cstate intel_uncore intel_rapl_perf snd_hda_intel 
joydev snd_hda_codec mousedev snd_hwdep iwlwifi snd_hda_core input_leds 
efi_pstore snd_pcm serio_raw efivars cfg80211 rtsx_pci_ms memstick mei_me idma64 
virt_dma mei intel_lpss_pci intel_lpss intel_pch_thermal thinkpad_acpi nvram 
snd_seq_dummy tps6598x snd_seq_oss typec snd_seq_midi snd_rawmidi snd_seq_midi_event
Aug 28 23:30:38 xtwo70 kernel: snd_seq snd_seq_device snd_timer snd soundcore 
rfkill tpm_crb tpm_tis tpm_tis_core tpm evdev mac_hid pcc_cpufreq ip6t_REJECT 
nf_reject_ipv6 nf_log_ipv6 xt_hl ip6t_rt ipt_REJECT nf_reject_ipv4 nf_log_ipv4 
nf_log_common xt_LOG xt_limit xt_tcpudp xt_addrtype xt_conntrack ip6table_filter 
ip6_tables nf_conntrack_netbios_ns nf_conntrack_broadcast nf_nat_ftp nf_nat 
nf_conntrack_ftp nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c 
iptable_filter parport_pc ppdev lp parport efivarfs ip_tables x_tables autofs4 
hid_logitech_hidpp hid_logitech_dj hid_generic usbhid hid rtsx_pci_sdmmc 
mmc_core i915 nvme e1000e i2c_algo_bit nvme_core drm_kms_helper syscopyarea 
sysfillrect sysimgblt fb_sys_fops xhci_pci drm xhci_hcd video 
drm_panel_orientation_quirks usbcore intel_gtt agpgart usb_common rtsx_pci
Aug 28 23:30:38 xtwo70 kernel: CR2: 0000000000000018
Aug 28 23:30:38 xtwo70 kernel: ---[ end trace bb8ce18072d22d51 ]---
Aug 28 23:30:38 xtwo70 dbus-daemon[2110]: [system] Activating via systemd: 
service name='org.freedesktop.hostname1' 
unit='dbus-org.freedesktop.hostname1.service' requested by ':1.77' (uid=1000 
pid=3518 comm="/usr/bin/gnome-shell ")
Aug 28 23:30:38 xtwo70 systemd[1]: Attaching egress BPF program to cgroup 
/sys/fs/cgroup/unified/system.slice/systemd-hostnamed.service failed: Invalid 
argument
Aug 28 23:30:38 xtwo70 systemd[1]: Starting Hostname Service...
Aug 28 23:30:39 xtwo70 kernel: RIP: 0010:rtsx_pci_dma_transfer+0x6e/0x260 [rtsx_pci]
Aug 28 23:30:39 xtwo70 kernel: Code: 49 89 fe 45 89 c5 c7 87 90 00 00 00 00 00 
00 00 8d 6a ff 81 c9 00 00 00 88 31 d2 41 89 cc 45 31 ff eb 07 41 8b 96 90 00 00 
00 <8b> 78 18 48 63 ca 31 f6 44 39 fd 48 8b 50 10 40 0f 94 c6 41 83 c7
Aug 28 23:30:39 xtwo70 kernel: RSP: 0018:ffffc90000217d78 EFLAGS: 00010202
Aug 28 23:30:39 xtwo70 kernel: RAX: 0000000000000000 RBX: 0000000000000003 RCX: 
0000000000000000
Aug 28 23:30:39 xtwo70 kernel: RDX: 0000000000000001 RSI: 0000000000000021 RDI: 
ffff8801b6328000
Aug 28 23:30:39 xtwo70 kernel: RBP: 0000000000000002 R08: ffff880036000400 R09: 
0000000000000000
Aug 28 23:30:39 xtwo70 kernel: R10: 0000000000000000 R11: 0000000000000000 R12: 
00000000a8000000
Aug 28 23:30:39 xtwo70 kernel: R13: 0000000000002710 R14: ffff88021fd35400 R15: 
0000000000000001
Aug 28 23:30:39 xtwo70 kernel: FS:  0000000000000000(0000) 
GS:ffff880227380000(0000) knlGS:0000000000000000
Aug 28 23:30:39 xtwo70 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Aug 28 23:30:39 xtwo70 kernel: CR2: 000056531391e498 CR3: 000000000400f006 CR4: 
00000000003606e0


Doug Gilbert

--------------06F0B649E77BC948D6D1482E
Content-Type: text/plain; charset=UTF-8;
 name="oops.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="oops.txt"

QXVnIDI4IDIzOjMwOjM4IHh0d283MCBrZXJuZWw6IG1tYzA6IGNhbm5vdCB2ZXJpZnkgc2ln
bmFsIHZvbHRhZ2Ugc3dpdGNoCkF1ZyAyOCAyMzozMDozOCB4dHdvNzAga2VybmVsOiBtbWMw
OiBuZXcgdWx0cmEgaGlnaCBzcGVlZCBTRFIxMDQgU0RYQyBjYXJkIGF0IGFkZHJlc3MgYWFh
YQpBdWcgMjggMjM6MzA6MzggeHR3bzcwIGtlcm5lbDogbW1jYmxrMDogbW1jMDphYWFhIEFD
TENFIDU5LjUgR2lCIApBdWcgMjggMjM6MzA6MzggeHR3bzcwIGtlcm5lbDogbW1jYmxrMDog
cDEgcDIKQXVnIDI4IDIzOjMwOjM4IHh0d283MCBrZXJuZWw6IHJ0c3hfcGNpX3NkbW1jIHJ0
c3hfcGNpX3NkbW1jLjA6IGVycm9yOiBkYXRhLT5ob3N0X2Nvb2tpZSA9IDYyLCBob3N0LT5j
b29raWUgPSA2MwpBdWcgMjggMjM6MzA6MzggeHR3bzcwIGtlcm5lbDogQlVHOiB1bmFibGUg
dG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQgMDAwMDAwMDAw
MDAwMDAxOApBdWcgMjggMjM6MzA6MzggeHR3bzcwIGtlcm5lbDogUEdEIDAgUDREIDAgCkF1
ZyAyOCAyMzozMDozOCB4dHdvNzAga2VybmVsOiBPb3BzOiAwMDAwIFsjMV0gU01QCkF1ZyAy
OCAyMzozMDozOCB4dHdvNzAga2VybmVsOiBDUFU6IDMgUElEOiAxNTcxIENvbW06IGt3b3Jr
ZXIvMzoyIE5vdCB0YWludGVkIDQuMTkuMC1yYzEgIzc4CkF1ZyAyOCAyMzozMDozOCB4dHdv
NzAga2VybmVsOiBIYXJkd2FyZSBuYW1lOiBMRU5PVk8gMjBITkNUTzFXVy8yMEhOQ1RPMVdX
LCBCSU9TIFIwSUVUNTNXICgxLjMxICkgMDUvMjIvMjAxOApBdWcgMjggMjM6MzA6MzggeHR3
bzcwIGtlcm5lbDogV29ya3F1ZXVlOiBldmVudHMgc2RfcmVxdWVzdCBbcnRzeF9wY2lfc2Rt
bWNdCkF1ZyAyOCAyMzozMDozOCB4dHdvNzAga2VybmVsOiBSSVA6IDAwMTA6cnRzeF9wY2lf
ZG1hX3RyYW5zZmVyKzB4NmUvMHgyNjAgW3J0c3hfcGNpXQpBdWcgMjggMjM6MzA6MzggeHR3
bzcwIGtlcm5lbDogQ29kZTogNDkgODkgZmUgNDUgODkgYzUgYzcgODcgOTAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgOGQgNmEgZmYgODEgYzkgMDAgMDAgMDAgODggMzEgZDIgNDEgODkgY2Mg
NDUgMzEgZmYgZWIgMDcgNDEgOGIgOTYgOTAgMDAgMDAgMDAgPDhiPiA3OCAxOCA0OCA2MyBj
YSAzMSBmNiA0NCAzOSBmZCA0OCA4YiA1MCAxMCA0MCAwZiA5NCBjNiA0MSA4MyBjNwpBdWcg
MjggMjM6MzA6MzggeHR3bzcwIGtlcm5lbDogUlNQOiAwMDE4OmZmZmZjOTAwMDAyMTdkNzgg
RUZMQUdTOiAwMDAxMDIwMgpBdWcgMjggMjM6MzA6MzggeHR3bzcwIGtlcm5lbDogUkFYOiAw
MDAwMDAwMDAwMDAwMDAwIFJCWDogMDAwMDAwMDAwMDAwMDAwMyBSQ1g6IDAwMDAwMDAwMDAw
MDAwMDAKQXVnIDI4IDIzOjMwOjM4IHh0d283MCBrZXJuZWw6IFJEWDogMDAwMDAwMDAwMDAw
MDAwMSBSU0k6IDAwMDAwMDAwMDAwMDAwMjEgUkRJOiBmZmZmODgwMWI2MzI4MDAwCkF1ZyAy
OCAyMzozMDozOCB4dHdvNzAga2VybmVsOiBSQlA6IDAwMDAwMDAwMDAwMDAwMDIgUjA4OiBm
ZmZmODgwMDM2MDAwNDAwIFIwOTogMDAwMDAwMDAwMDAwMDAwMApBdWcgMjggMjM6MzA6Mzgg
eHR3bzcwIGtlcm5lbDogUjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogMDAwMDAwMDAwMDAw
MDAwMCBSMTI6IDAwMDAwMDAwYTgwMDAwMDAKQXVnIDI4IDIzOjMwOjM4IHh0d283MCBrZXJu
ZWw6IFIxMzogMDAwMDAwMDAwMDAwMjcxMCBSMTQ6IGZmZmY4ODAyMWZkMzU0MDAgUjE1OiAw
MDAwMDAwMDAwMDAwMDAxCkF1ZyAyOCAyMzozMDozOCB4dHdvNzAga2VybmVsOiBGUzogIDAw
MDAwMDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjg4MDIyNzM4MDAwMCgwMDAwKSBrbmxHUzow
MDAwMDAwMDAwMDAwMDAwCkF1ZyAyOCAyMzozMDozOCB4dHdvNzAga2VybmVsOiBDUzogIDAw
MTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCkF1ZyAyOCAyMzoz
MDozOCB4dHdvNzAga2VybmVsOiBDUjI6IDAwMDAwMDAwMDAwMDAwMTggQ1IzOiAwMDAwMDAw
MDA0MDBmMDA2IENSNDogMDAwMDAwMDAwMDM2MDZlMApBdWcgMjggMjM6MzA6MzggeHR3bzcw
IGtlcm5lbDogQ2FsbCBUcmFjZToKQXVnIDI4IDIzOjMwOjM4IHh0d283MCBrZXJuZWw6ID8g
bWFya19oZWxkX2xvY2tzKzB4NTAvMHg4MApBdWcgMjggMjM6MzA6MzggeHR3bzcwIGtlcm5l
bDogPyBfcmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUrMHgyZC8weDQwCkF1ZyAyOCAyMzoz
MDozOCB4dHdvNzAga2VybmVsOiBzZF9yZXF1ZXN0KzB4Mzg1LzB4ODFhIFtydHN4X3BjaV9z
ZG1tY10KQXVnIDI4IDIzOjMwOjM4IHh0d283MCBrZXJuZWw6IHByb2Nlc3Nfb25lX3dvcmsr
MHgyODcvMHg1ZTAKQXVnIDI4IDIzOjMwOjM4IHh0d283MCBrZXJuZWw6IHdvcmtlcl90aHJl
YWQrMHgyOC8weDNkMApBdWcgMjggMjM6MzA6MzggeHR3bzcwIGtlcm5lbDogPyBwcm9jZXNz
X29uZV93b3JrKzB4NWUwLzB4NWUwCkF1ZyAyOCAyMzozMDozOCB4dHdvNzAga2VybmVsOiBr
dGhyZWFkKzB4MTBlLzB4MTMwCkF1ZyAyOCAyMzozMDozOCB4dHdvNzAga2VybmVsOiA/IGt0
aHJlYWRfcGFyaysweDgwLzB4ODAKQXVnIDI4IDIzOjMwOjM4IHh0d283MCBrZXJuZWw6IHJl
dF9mcm9tX2ZvcmsrMHgzYS8weDUwCkF1ZyAyOCAyMzozMDozOCB4dHdvNzAga2VybmVsOiBN
b2R1bGVzIGxpbmtlZCBpbjogbW1jX2Jsb2NrIGZ1c2UgbXNyIGJuZXAgY2NtIGJ0dXNiIGJ0
cnRsIGJ0YmNtIGJ0aW50ZWwgYmx1ZXRvb3RoIHNxdWFzaGZzIGVjZGhfZ2VuZXJpYyBiaW5m
bXRfbWlzYyBpbnRlbF9yYXBsIG5sc19pc284ODU5XzEgbmxzX2NwNDM3IHg4Nl9wa2dfdGVt
cF90aGVybWFsIHZmYXQgaW50ZWxfcG93ZXJjbGFtcCBmYXQgY29yZXRlbXAga3ZtX2ludGVs
IGFyYzQgc25kX2hkYV9jb2RlY19oZG1pIGt2bSBzbmRfaGRhX2NvZGVjX3JlYWx0ZWsgc25k
X2hkYV9jb2RlY19nZW5lcmljIGlycWJ5cGFzcyBjcmN0MTBkaWZfcGNsbXVsIGNyYzMyX3Bj
bG11bCBnaGFzaF9jbG11bG5pX2ludGVsIHBjYmMgaXdsbXZtIGFlc25pX2ludGVsIGFlc194
ODZfNjQgY3J5cHRvX3NpbWQgY3J5cHRkIGdsdWVfaGVscGVyIG1hYzgwMjExIGludGVsX2Nz
dGF0ZSBpbnRlbF91bmNvcmUgaW50ZWxfcmFwbF9wZXJmIHNuZF9oZGFfaW50ZWwgam95ZGV2
IHNuZF9oZGFfY29kZWMgbW91c2VkZXYgc25kX2h3ZGVwIGl3bHdpZmkgc25kX2hkYV9jb3Jl
IGlucHV0X2xlZHMgZWZpX3BzdG9yZSBzbmRfcGNtIHNlcmlvX3JhdyBlZml2YXJzIGNmZzgw
MjExIHJ0c3hfcGNpX21zIG1lbXN0aWNrIG1laV9tZSBpZG1hNjQgdmlydF9kbWEgbWVpIGlu
dGVsX2xwc3NfcGNpIGludGVsX2xwc3MgaW50ZWxfcGNoX3RoZXJtYWwgdGhpbmtwYWRfYWNw
aSBudnJhbSBzbmRfc2VxX2R1bW15IHRwczY1OTh4IHNuZF9zZXFfb3NzIHR5cGVjIHNuZF9z
ZXFfbWlkaSBzbmRfcmF3bWlkaSBzbmRfc2VxX21pZGlfZXZlbnQKQXVnIDI4IDIzOjMwOjM4
IHh0d283MCBrZXJuZWw6IHNuZF9zZXEgc25kX3NlcV9kZXZpY2Ugc25kX3RpbWVyIHNuZCBz
b3VuZGNvcmUgcmZraWxsIHRwbV9jcmIgdHBtX3RpcyB0cG1fdGlzX2NvcmUgdHBtIGV2ZGV2
IG1hY19oaWQgcGNjX2NwdWZyZXEgaXA2dF9SRUpFQ1QgbmZfcmVqZWN0X2lwdjYgbmZfbG9n
X2lwdjYgeHRfaGwgaXA2dF9ydCBpcHRfUkVKRUNUIG5mX3JlamVjdF9pcHY0IG5mX2xvZ19p
cHY0IG5mX2xvZ19jb21tb24geHRfTE9HIHh0X2xpbWl0IHh0X3RjcHVkcCB4dF9hZGRydHlw
ZSB4dF9jb25udHJhY2sgaXA2dGFibGVfZmlsdGVyIGlwNl90YWJsZXMgbmZfY29ubnRyYWNr
X25ldGJpb3NfbnMgbmZfY29ubnRyYWNrX2Jyb2FkY2FzdCBuZl9uYXRfZnRwIG5mX25hdCBu
Zl9jb25udHJhY2tfZnRwIG5mX2Nvbm50cmFjayBuZl9kZWZyYWdfaXB2NiBuZl9kZWZyYWdf
aXB2NCBsaWJjcmMzMmMgaXB0YWJsZV9maWx0ZXIgcGFycG9ydF9wYyBwcGRldiBscCBwYXJw
b3J0IGVmaXZhcmZzIGlwX3RhYmxlcyB4X3RhYmxlcyBhdXRvZnM0IGhpZF9sb2dpdGVjaF9o
aWRwcCBoaWRfbG9naXRlY2hfZGogaGlkX2dlbmVyaWMgdXNiaGlkIGhpZCBydHN4X3BjaV9z
ZG1tYyBtbWNfY29yZSBpOTE1IG52bWUgZTEwMDBlIGkyY19hbGdvX2JpdCBudm1lX2NvcmUg
ZHJtX2ttc19oZWxwZXIgc3lzY29weWFyZWEgc3lzZmlsbHJlY3Qgc3lzaW1nYmx0IGZiX3N5
c19mb3BzIHhoY2lfcGNpIGRybSB4aGNpX2hjZCB2aWRlbyBkcm1fcGFuZWxfb3JpZW50YXRp
b25fcXVpcmtzIHVzYmNvcmUgaW50ZWxfZ3R0IGFncGdhcnQgdXNiX2NvbW1vbiBydHN4X3Bj
aQpBdWcgMjggMjM6MzA6MzggeHR3bzcwIGtlcm5lbDogQ1IyOiAwMDAwMDAwMDAwMDAwMDE4
CkF1ZyAyOCAyMzozMDozOCB4dHdvNzAga2VybmVsOiAtLS1bIGVuZCB0cmFjZSBiYjhjZTE4
MDcyZDIyZDUxIF0tLS0KQXVnIDI4IDIzOjMwOjM4IHh0d283MCBkYnVzLWRhZW1vblsyMTEw
XTogW3N5c3RlbV0gQWN0aXZhdGluZyB2aWEgc3lzdGVtZDogc2VydmljZSBuYW1lPSdvcmcu
ZnJlZWRlc2t0b3AuaG9zdG5hbWUxJyB1bml0PSdkYnVzLW9yZy5mcmVlZGVza3RvcC5ob3N0
bmFtZTEuc2VydmljZScgcmVxdWVzdGVkIGJ5ICc6MS43NycgKHVpZD0xMDAwIHBpZD0zNTE4
IGNvbW09Ii91c3IvYmluL2dub21lLXNoZWxsICIpCkF1ZyAyOCAyMzozMDozOCB4dHdvNzAg
c3lzdGVtZFsxXTogQXR0YWNoaW5nIGVncmVzcyBCUEYgcHJvZ3JhbSB0byBjZ3JvdXAgL3N5
cy9mcy9jZ3JvdXAvdW5pZmllZC9zeXN0ZW0uc2xpY2Uvc3lzdGVtZC1ob3N0bmFtZWQuc2Vy
dmljZSBmYWlsZWQ6IEludmFsaWQgYXJndW1lbnQKQXVnIDI4IDIzOjMwOjM4IHh0d283MCBz
eXN0ZW1kWzFdOiBTdGFydGluZyBIb3N0bmFtZSBTZXJ2aWNlLi4uCkF1ZyAyOCAyMzozMDoz
OSB4dHdvNzAga2VybmVsOiBSSVA6IDAwMTA6cnRzeF9wY2lfZG1hX3RyYW5zZmVyKzB4NmUv
MHgyNjAgW3J0c3hfcGNpXQpBdWcgMjggMjM6MzA6MzkgeHR3bzcwIGtlcm5lbDogQ29kZTog
NDkgODkgZmUgNDUgODkgYzUgYzcgODcgOTAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgOGQgNmEg
ZmYgODEgYzkgMDAgMDAgMDAgODggMzEgZDIgNDEgODkgY2MgNDUgMzEgZmYgZWIgMDcgNDEg
OGIgOTYgOTAgMDAgMDAgMDAgPDhiPiA3OCAxOCA0OCA2MyBjYSAzMSBmNiA0NCAzOSBmZCA0
OCA4YiA1MCAxMCA0MCAwZiA5NCBjNiA0MSA4MyBjNwpBdWcgMjggMjM6MzA6MzkgeHR3bzcw
IGtlcm5lbDogUlNQOiAwMDE4OmZmZmZjOTAwMDAyMTdkNzggRUZMQUdTOiAwMDAxMDIwMgpB
dWcgMjggMjM6MzA6MzkgeHR3bzcwIGtlcm5lbDogUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJC
WDogMDAwMDAwMDAwMDAwMDAwMyBSQ1g6IDAwMDAwMDAwMDAwMDAwMDAKQXVnIDI4IDIzOjMw
OjM5IHh0d283MCBrZXJuZWw6IFJEWDogMDAwMDAwMDAwMDAwMDAwMSBSU0k6IDAwMDAwMDAw
MDAwMDAwMjEgUkRJOiBmZmZmODgwMWI2MzI4MDAwCkF1ZyAyOCAyMzozMDozOSB4dHdvNzAg
a2VybmVsOiBSQlA6IDAwMDAwMDAwMDAwMDAwMDIgUjA4OiBmZmZmODgwMDM2MDAwNDAwIFIw
OTogMDAwMDAwMDAwMDAwMDAwMApBdWcgMjggMjM6MzA6MzkgeHR3bzcwIGtlcm5lbDogUjEw
OiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogMDAwMDAwMDAwMDAwMDAwMCBSMTI6IDAwMDAwMDAw
YTgwMDAwMDAKQXVnIDI4IDIzOjMwOjM5IHh0d283MCBrZXJuZWw6IFIxMzogMDAwMDAwMDAw
MDAwMjcxMCBSMTQ6IGZmZmY4ODAyMWZkMzU0MDAgUjE1OiAwMDAwMDAwMDAwMDAwMDAxCkF1
ZyAyOCAyMzozMDozOSB4dHdvNzAga2VybmVsOiBGUzogIDAwMDAwMDAwMDAwMDAwMDAoMDAw
MCkgR1M6ZmZmZjg4MDIyNzM4MDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwCkF1
ZyAyOCAyMzozMDozOSB4dHdvNzAga2VybmVsOiBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAw
MDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCkF1ZyAyOCAyMzozMDozOSB4dHdvNzAga2VybmVs
OiBDUjI6IDAwMDA1NjUzMTM5MWU0OTggQ1IzOiAwMDAwMDAwMDA0MDBmMDA2IENSNDogMDAw
MDAwMDAwMDM2MDZlMAo=
--------------06F0B649E77BC948D6D1482E--
