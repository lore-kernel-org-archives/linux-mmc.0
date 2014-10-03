From: Stefan Gofferje <lists@home.gofferje.net>
Subject: PROBLEM: Broadcom Corporation BCM57765/57785 SDXC/MMC Card Reader - does not read SDHC
Date: Sat, 04 Oct 2014 00:39:20 +0300
Message-ID: <2519979.ohpf0X2tDh@andromeda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from m33.server110.neobitti.org ([109.163.208.33]:57878 "EHLO
	m33.server110.neobitti.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755272AbaJCWTX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Oct 2014 18:19:23 -0400
Received: from cable-vlk-50de77-254.dhcp.inet.fi ([80.222.119.254]:58893 helo=home.gofferje.net)
	by server110.neobitti.org with esmtpsa (UNKNOWN:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.82)
	(envelope-from <lists@home.gofferje.net>)
	id 1XaAZV-00032R-IT
	for linux-mmc@vger.kernel.org; Sat, 04 Oct 2014 00:39:29 +0300
Received: from localhost (localhost [127.0.0.1])
	by home.gofferje.net (Postfix) with ESMTP id 426D77A541
	for <linux-mmc@vger.kernel.org>; Sat,  4 Oct 2014 00:39:28 +0300 (EEST)
Received: from home.gofferje.net ([127.0.0.1])
	by localhost (k-tanco.net.loc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4uC-P7Vn_i_3 for <linux-mmc@vger.kernel.org>;
	Sat,  4 Oct 2014 00:39:21 +0300 (EEST)
Received: from andromeda.localnet (andromeda.gofferje.net [RFC-1918 IP])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by home.gofferje.net (Postfix) with ESMTPSA id 255787A4AD
	for <linux-mmc@vger.kernel.org>; Sat,  4 Oct 2014 00:39:21 +0300 (EEST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

[1]
Broadcom Corporation BCM57765/57785 SDXC/MMC Card Reader - does not read SDHC

[2]
This is a log output from inserting 2 different SDHC cards. Reading MMC and 
normal SD cards works fine.

Oct 3 22:01:55 Andromeda kernel: [ 496.692464] mmc0: new ultra high speed 
SDR104 SDHC card at address 0007
Oct 3 22:01:55 Andromeda kernel: [ 496.720253] mmcblk0: mmc0:0007 SD8GB 7.42 
GiB
Oct 3 22:01:55 Andromeda kernel: [ 496.730780] mmc0: Controller never released 
inhibit bit(s).
Oct 3 22:02:05 Andromeda kernel: [ 506.734853] mmc0: Timeout waiting for 
hardware interrupt.
Oct 3 22:02:05 Andromeda kernel: [ 506.734921] mmcblk0: error -110 sending 
status command, retrying
Oct 3 22:02:05 Andromeda kernel: [ 506.736505] mmcblk0: unknown error -5 
sending read/write command, card status 0x900
Oct 3 22:02:05 Andromeda kernel: [ 506.736512] end_request: I/O error, dev 
mmcblk0, sector 0
Oct 3 22:02:05 Andromeda kernel: [ 506.736514] quiet_error: 12 callbacks 
suppressed
Oct 3 22:02:05 Andromeda kernel: [ 506.736516] Buffer I/O error on device 
mmcblk0, logical block 0
Oct 3 22:02:05 Andromeda kernel: [ 506.737157] ldm_validate_partition_table(): 
Disk read failed.
Oct 3 22:02:05 Andromeda kernel: [ 506.737172] Dev mmcblk0: unable to read RDB 
block 0
Oct 3 22:02:05 Andromeda kernel: [ 506.737644] mmcblk0: unable to read 
partition table
Oct 3 22:02:31 Andromeda kernel: [ 532.716634] mmc0: card 0007 removed
Oct 3 22:02:38 Andromeda kernel: [ 539.648546] sdhci: Timeout waiting for 
Buffer Read Ready interrupt during tuning procedure, falling back to fixed 
sampling clock

Oct 3 22:02:38 Andromeda kernel: [ 539.648557] mmc0: new ultra high speed 
SDR104 SDHC card at address e624
Oct 3 22:02:38 Andromeda kernel: [ 539.648909] mmcblk0: mmc0:e624 SE32G 29.7 
GiB
Oct 3 22:02:38 Andromeda kernel: [ 539.659087] mmc0: Controller never released 
inhibit bit(s).
Oct 3 22:02:48 Andromeda kernel: [ 549.654964] mmc0: Timeout waiting for 
hardware interrupt.
Oct 3 22:02:48 Andromeda kernel: [ 549.655051] mmcblk0: error -110 sending 
status command, retrying
Oct 3 22:02:48 Andromeda kernel: [ 549.656284] mmcblk0: unknown error -5 
sending read/write command, card status 0x900
Oct 3 22:02:48 Andromeda kernel: [ 549.656288] end_request: I/O error, dev 
mmcblk0, sector 0
Oct 3 22:02:48 Andromeda kernel: [ 549.656290] Buffer I/O error on device 
mmcblk0, logical block 0
Oct 3 22:02:48 Andromeda kernel: [ 549.665078] ldm_validate_partition_table(): 
Disk read failed.
Oct 3 22:02:48 Andromeda kernel: [ 549.665084] Dev mmcblk0: unable to read RDB 
block 0
Oct 3 22:02:48 Andromeda kernel: [ 549.665399] mmcblk0: unable to read 
partition table
Oct 3 22:02:59 Andromeda kernel: [ 560.661212] nfs: server nostromo OK
Oct 3 22:02:59 Andromeda kernel: [ 561.128818] mmc0: card e624 removed

[3]

[4]
Linux version 3.17.0-031700rc7-generic (apw@gomeisa) (gcc version 4.6.3 
(Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201409281835 SMP Sun Sep 28 22:36:30 UTC 
2014

[5]
No oops message

[6]
n/a

[7]
Description:    Ubuntu 14.04.1 LTS
Release:        14.04

[7.1]
Linux andromeda 3.17.0-031700rc7-generic #201409281835 SMP Sun Sep 28 22:36:30 
UTC 2014 x86_64 x86_64 x86_64 GNU/Linux
 
Gnu C                  4.8
Gnu make               3.81
binutils               2.24
util-linux             2.20.1
mount                  support
module-init-tools      15
e2fsprogs              1.42.9
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.19
Dynamic linker (ldd)   2.19
Procps                 3.3.9
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.21
wireless-tools         30
Modules Loaded         btrfs xor raid6_pq ufs qnx4 hfsplus hfs minix ntfs 
msdos jfs xfs libcrc32c ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat 
nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT 
xt_CHECKSUM iptable_mangle xt_tcpudp bridge stp llc ip6table_filter ip6_tables 
iptable_filter ip_tables rpcsec_gss_krb5 nfsv4 ebtable_nat ebtables x_tables 
ctr ccm nfsd rfcomm bnep auth_rpcgss nfs_acl nfs lockd sunrpc fscache 
nls_iso8859_1 dm_crypt uvcvideo videobuf2_vmalloc videobuf2_memops 
videobuf2_core v4l2_common videodev media intel_rapl x86_pkg_temp_thermal 
intel_powerclamp coretemp arc4 kvm_intel snd_soc_rt5640 ath9k snd_soc_rl6231 
ath9k_common kvm snd_soc_core snd_hda_codec_realtek snd_hda_codec_hdmi 
snd_hda_codec_generic ath9k_hw snd_hda_intel crct10dif_pclmul ath3k btusb 
crc32_pclmul snd_hda_controller snd_hda_codec snd_compress snd_pcm_dmaengine 
snd_hwdep snd_pcm ath snd_seq_midi ghash_clmulni_intel aesni_intel 
snd_seq_midi_event snd_rawmidi snd_seq bluetooth mac80211 acer_wmi 
snd_seq_device sparse_keymap snd_timer aes_x86_64 snd lrw gf128mul glue_helper 
dw_dmac dw_dmac_core lpc_ich ablk_helper snd_soc_sst_acpi cryptd parport_pc 
cfg80211 rtc_efi joydev ppdev i2c_hid lp mei_me mei parport serio_raw 
soc_button_array i2c_designware_platform soundcore i2c_designware_core 
spi_pxa2xx_platform 8250_dw mac_hid hid_generic usbhid hid i915 i2c_algo_bit 
psmouse drm_kms_helper ahci drm libahci tg3 ptp sdhci_pci pps_core wmi video 
sdhci_acpi sdhci

[7.2]
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 69
model name      : Intel(R) Core(TM) i5-4200U CPU @ 1.60GHz
stepping        : 1
microcode       : 0x15
cpu MHz         : 2300.000
cache size      : 3072 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 2
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb 
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est 
tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe popcnt 
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida arat epb pln pts 
dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep 
bmi2 erms invpcid xsaveopt
bugs            :
bogomips        : 4589.18
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 69
model name      : Intel(R) Core(TM) i5-4200U CPU @ 1.60GHz
stepping        : 1
microcode       : 0x15
cpu MHz         : 2300.898
cache size      : 3072 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 2
apicid          : 1
initial apicid  : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb 
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est 
tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe popcnt 
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida arat epb pln pts 
dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep 
bmi2 erms invpcid xsaveopt
bugs            :
bogomips        : 4589.18
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 6
model           : 69
model name      : Intel(R) Core(TM) i5-4200U CPU @ 1.60GHz
stepping        : 1
microcode       : 0x15
cpu MHz         : 2300.000
cache size      : 3072 KB
physical id     : 0
siblings        : 4
core id         : 1
cpu cores       : 2
apicid          : 2
initial apicid  : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb 
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est 
tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe popcnt 
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida arat epb pln pts 
dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep 
bmi2 erms invpcid xsaveopt
bugs            :
bogomips        : 4589.18
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 6
model           : 69
model name      : Intel(R) Core(TM) i5-4200U CPU @ 1.60GHz
stepping        : 1
microcode       : 0x15
cpu MHz         : 2300.449
cache size      : 3072 KB
physical id     : 0
siblings        : 4
core id         : 1
cpu cores       : 2
apicid          : 3
initial apicid  : 3
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb 
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est 
tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 movbe popcnt 
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida arat epb pln pts 
dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep 
bmi2 erms invpcid xsaveopt
bugs            :
bogomips        : 4589.18
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual
power management:

[7.3]
btrfs 935758 0 - Live 0xffffffffc0d2f000
xor 21411 1 btrfs, Live 0xffffffffc0c9d000
raid6_pq 97812 1 btrfs, Live 0xffffffffc0d16000
ufs 75315 0 - Live 0xffffffffc0d02000
qnx4 13394 0 - Live 0xffffffffc0c8d000
hfsplus 103732 0 - Live 0xffffffffc0ce7000
hfs 54819 0 - Live 0xffffffffc0cd8000
minix 36454 0 - Live 0xffffffffc0c93000
ntfs 97736 0 - Live 0xffffffffc0c74000
msdos 17332 0 - Live 0xffffffffc0c6e000
jfs 186915 0 - Live 0xffffffffc0ca9000
xfs 937602 0 - Live 0xffffffffc0b88000
libcrc32c 12644 1 xfs, Live 0xffffffffc0b83000
ipt_MASQUERADE 12880 3 - Live 0xffffffffc0b7e000
iptable_nat 13110 1 - Live 0xffffffffc0b74000
nf_nat_ipv4 13316 1 iptable_nat, Live 0xffffffffc0b79000
nf_nat 26308 3 ipt_MASQUERADE,iptable_nat,nf_nat_ipv4, Live 0xffffffffc0b6c000
nf_conntrack_ipv4 14857 2 - Live 0xffffffffc0b5b000
nf_defrag_ipv4 12758 1 nf_conntrack_ipv4, Live 0xffffffffc0b56000
xt_conntrack 12760 1 - Live 0xffffffffc0b63000
nf_conntrack 105636 6 
ipt_MASQUERADE,iptable_nat,nf_nat_ipv4,nf_nat,nf_conntrack_ipv4,xt_conntrack, 
Live 0xffffffffc0b3b000
ipt_REJECT 12579 2 - Live 0xffffffffc0b36000
xt_CHECKSUM 12549 1 - Live 0xffffffffc0b2c000
iptable_mangle 12734 1 - Live 0xffffffffc0b27000
xt_tcpudp 12924 6 - Live 0xffffffffc0b31000
bridge 122058 0 - Live 0xffffffffc0b08000
stp 12976 1 bridge, Live 0xffffffffc0b03000
llc 14441 2 bridge,stp, Live 0xffffffffc0afa000
ip6table_filter 12815 0 - Live 0xffffffffc0af5000
ip6_tables 27504 1 ip6table_filter, Live 0xffffffffc0adf000
iptable_filter 12810 1 - Live 0xffffffffc0ada000
ip_tables 27718 3 iptable_nat,iptable_mangle,iptable_filter, Live 
0xffffffffc0ace000
rpcsec_gss_krb5 36417 0 - Live 0xffffffffc0aeb000
nfsv4 482990 1 - Live 0xffffffffc0a57000
ebtable_nat 12807 0 - Live 0xffffffffc0a47000
ebtables 35359 1 ebtable_nat, Live 0xffffffffc0a4d000
x_tables 34102 11 
ipt_MASQUERADE,xt_conntrack,ipt_REJECT,xt_CHECKSUM,iptable_mangle,xt_tcpudp,ip6table_filter,ip6_tables,iptable_filter,ip_tables,ebtables, 
Live 0xffffffffc0a3d000
ctr 13193 2 - Live 0xffffffffc0907000
ccm 17856 2 - Live 0xffffffffc0901000
nfsd 297498 2 - Live 0xffffffffc09f3000
rfcomm 75114 10 - Live 0xffffffffc09df000
bnep 19884 2 - Live 0xffffffffc09d9000
auth_rpcgss 60078 2 rpcsec_gss_krb5,nfsd, Live 0xffffffffc08f1000
nfs_acl 12883 1 nfsd, Live 0xffffffffc089d000
nfs 249163 2 nfsv4, Live 0xffffffffc099b000
lockd 95174 2 nfsd,nfs, Live 0xffffffffc090d000
sunrpc 302729 14 rpcsec_gss_krb5,nfsv4,nfsd,auth_rpcgss,nfs_acl,nfs,lockd, 
Live 0xffffffffc08a6000
fscache 64236 2 nfsv4,nfs, Live 0xffffffffc088c000
nls_iso8859_1 12713 1 - Live 0xffffffffc087e000
dm_crypt 23456 0 - Live 0xffffffffc0885000
uvcvideo 86628 0 - Live 0xffffffffc0867000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0xffffffffc07fc000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0xffffffffc06a4000
videobuf2_core 59907 1 uvcvideo, Live 0xffffffffc082f000
v4l2_common 15715 1 videobuf2_core, Live 0xffffffffc069f000
videodev 163831 3 uvcvideo,videobuf2_core,v4l2_common, Live 0xffffffffc0806000
media 22008 2 uvcvideo,videodev, Live 0xffffffffc07f5000
intel_rapl 19196 0 - Live 0xffffffffc074e000
x86_pkg_temp_thermal 14312 0 - Live 0xffffffffc0801000
intel_powerclamp 19099 0 - Live 0xffffffffc0748000
coretemp 13638 0 - Live 0xffffffffc0754000
arc4 12573 2 - Live 0xffffffffc06b6000
kvm_intel 149257 0 - Live 0xffffffffc0841000
snd_soc_rt5640 93123 0 - Live 0xffffffffc07dd000
ath9k 157355 0 - Live 0xffffffffc07b5000
snd_soc_rl6231 13037 1 snd_soc_rt5640, Live 0xffffffffc0645000
ath9k_common 25638 1 ath9k, Live 0xffffffffc060c000
kvm 468567 1 kvm_intel, Live 0xffffffffc0927000
snd_soc_core 207547 1 snd_soc_rt5640, Live 0xffffffffc0781000
snd_hda_codec_realtek 78564 1 - Live 0xffffffffc076c000
snd_hda_codec_hdmi 52620 1 - Live 0xffffffffc06c8000
snd_hda_codec_generic 70087 1 snd_hda_codec_realtek, Live 0xffffffffc0759000
ath9k_hw 460121 2 ath9k,ath9k_common, Live 0xffffffffc06d6000
snd_hda_intel 30783 10 - Live 0xffffffffc06bf000
crct10dif_pclmul 14268 0 - Live 0xffffffffc0607000
ath3k 13381 0 - Live 0xffffffffc0578000
btusb 32408 0 - Live 0xffffffffc06a9000
crc32_pclmul 13180 0 - Live 0xffffffffc069a000
snd_hda_controller 32234 1 snd_hda_intel, Live 0xffffffffc063c000
snd_hda_codec 145035 5 
snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_intel,snd_hda_controller, 
Live 0xffffffffc0675000
snd_compress 19435 1 snd_soc_core, Live 0xffffffffc058b000
snd_pcm_dmaengine 15229 1 snd_soc_core, Live 0xffffffffc04ac000
snd_hwdep 17709 1 snd_hda_codec, Live 0xffffffffc0492000
snd_pcm 105052 7 
snd_soc_rt5640,snd_soc_core,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_controller,snd_hda_codec,snd_pcm_dmaengine, 
Live 0xffffffffc0621000
ath 29397 3 ath9k,ath9k_common,ath9k_hw, Live 0xffffffffc0582000
snd_seq_midi 13564 0 - Live 0xffffffffc0573000
ghash_clmulni_intel 13230 0 - Live 0xffffffffc048d000
aesni_intel 165469 1892 - Live 0xffffffffc064b000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0xffffffffc057d000
snd_rawmidi 31197 1 snd_seq_midi, Live 0xffffffffc0618000
snd_seq 63540 2 snd_seq_midi,snd_seq_midi_event, Live 0xffffffffc0562000
bluetooth 477455 23 rfcomm,bnep,ath3k,btusb, Live 0xffffffffc0591000
mac80211 696913 1 ath9k, Live 0xffffffffc04b6000
acer_wmi 20027 0 - Live 0xffffffffc04a2000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0xffffffffc046e000
sparse_keymap 13890 1 acer_wmi, Live 0xffffffffc04b1000
snd_timer 30118 2 snd_pcm,snd_seq, Live 0xffffffffc0499000
aes_x86_64 17131 1 aesni_intel, Live 0xffffffffc0468000
snd 84025 33 
snd_soc_core,snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_codec_generic,snd_hda_intel,snd_hda_codec,snd_compress,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_seq_device,snd_timer, 
Live 0xffffffffc0477000
lrw 13323 1 aesni_intel, Live 0xffffffffc045e000
gf128mul 14951 1 lrw, Live 0xffffffffc0463000
glue_helper 14095 1 aesni_intel, Live 0xffffffffc0459000
dw_dmac 12835 0 - Live 0xffffffffc044b000
dw_dmac_core 28566 1 dw_dmac, Live 0xffffffffc0443000
lpc_ich 21176 0 - Live 0xffffffffc0452000
ablk_helper 13597 1 aesni_intel, Live 0xffffffffc043e000
snd_soc_sst_acpi 13007 0 - Live 0xffffffffc03a8000
cryptd 20531 946 ghash_clmulni_intel,aesni_intel,ablk_helper, Live 
0xffffffffc03ae000
parport_pc 32906 0 - Live 0xffffffffc039e000
cfg80211 514757 4 ath9k,ath9k_common,ath,mac80211, Live 0xffffffffc03bf000
rtc_efi 12760 0 - Live 0xffffffffc0399000
joydev 17587 0 - Live 0xffffffffc0393000
ppdev 17711 0 - Live 0xffffffffc03b9000
i2c_hid 19065 0 - Live 0xffffffffc038d000
lp 17799 0 - Live 0xffffffffc0387000
mei_me 19524 0 - Live 0xffffffffc036a000
mei 88810 1 mei_me, Live 0xffffffffc0370000
parport 42481 3 parport_pc,ppdev,lp, Live 0xffffffffc0342000
serio_raw 13483 0 - Live 0xffffffffc0332000
soc_button_array 12769 0 - Live 0xffffffffc032d000
i2c_designware_platform 13025 0 - Live 0xffffffffc033d000
soundcore 15091 2 snd_hda_codec,snd, Live 0xffffffffc0173000
i2c_designware_core 14990 1 i2c_designware_platform, Live 0xffffffffc0338000
spi_pxa2xx_platform 23302 0 - Live 0xffffffffc031e000
8250_dw 13474 0 - Live 0xffffffffc0328000
mac_hid 13275 0 - Live 0xffffffffc0137000
hid_generic 12559 0 - Live 0xffffffffc010a000
usbhid 53122 0 - Live 0xffffffffc021a000
hid 110572 3 i2c_hid,hid_generic,usbhid, Live 0xffffffffc034e000
i915 993210 6 - Live 0xffffffffc022a000
i2c_algo_bit 13564 1 i915, Live 0xffffffffc0215000
psmouse 118039 0 - Live 0xffffffffc01d4000
drm_kms_helper 99872 1 i915, Live 0xffffffffc01fb000
ahci 30167 2 - Live 0xffffffffc01f2000
drm 318542 5 i915,drm_kms_helper, Live 0xffffffffc0185000
libahci 32533 1 ahci, Live 0xffffffffc017c000
tg3 179247 0 - Live 0xffffffffc0146000
ptp 19534 1 tg3, Live 0xffffffffc0140000
sdhci_pci 23392 0 - Live 0xffffffffc011e000
pps_core 19381 1 ptp, Live 0xffffffffc0131000
wmi 19379 1 acer_wmi, Live 0xffffffffc0127000
video 20569 2 acer_wmi,i915, Live 0xffffffffc0117000
sdhci_acpi 13395 0 - Live 0xffffffffc010f000
sdhci 44159 2 sdhci_pci,sdhci_acpi, Live 0xffffffffc00fe000

[7.4]
0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0062-0062 : PNP0C09:00
    0062-0062 : EC data
  0064-0064 : keyboard
  0066-0066 : PNP0C09:00
    0066-0066 : EC cmd
  0070-0077 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
  0680-069f : pnp 00:00
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  164e-164f : pnp 00:00
  1800-1803 : ACPI PM1a_EVT_BLK
  1804-1805 : ACPI PM1a_CNT_BLK
  1808-180b : ACPI PM_TMR
  1810-1815 : ACPI CPU throttle
  1830-1833 : iTCO_wdt
  1850-1850 : ACPI PM2_CNT_BLK
  1854-1857 : pnp 00:02
  1860-187f : iTCO_wdt
  1880-189f : ACPI GPE0_BLK
  3000-303f : 0000:00:02.0
  3040-305f : 0000:00:1f.3
  3060-307f : 0000:00:1f.2
    3060-307f : ahci
  3080-3087 : 0000:00:1f.2
    3080-3087 : ahci
  3088-308f : 0000:00:1f.2
    3088-308f : ahci
  3090-3093 : 0000:00:1f.2
    3090-3093 : ahci
  3094-3097 : 0000:00:1f.2
    3094-3097 : ahci
  fd60-fd63 : pnp 00:00
  ffff-ffff : pnp 00:00
    ffff-ffff : pnp 00:00
      ffff-ffff : pnp 00:00

00000000-00000fff : reserved
00001000-0006efff : System RAM
0006f000-0006ffff : reserved
00070000-00087fff : System RAM
00088000-000bffff : reserved
  000a0000-000bffff : PCI Bus 0000:00
000c0000-000c3fff : PCI Bus 0000:00
000c4000-000c7fff : PCI Bus 0000:00
000c8000-000cbfff : PCI Bus 0000:00
000cc000-000cffff : PCI Bus 0000:00
000d0000-000d3fff : PCI Bus 0000:00
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000e0000-000e3fff : PCI Bus 0000:00
000e4000-000e7fff : PCI Bus 0000:00
000e8000-000ebfff : PCI Bus 0000:00
000ec000-000effff : PCI Bus 0000:00
000f0000-000fffff : PCI Bus 0000:00
  000f0000-000fffff : System ROM
00100000-94caffff : System RAM
  02000000-027a9a77 : Kernel code
  027a9a78-02d1e57f : Kernel data
  02e80000-02fc6fff : Kernel bss
94cb0000-960affff : reserved
960b0000-9a6befff : System RAM
9a6bf000-9a8befff : reserved
9a8bf000-9aebefff : reserved
9aebf000-9afbefff : ACPI Non-volatile Storage
9afbf000-9affefff : ACPI Tables
9afff000-9affffff : System RAM
9b000000-9f9fffff : reserved
  9ba00000-9f9fffff : Graphics Stolen Memory
9fa00000-feafffff : PCI Bus 0000:00
  9fa20000-9fa20fff : pnp 00:05
  9fb00000-9fbfffff : PCI Bus 0000:01
    9fb00000-9fb007ff : 0000:01:00.0
  a0000000-afffffff : 0000:00:02.0
  b0000000-b03fffff : 0000:00:02.0
  b0400000-b04fffff : PCI Bus 0000:01
    b0400000-b040ffff : 0000:01:00.1
      b0400000-b040ffff : mmc0
    b0410000-b041ffff : 0000:01:00.0
      b0410000-b041ffff : tg3
    b0420000-b042ffff : 0000:01:00.0
      b0420000-b042ffff : tg3
  b0500000-b05fffff : PCI Bus 0000:02
    b0500000-b057ffff : 0000:02:00.0
      b0500000-b057ffff : ath9k
    b0580000-b058ffff : 0000:02:00.0
  b0600000-b060ffff : 0000:00:14.0
    b0600000-b060ffff : xhci_hcd
  b0610000-b0613fff : 0000:00:03.0
    b0610000-b0613fff : ICH HD audio
  b0614000-b0617fff : 0000:00:1b.0
    b0614000-b0617fff : ICH HD audio
  b0618000-b061801f : 0000:00:16.0
    b0618000-b061801f : mei_me
  b0619000-b06190ff : 0000:00:1f.3
  b061b000-b061b7ff : 0000:00:1f.2
    b061b000-b061b7ff : ahci
  b061c000-b061c3ff : 0000:00:1d.0
    b061c000-b061c3ff : ehci_hcd
  e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
    e0000000-efffffff : reserved
      e0000000-efffffff : pnp 00:05
  fe101000-fe112fff : reserved
feb00000-feb0ffff : reserved
fec00000-fec00fff : reserved
  fec00000-fec003ff : IOAPIC 0
fed00000-fee00fff : reserved
  fed00000-fed003ff : HPET 0
    fed00000-fed003ff : PNP0103:00
  fed10000-fed17fff : pnp 00:05
  fed18000-fed18fff : pnp 00:05
  fed19000-fed19fff : pnp 00:05
  fed1c000-fed1ffff : pnp 00:05
    fed1f410-fed1f414 : iTCO_wdt
  fed20000-fed3ffff : pnp 00:05
  fed90000-fed93fff : pnp 00:05
  fee00000-fee00fff : Local APIC
ff000000-ff000fff : pnp 00:05
ff010000-ffffffff : INT0800:00
  ffc00000-ffffffff : reserved
100000000-15f5fffff : System RAM
15f600000-15fffffff : RAM buffer

[7.5]
00:00.0 Host bridge: Intel Corporation Haswell-ULT DRAM Controller (rev 09)
        Subsystem: Acer Incorporated [ALI] Device 0775
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information: Len=0c <?>

00:02.0 VGA compatible controller: Intel Corporation Haswell-ULT Integrated 
Graphics Controller (rev 09) (prog-if 00 [VGA controller])
        Subsystem: Acer Incorporated [ALI] Device 0775
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 44
        Region 0: Memory at b0000000 (64-bit, non-prefetchable) [size=4M]
        Region 2: Memory at a0000000 (64-bit, prefetchable) [size=256M]
        Region 4: I/O ports at 3000 [size=64]
        Expansion ROM at <unassigned> [disabled]
        Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee0f00c  Data: 41e1
        Capabilities: [d0] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [a4] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: i915

00:03.0 Audio device: Intel Corporation Haswell-ULT HD Audio Controller (rev 
09)
        Subsystem: Acer Incorporated [ALI] Device 0775
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 47
        Region 0: Memory at b0610000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee0f00c  Data: 4162
        Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 
00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- 
TransPend-
        Kernel driver in use: snd_hda_intel

00:14.0 USB controller: Intel Corporation Lynx Point-LP USB xHCI HC (rev 04) 
(prog-if 30 [XHCI])
        Subsystem: Acer Incorporated [ALI] Device 0775
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 42
        Region 0: Memory at b0600000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [70] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+
                Address: 00000000fee0c00c  Data: 41c1
        Kernel driver in use: xhci_hcd

00:16.0 Communication controller: Intel Corporation Lynx Point-LP HECI #0 (rev 
04)
        Subsystem: Acer Incorporated [ALI] Device 0775
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 45
        Region 0: Memory at b0618000 (64-bit, non-prefetchable) [size=32]
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee0f00c  Data: 4122
        Kernel driver in use: mei_me

00:1b.0 Audio device: Intel Corporation Lynx Point-LP HD Audio Controller (rev 
04)
        Subsystem: Acer Incorporated [ALI] Device 0775
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 46
        Region 0: Memory at b0614000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee0f00c  Data: 4152
        Capabilities: [70] Express (v1) Root Complex Integrated Endpoint, MSI 
00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
                VC1:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable- ID=0 ArbSelect=Fixed TC/VC=00
                        Status: NegoPending- InProgress-
        Kernel driver in use: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Root Port 3 
(rev e4) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: 9fb00000-9fbfffff
        Prefetchable memory behind bridge: 00000000b0400000-00000000b04fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
                LnkCap: Port #3, Speed 5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <512ns, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot+
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive+ BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
Surprise-
                        Slot #2, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- 
LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- 
Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
                        Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ 
CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR-, 
OBFF Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, 
OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee0f00c  Data: 4171
        Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device 0775
        Capabilities: [a0] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100 v0] #00
        Capabilities: [200 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
L1_PM_Substates+
                          PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
        Kernel driver in use: pcieport

00:1c.3 PCI bridge: Intel Corporation Lynx Point-LP PCI Express Root Port 4 
(rev e4) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: b0500000-b05fffff
        Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0
                        ExtTag- RBE+
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
                LnkCap: Port #4, Speed 5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <512ns, L1 <16us
                        ClockPM- Surprise- LLActRep+ BwNot+
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive+ BWMgmt+ ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- 
Surprise-
                        Slot #3, PowerLimit 10.000W; Interlock- NoCompl+
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- 
LinkChg-
                        Control: AttnInd Unknown, PwrInd Unknown, Power- 
Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
                        Changed: MRL- PresDet- LinkState+
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ 
CRSVisible-
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range ABC, TimeoutDis+, LTR-, 
OBFF Not Supported ARIFwd-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, 
OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee0f00c  Data: 4191
        Capabilities: [90] Subsystem: Acer Incorporated [ALI] Device 0775
        Capabilities: [a0] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100 v0] #00
        Capabilities: [200 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
L1_PM_Substates+
                          PortCommonModeRestoreTime=40us PortTPowerOnTime=10us
        Kernel driver in use: pcieport

00:1d.0 USB controller: Intel Corporation Lynx Point-LP USB EHCI #1 (rev 04) 
(prog-if 20 [EHCI])
        Subsystem: Acer Incorporated [ALI] Device 0775
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 23
        Region 0: Memory at b061c000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Debug port: BAR=1 offset=00a0
        Capabilities: [98] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-
        Kernel driver in use: ehci-pci

00:1f.0 ISA bridge: Intel Corporation Lynx Point-LP LPC Controller (rev 04)
        Subsystem: Acer Incorporated [ALI] Device 0775
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Capabilities: [e0] Vendor Specific Information: Len=0c <?>
        Kernel driver in use: lpc_ich

00:1f.2 SATA controller: Intel Corporation Lynx Point-LP SATA Controller 1 
[AHCI mode] (rev 04) (prog-if 01 [AHCI 1.0])
        Subsystem: Acer Incorporated [ALI] Device 0775
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin B routed to IRQ 43
        Region 0: I/O ports at 3088 [size=8]
        Region 1: I/O ports at 3094 [size=4]
        Region 2: I/O ports at 3080 [size=8]
        Region 3: I/O ports at 3090 [size=4]
        Region 4: I/O ports at 3060 [size=32]
        Region 5: Memory at b061b000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
                Address: fee0c00c  Data: 41d1
        Capabilities: [70] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [a8] SATA HBA v1.0 BAR4 Offset=00000004
        Kernel driver in use: ahci

00:1f.3 SMBus: Intel Corporation Lynx Point-LP SMBus Controller (rev 04)
        Subsystem: Acer Incorporated [ALI] Device 0775
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin C routed to IRQ 0
        Region 0: Memory at b0619000 (64-bit, non-prefetchable) [size=256]
        Region 4: I/O ports at 3040 [size=32]

01:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM57786 Gigabit 
Ethernet PCIe (rev 01)
        Subsystem: Acer Incorporated [ALI] Device 0775
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at b0410000 (64-bit, prefetchable) [size=64K]
        Region 2: Memory at b0420000 (64-bit, prefetchable) [size=64K]
        Expansion ROM at 9fb00000 [disabled] [size=2K]
        Capabilities: [48] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
                Product Name: Broadcom NetXtreme Gigabit Ethernet Controller
                Read-only fields:
                        [PN] Part number: BCM957766
                        [EC] Engineering changes: 106679-15
                        [SN] Serial number: 0123456789
                        [MN] Manufacture ID: 31 34 65 34
                        [RV] Reserved: checksum good, 27 byte(s) reserved
                End
        Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [a0] MSI-X: Enable+ Count=5 Masked-
                Vector table: BAR=2 offset=00000000
                PBA: BAR=2 offset=00000120
        Capabilities: [ac] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr+ NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <2us, L1 <64us
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR+, 
OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, 
OBFF Disabled
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- 
SpeedDis-
                         Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ 
ChkEn-
        Capabilities: [13c v1] Device Serial Number 00-00-20-1a-06-70-b7-af
        Capabilities: [150 v1] Power Budgeting <?>
        Capabilities: [160 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
        Capabilities: [1b0 v1] Latency Tolerance Reporting
                Max snoop latency: 0ns
                Max no snoop latency: 0ns
        Kernel driver in use: tg3

01:00.1 SD Host controller: Broadcom Corporation BCM57765/57785 SDXC/MMC Card 
Reader (rev 01) (prog-if 01)
        Subsystem: Acer Incorporated [ALI] Device 0775
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin B routed to IRQ 19
        Region 0: Memory at b0400000 (64-bit, prefetchable) [size=64K]
        Capabilities: [48] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [58] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [ac] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, 
L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 4096 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ 
TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <2us, L1 <64us
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR-, 
OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, 
OBFF Disabled
                LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ 
ChkEn-
        Capabilities: [150 v1] Power Budgeting <?>
        Capabilities: [160 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
        Kernel driver in use: sdhci-pci

02:00.0 Network controller: Qualcomm Atheros QCA9565 / AR9565 Wireless Network 
Adapter (rev 01)
        Subsystem: Lite-On Communications Inc Device 0632
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at b0500000 (64-bit, non-prefetchable) [size=512K]
        Expansion ROM at b0580000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable- Count=1/4 Maskable+ 64bit+
                Address: 0000000000000000  Data: 0000
                Masking: 00000000  Pending: 00000000
        Capabilities: [70] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ 
TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <4us, L1 <64us
                        ClockPM- Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, 
OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, 
OBFF Disabled
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- 
SpeedDis-
                         Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap- CGenEn- ChkCap- 
ChkEn-
        Capabilities: [140 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
        Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
        Kernel driver in use: ath9k

[7.6]
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST500LT012-9WS14 Rev: SDM1
  Type:   Direct-Access                    ANSI  SCSI revision: 05

 [7.7]
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 10
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 100
dr-xr-xr-x  9 syslog          syslog                   0 loka   4 00:19 1006
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1011
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1035
dr-xr-xr-x  9 avahi           avahi                    0 loka   4 00:19 1038
dr-xr-xr-x  9 avahi           avahi                    0 loka   4 00:19 1039
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1047
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1054
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1067
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1076
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1082
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 11
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1131
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1135
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1144
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1145
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1148
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1174
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1181
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 12
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1219
dr-xr-xr-x  9 kernoops        adm                      0 loka   4 00:19 1225
dr-xr-xr-x  9 root            root                     0 loka   4 00:30 12366
dr-xr-xr-x  9 root            root                     0 loka   4 00:30 12367
dr-xr-xr-x  9 root            root                     0 loka   4 00:30 12368
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1237
dr-xr-xr-x  9 root            root                     0 loka   4 00:30 12376
dr-xr-xr-x  9 root            root                     0 loka   4 00:30 12377
dr-xr-xr-x  9 root            root                     0 loka   4 00:30 12378
dr-xr-xr-x  9 root            root                     0 loka   4 00:30 12379
dr-xr-xr-x  9 root            root                     0 loka   4 00:30 12380
dr-xr-xr-x  9 root            root                     0 loka   4 00:30 12381
dr-xr-xr-x  9 root            root                     0 loka   4 00:30 12400
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1261
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1270
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 13
dr-xr-xr-x  9 root            root                     0 loka   4 00:20 1316
dr-xr-xr-x  9 root            root                     0 loka   4 00:20 1321
dr-xr-xr-x  9 root            root                     0 loka   4 00:20 1322
dr-xr-xr-x  9 root            root                     0 loka   4 00:20 1323
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:31 13233
dr-xr-xr-x  9 root            root                     0 loka   4 00:20 1331
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1333
dr-xr-xr-x  9 root            root                     0 loka   4 00:35 13356
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:35 13357
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:35 13358
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:35 13363
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:37 13412
dr-xr-xr-x  9 root            root                     0 loka   4 00:37 13414
dr-xr-xr-x  9 root            root                     0 loka   4 00:20 1345
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1367
dr-xr-xr-x  9 whoopsie        whoopsie                 0 loka   4 00:19 1370
dr-xr-xr-x  9 nobody          dip                      0 loka   4 00:19 1376
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 14
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1426
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1437
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1440
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 147
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 148
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 149
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 15
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 150
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 151
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 152
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 153
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 154
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 155
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 156
dr-xr-xr-x  9 root            root                     0 loka   4 00:20 1568
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 16
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 161
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 162
dr-xr-xr-x  9 root            root                     0 loka   4 00:20 1639
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 17
dr-xr-xr-x  9 libvirt-dnsmasq dip                      0 loka   4 00:20 1702
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1719
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 1763
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 18
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 19
dr-xr-xr-x  9 root            root                     0 loka   4 00:20 1929
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 1949
dr-xr-xr-x  9 root            root                     0 loka   4 00:20 1950
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 1962
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 2
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 20
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 207
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 208
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2081
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2083
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2088
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 209
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2094
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 21
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 210
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2105
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2107
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2109
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 211
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2173
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 22
dr-xr-xr-x  9 root            root                     0 loka   4 00:20 2204
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2235
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2238
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2239
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2240
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2242
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2246
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2248
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2250
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2255
dr-xr-xr-x  9 colord          colord                   0 loka   4 00:20 2264
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2268
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2269
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2271
dr-xr-xr-x  9 root            root                     0 loka   4 00:20 2273
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2284
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2298
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 23
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2301
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2303
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2305
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2327
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2336
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2339
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2365
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2367
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2369
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2374
dr-xr-xr-x  9 rtkit           rtkit                    0 loka   4 00:20 2376
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2380
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2382
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2383
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2387
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2396
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 24
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2426
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2439
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 246
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2465
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2475
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 25
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2503
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2504
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2505
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2508
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2513
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2514
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2515
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2516
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2517
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2522
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2523
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2524
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2525
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:20 2598
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 26
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:21 2609
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:21 2613
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:21 2620
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:21 2627
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:21 2628
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:21 2661
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 27
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:21 2700
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 28
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 29
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 3
dr-xr-xr-x  9 root            root                     0 loka   4 00:24 3004
dr-xr-xr-x  9 lp              lp                       0 loka   4 00:24 3007
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 31
dr-xr-xr-x  9 root            root                     0 loka   4 00:26 3143
dr-xr-xr-x  9 root            root                     0 loka   4 00:26 3154
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 32
dr-xr-xr-x  9 sgofferj        sgofferj                 0 loka   4 00:29 3293
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 33
dr-xr-xr-x  9 root            root                     0 loka   4 00:29 3308
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 34
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 36
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 37
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 38
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 386
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 39
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 391
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 40
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 41
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 42
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 43
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 44
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 446
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 45
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 457
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 46
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 47
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 48
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 49
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 5
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 50
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 51
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 52
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 53
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 534
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 54
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 55
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 56
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 58
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 588
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 59
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 591
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 598
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 60
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 62
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 620
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 63
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 64
dr-xr-xr-x  9 statd           nogroup                  0 loka   4 00:19 688
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 7
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 76
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 77
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 78
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 79
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 8
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 80
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 888
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 9
dr-xr-xr-x  9 messagebus      messagebus               0 loka   4 00:19 901
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 913
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 975
dr-xr-xr-x  9 root            root                     0 loka   4 00:19 99
dr-xr-xr-x  3 root            root                     0 loka   4 00:37 acpi
dr-xr-xr-x  6 root            root                     0 loka   4 00:37 asound
-r--r--r--  1 root            root                     0 loka   4 00:37 
buddyinfo
dr-xr-xr-x  4 root            root                     0 loka   4 00:37 bus
-r--r--r--  1 root            root                     0 loka   4 00:37 
cgroups
-r--r--r--  1 root            root                     0 loka   4 00:37 
cmdline
-r--r--r--  1 root            root                     0 loka   4 00:37 
consoles
-r--r--r--  1 root            root                     0 loka   4 00:37 
cpuinfo
-r--r--r--  1 root            root                     0 loka   4 00:37 crypto
-r--r--r--  1 root            root                     0 loka   4 00:37 
devices
-r--r--r--  1 root            root                     0 loka   4 00:37 
diskstats
-r--r--r--  1 root            root                     0 loka   4 00:37 dma
dr-xr-xr-x  2 root            root                     0 loka   4 00:37 driver
-r--r--r--  1 root            root                     0 loka   4 00:37 
execdomains
-r--r--r--  1 root            root                     0 loka   4 00:37 fb
-r--r--r--  1 root            root                     0 loka   4 00:37 
filesystems
dr-xr-xr-x 10 root            root                     0 loka   4 00:37 fs
-r--r--r--  1 root            root                     0 loka   4 00:37 
interrupts
-r--r--r--  1 root            root                     0 loka   4 00:37 iomem
-r--r--r--  1 root            root                     0 loka   4 00:37 
ioports
dr-xr-xr-x 33 root            root                     0 loka   4 00:37 irq
-r--r--r--  1 root            root                     0 loka   4 00:37 
kallsyms
-r--------  1 root            root       140737477881856 loka   4 00:37 kcore
-r--r--r--  1 root            root                     0 loka   4 00:37 keys
-r--r--r--  1 root            root                     0 loka   4 00:37 key-
users
-r--------  1 root            root                     0 loka   4 00:19 kmsg
-r--------  1 root            root                     0 loka   4 00:37 
kpagecount
-r--------  1 root            root                     0 loka   4 00:37 
kpageflags
-r--r--r--  1 root            root                     0 loka   4 00:37 
loadavg
-r--r--r--  1 root            root                     0 loka   4 00:37 locks
-r--r--r--  1 root            root                     0 loka   4 00:37 mdstat
-r--r--r--  1 root            root                     0 loka   4 00:37 
meminfo
-r--r--r--  1 root            root                     0 loka   4 00:37 misc
-r--r--r--  1 root            root                     0 loka   4 00:37 
modules
lrwxrwxrwx  1 root            root                    11 loka   4 00:37 mounts 
-> self/mounts
-rw-r--r--  1 root            root                     0 loka   4 00:19 mtrr
lrwxrwxrwx  1 root            root                     8 loka   4 00:37 net -> 
self/net
-r--r--r--  1 root            root                     0 loka   4 00:37 
pagetypeinfo
-r--r--r--  1 root            root                     0 loka   4 00:37 
partitions
-r--r--r--  1 root            root                     0 loka   4 00:37 
sched_debug
-r--r--r--  1 root            root                     0 loka   4 00:37 
schedstat
dr-xr-xr-x  3 root            root                     0 loka   4 00:37 scsi
lrwxrwxrwx  1 root            root                     0 loka   4  2014 self -
> 13414
-r--------  1 root            root                     0 loka   4 00:37 
slabinfo
-r--r--r--  1 root            root                     0 loka   4 00:37 
softirqs
-r--r--r--  1 root            root                     0 loka   4 00:37 stat
-r--r--r--  1 root            root                     0 loka   4 00:20 swaps
dr-xr-xr-x  1 root            root                     0 loka   4  2014 sys
--w-------  1 root            root                     0 loka   4 00:37 sysrq-
trigger
dr-xr-xr-x  2 root            root                     0 loka   4 00:37 
sysvipc
lrwxrwxrwx  1 root            root                     0 loka   4  2014 
thread-self -> 13414/task/13414
-r--r--r--  1 root            root                     0 loka   4 00:37 
timer_list
-rw-r--r--  1 root            root                     0 loka   4 00:37 
timer_stats
dr-xr-xr-x  4 root            root                     0 loka   4 00:37 tty
-r--r--r--  1 root            root                     0 loka   4 00:37 uptime
-r--r--r--  1 root            root                     0 loka   4 00:37 
version
-r--------  1 root            root                     0 loka   4 00:37 
vmallocinfo
-r--r--r--  1 root            root                     0 loka   4 00:37 vmstat
-r--r--r--  1 root            root                     0 loka   4 00:37 
zoneinfo

[X]
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1377292

