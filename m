From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: Linux v3.1-rc3/8 : card insertion/removal not working
Date: Thu, 13 Oct 2011 20:35:15 +0530
Message-ID: <C82BA3053CFD354AACBD25EFBD2A4EC603F959EF72@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi all,

Hi all,

We are porting existing OMAP HSMMC driver (omap_hsmmc.c) to an upcoming SOC. The HSMMC IP is same as the one found in DM814x which uses the IP CD pins to detect MMC card insertion/removal rather than using gpio pins.

When testing the driver with SanDisk 16GB SDHC Card (SanDisk Extreme HD Video 16GB 20Mb/s), we have observed that the card insertion/removal is not detected.

The PSTATE variable CINS do not change across card insertion/removal. However we do see a change in the CDPL bit in SD_PSTATE register. 

I have attached the logs[1] on Linux v3.1-rc8 that I get for reference.


Also, I tested the same on Linux v3.1-rc3 and found some interesting point. The card insertion/removal is detected when I read the "regs"parameter from omap hsmmc driver debugfs feature. As soon as I read the regs parameter, I get card insertion/removal messages on console. However the sad part is that the same procedure doesn't work on v3.1-rc8.

I have attached the logs[2] on Linux v3.1-rc3 that I get for reference.

Can someone guide on what could be the probable cause.

Thanks in advance

Regards
Gururaja


[1]Logs

[    0.000000] Linux version 3.1.0-rc8-51950-g2886ac9-dirty (ghebbar@linux-psp-server.india.ext.ti.com) (gcc version 4.3.3 (GCC) ) #49 Wed Oct 12 15:31:19 IST 2011
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine: am335xevm
[    0.000000] Memory policy: ECC disabled, Data cache writeback
...
...
[    2.032665] mmc0: new SD card at address aaaa
[    2.037800] mmcblk0: mmc0:aaaa SD02G 1.84 GiB
[    2.045124]  mmcblk0: p1
...
...


root@arago-armv7:~#mkdir -p /debugfs
root@arago-armv7:~#mount -t debugfs debugfs /debugfs
root@arago-armv7:~#cd /debugfs/mmc0/

1.	With card, no write-protect
root@arago-armv7:/debugfs/mmc0# cat clock
25000000

root@arago-armv7:/debugfs/mmc0# cat ios
clock:          25000000 Hz
vdd:            20 (3.2 ~ 3.3 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      2 (4 bits)
timing spec:    0 (legacy)

root@arago-armv7:/debugfs/mmc0# cat regs
mmc0:
enabled:       0
dpm_state:     0
nesting_cnt:   0
ctx_loss:      0:0

regs:
SYSCONFIG:      0x00002015
CON:            0x00000700
HCTL:           0x00000d02
SYSCTL:         0x00090107
IE:             0x000000c0
ISE:            0x000000c0
CAPA:           0x06e10080
STAT:           0x00000000
PSTATE:         0x01ff0000

2. Without card
root@arago-armv7:/debugfs/mmc0# cat clock
25000000

root@arago-armv7:/debugfs/mmc0# cat ios
clock:          25000000 Hz
vdd:            20 (3.2 ~ 3.3 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      2 (4 bits)
timing spec:    0 (legacy)

root@arago-armv7:/debugfs/mmc0# cat regs
mmc0:
enabled:       0
dpm_state:     0
nesting_cnt:   0
ctx_loss:      0:0

regs:
SYSCONFIG:      0x00002015
CON:            0x00000700
HCTL:           0x00000d02
SYSCTL:         0x00090107
IE:             0x000000c0
ISE:            0x000000c0
CAPA:           0x06e10080
STAT:           0x00000000
PSTATE:         0x01fb0000



[2]Logs

Uncompressing Linux... done, booting the kernel.
[    0.000000] Linux version 3.1.0-rc3-50824-gbd42c3b-dirty (user@linux-server) (gcc version 4.3.3 (GCC) ) #7 SMP Thu Oct 13 15:37:58 IST 2011
[    0.000000] CPU: ARMv7 Processor [413fc082] revision 2 (ARMv7), cr=10c53c7f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT aliasing instruction cache

1.	1st case. Card is present while booting kernel. 
Removal of card is not detected. Since omap hsmmc driver supports debugfs, I mounted debugfs. 
Inside mmc0 entry, I read "regs" parameter. As soon as I read, card removal got detected and I saw the log. 
Same for Card insertion also. Initially no response on console. As soon as I read the "regs" parameter, I was able to get console output and the card was mounted

2.	2nd case. Card is not present while booting kernel. 
Upon booting
                                ...
...
[    2.091839] Driver for 1-wire Dallas network protocol.
[    2.101173] OMAP Watchdog Timer Rev 0x01: initial timeout 60 sec
[    2.113554] omap_hsmmc omap_hsmmc.0: omap_hsmmc_runtime_resume : 2416 - enabled                 --> all these added for debugging
[    2.123089] omap_hsmmc omap_hsmmc.0: omap_hsmmc_runtime_suspend : 2405 - disabled
[    2.131592] omap_hsmmc omap_hsmmc.0: omap_hsmmc_enable_fclk : 1890 - enabled fclk
[    2.139781] omap_hsmmc omap_hsmmc.0: omap_hsmmc_runtime_resume : 2416 - enabled
[    2.147576] omap_hsmmc omap_hsmmc.0: omap_hsmmc_disable_fclk : 1899 - disabled fclk
[    2.158232] usbcore: registered new interface driver usbhid
[    2.164218] usbhid: USB HID core driver
...
...

Card insertion is not detected. After card insertion waited for 1 min. no console output

root@arago-armv7:~# mkdir -p /debugfs
root@arago-armv7:~# mount -t debugfs debugfs /debugfs
root@arago-armv7:~# /debugfs/mmc0/
-sh: /debugfs/mmc0/: Permission denied
root@arago-armv7:~# cd /debugfs/mmc0/
root@arago-armv7:/debugfs/mmc0#
root@arago-armv7:/debugfs/mmc0# dmesg -c
root@arago-armv7:/debugfs/mmc0# cat regs
[  321.314130] omap_hsmmc omap_hsmmc.0: omap_hsmmc_runtime_resume : 2416 - enabled
[  321.323063] omap_hsmmc omap_hsmmc.0: omap_hsmmc_enable_fclk : 1890 - enabled fclk
[  321.330970] omap_hsmmc omap_hsmmc.0: omap_hsmmc_disable_fclk : 1899 - disabled fclk
mmc0:
enabled:       0
dpm_state:     0
nesting_cnt:   0
ctx_loss:      0:0

regs:
SYSCONFIG:      0x00002015
CON:            0x00000701
HCTL:           0x00000d00
SYSCTL:         0x000e0007
IE:             0x000000c0
ISE:            0x000000c0
CAPA:           0x06e10080
STAT:           0x00000000                  --> all these added for debugging
PSTATE:         0x01ff0000
root@arago-armv7:/debugfs/mmc0# [  321.432397] omap_hsmmc omap_hsmmc.0: omap_hsmmc_runtime_suspend : 2405 - disabled
[  321.533229] omap_hsmmc omap_hsmmc.0: omap_hsmmc_enable_fclk : 1890 - enabled fclk
[  321.541189] omap_hsmmc omap_hsmmc.0: omap_hsmmc_runtime_resume : 2416 - enabled
[  321.549012] omap_hsmmc omap_hsmmc.0: omap_hsmmc_disable_fclk : 1899 - disabled fclk
[  321.557360] omap_hsmmc omap_hsmmc.0: omap_hsmmc_enable_fclk : 1890 - enabled fclk
[  321.704834] omap_hsmmc omap_hsmmc.0: omap_hsmmc_disable_fclk : 1899 - disabled fclk
[  321.713045] mmc0: new high speed SD card at address b368
[  321.726306] omap_hsmmc omap_hsmmc.0: omap_hsmmc_enable_fclk : 1890 - enabled fclk
[  321.748481] omap_hsmmc omap_hsmmc.0: omap_hsmmc_disable_fclk : 1899 - disabled fclk
[  321.756730] mmcblk0: mmc0:b368 SDC   477 MiB
[  321.769550] omap_hsmmc omap_hsmmc.0: omap_hsmmc_enable_fclk : 1890 - enabled fclk
[  321.791883] omap_hsmmc omap_hsmmc.0: omap_hsmmc_disable_fclk : 1899 - disabled fclk
[  321.808877]  mmcblk0: p1 p2
[  321.823822] omap_hsmmc omap_hsmmc.0: omap_hsmmc_enable_fclk : 1890 - enabled fclk
[  321.831750] omap_hsmmc omap_hsmmc.0: omap_hsmmc_disable_fclk : 1899 - disabled fclk
...
...


