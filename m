From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH mmc/next v3 0/2] mmc: tmio, renesas-sdhi: cleanups
Date: Fri, 16 Jun 2017 18:11:02 +0200
Message-ID: <1497629464-14459-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Hi,

this short series provides some cleanups to the tmio and renesas-sdhi
drivers to improve their checkpatch cleanness.

Changes since v2:
* Address review - details noted in changelogs of each patch

Lightly tested on H2/Lager and M3-W/Salvator-X as per the log below.

Simon Horman (2):
  mmc: tmio: improve checkpatch cleanness
  mmc: renesas-sdhi: improve checkpatch cleanness

 drivers/mmc/host/renesas_sdhi.h          |  4 +-
 drivers/mmc/host/renesas_sdhi_core.c     | 43 +++++++++++----------
 drivers/mmc/host/renesas_sdhi_sys_dmac.c | 25 ++++++------
 drivers/mmc/host/tmio_mmc.c              |  8 ++--
 drivers/mmc/host/tmio_mmc.h              | 17 ++++----
 drivers/mmc/host/tmio_mmc_core.c         | 66 +++++++++++++++++---------------
 include/linux/mfd/tmio.h                 | 33 ++++++++--------
 7 files changed, 103 insertions(+), 93 deletions(-)

-- 
2.1.4

Salvator-X/M3-W ES1.0
=====================

With Cleanup
------------

5a0e681d4c56 ("mmc: renesas-sdhi: improve checkpatch cleanness")

# dmesg | egrep '(sd|mmc)'
[    1.410058] sdhci: Secure Digital Host Controller Interface driver
[    1.416271] sdhci: Copyright(c) Pierre Ossman
[    1.421257] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    1.426171] sh_mobile_sdhi ee100000.sd: Got WP GPIO
[    1.557515] sh_mobile_sdhi ee140000.sd: mmc0 base at 0xee140000 max clock rate 200 MHz
[    1.565873] sh_mobile_sdhi ee160000.sd: Got CD GPIO
[    1.570806] sh_mobile_sdhi ee160000.sd: Got WP GPIO
[    1.584531] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.633928] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    1.638941] sh_mobile_sdhi ee100000.sd: Got WP GPIO
[    1.765569] sh_mobile_sdhi ee100000.sd: mmc1 base at 0xee100000 max clock rate 200 MHz
[    1.774965] sh_mobile_sdhi ee160000.sd: Got CD GPIO
[    1.779903] sh_mobile_sdhi ee160000.sd: Got WP GPIO
[    1.811972] mmc0: new high speed MMC card at address 0001
[    1.817790] mmcblk0: mmc0:0001 eMMC   28.8 GiB
[    1.826541] mmcblk0boot0: mmc0:0001 eMMC   partition 1 4.00 MiB
[    1.836647] mmcblk0boot1: mmc0:0001 eMMC   partition 2 4.00 MiB
[    1.848444] mmcblk0rpmb: mmc0:0001 eMMC   partition 3 4.00 MiB
[    1.858737]  mmcblk0: p1
[    1.917609] sh_mobile_sdhi ee160000.sd: mmc2 base at 0xee160000 max clock rate 200 MHz
[    2.065539] mmc1: new ultra high speed SDR50 SDHC card at address e624
[    2.072548] mmcblk1: mmc1:e624 SU08G 7.40 GiB
[    2.088110]  mmcblk1: p1
[    2.189536] mmc2: new ultra high speed SDR50 SDHC card at address 0001
[    2.196412] mmcblk2: mmc2:0001 00000 29.8 GiB
[    2.210919]  mmcblk2: p1
root@Debian:~# cat /sys/devi

# grep sd /proc/interrupts
100:    1063140          0     GIC-0 197 Level     ee100000.sd
101:       3012          0     GIC-0 199 Level     ee140000.sd
102:       2276          0     GIC-0 200 Level     ee160000.sd
178:          0          0  e6053000.gpio  12 Edge      ee100000.sd cd
197:          0          0  e6054000.gpio  15 Edge      ee160000.sd cd

# cat /sys/devices/platform/soc/ee100000.sd/mmc_host/mmc1/mmc1:*/cid
035344535530384780b1b8a11200d300
# dd if=/dev/mmcblk1 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 56.3221 s, 9.5 MB/s

# cat /sys/devices/platform/soc/ee160000.sd/mmc_host/mmc2/mmc2:*/cid
1b534d3030303030103916141700f600
# dd if=/dev/mmcblk2 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 56.7888 s, 9.5 MB/s

# grep sd /proc/interrupts
100:    2124004          0     GIC-0 197 Level     ee100000.sd
101:       3012          0     GIC-0 199 Level     ee140000.sd
102:    1063140          0     GIC-0 200 Level     ee160000.sd
178:          0          0  e6053000.gpio  12 Edge      ee100000.sd cd
197:          0          0  e6054000.gpio  15 Edge      ee160000.sd cd

Without Cleanup
---------------

f2cd281b9f7d (mmc/next) mmc: sdhci-pci: Enable card detect wake for Intel BYT-related SD controllers

# dmesg | egrep '(sd|mmc)'
[    1.413160] sdhci: Secure Digital Host Controller Interface driver
[    1.419368] sdhci: Copyright(c) Pierre Ossman
[    1.424317] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    1.429254] sh_mobile_sdhi ee100000.sd: Got WP GPIO
[    1.556994] sh_mobile_sdhi ee140000.sd: mmc0 base at 0xee140000 max clock rate 200 MHz
[    1.565359] sh_mobile_sdhi ee160000.sd: Got CD GPIO
[    1.570313] sh_mobile_sdhi ee160000.sd: Got WP GPIO
[    1.584078] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.633385] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    1.638319] sh_mobile_sdhi ee100000.sd: Got WP GPIO
[    1.765061] sh_mobile_sdhi ee100000.sd: mmc1 base at 0xee100000 max clock rate 200 MHz
[    1.774258] sh_mobile_sdhi ee160000.sd: Got CD GPIO
[    1.779185] sh_mobile_sdhi ee160000.sd: Got WP GPIO
[    1.834292] mmc0: new high speed MMC card at address 0001
[    1.840594] mmcblk0: mmc0:0001 eMMC   28.8 GiB 
[    1.850501] mmcblk0boot0: mmc0:0001 eMMC   partition 1 4.00 MiB
[    1.860750] mmcblk0boot1: mmc0:0001 eMMC   partition 2 4.00 MiB
[    1.870834] mmcblk0rpmb: mmc0:0001 eMMC   partition 3 4.00 MiB
[    1.880344]  mmcblk0: p1
[    1.909078] sh_mobile_sdhi ee160000.sd: mmc2 base at 0xee160000 max clock rate 200 MHz
[    2.049028] mmc1: new ultra high speed SDR50 SDHC card at address e624
[    2.060070] mmcblk1: mmc1:e624 SU08G 7.40 GiB 
[    2.075628]  mmcblk1: p1
[    2.165019] mmc2: new ultra high speed SDR50 SDHC card at address 0001
[    2.175911] mmcblk2: mmc2:0001 00000 29.8 GiB 
[    2.190409]  mmcblk2: p1

# grep sd /proc/interrupts
100:       2276          0     GIC-0 197 Level     ee100000.sd
101:       2986          0     GIC-0 199 Level     ee140000.sd
102:       2276          0     GIC-0 200 Level     ee160000.sd
178:          0          0  e6053000.gpio  12 Edge      ee100000.sd cd
197:          0          0  e6054000.gpio  15 Edge      ee160000.sd cd

# cat /sys/devices/platform/soc/ee100000.sd/mmc_host/mmc1/mmc1:*/cid
035344535530384780b1b8a11200d300
# dd if=/dev/mmcblk2 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 56.7595 s, 9.5 MB/s

# cat /sys/devices/platform/soc/ee160000.sd/mmc_host/mmc2/mmc2:*/cid
1b534d3030303030103916141700f600
# dd if=/dev/mmcblk2 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 56.7595 s, 9.5 MB/s

# grep sd /proc/interrupts
100:       2276          0     GIC-0 197 Level     ee100000.sd
101:       2986          0     GIC-0 199 Level     ee140000.sd
102:    2124004          0     GIC-0 200 Level     ee160000.sd
178:          0          0  e6053000.gpio  12 Edge      ee100000.sd cd
197:          0          0  e6054000.gpio  15 Edge      ee160000.sd cd


Lager/H2 ES2.0
==============

With Cleanup
------------

5a0e681d4c56 ("mmc: renesas-sdhi: improve checkpatch cleanness")

# dmesg | egrep '(sd|mmc)'
[    2.309775] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    2.315203] sh_mobile_sdhi ee140000.sd: Got CD GPIO
[    2.375149] sh_mmcif ee220000.mmc: Chip version 0x0003, clock rate 12MHz
[    2.481838] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    2.695297] sh_mobile_sdhi ee100000.sd: mmc1 base at 0xee100000 max clock rate 195 MHz
[    2.703764] sh_mobile_sdhi ee140000.sd: Got CD GPIO
[    2.784274] mmc0: new high speed MMC card at address 0001
[    2.790078] mmcblk0: mmc0:0001 MMC08G 7.33 GiB 
[    2.794796] mmcblk0boot0: mmc0:0001 MMC08G partition 1 2.00 MiB
[    2.800926] mmcblk0boot1: mmc0:0001 MMC08G partition 2 2.00 MiB
[    2.808580]  mmcblk0: p1
[    2.915292] sh_mobile_sdhi ee140000.sd: mmc2 base at 0xee140000 max clock rate 97 MHz
[    3.122381] mmc1: new ultra high speed SDR104 SDHC card at address 0001
[    3.129381] mmcblk1: mmc1:0001 00000 29.8 GiB 
[    3.143191]  mmcblk1: p1
[    3.335268] mmc2: new ultra high speed SDR50 SDHC card at address 0001
[    3.342131] mmcblk2: mmc2:0001 00000 29.8 GiB 
[    3.356094]  mmcblk2: p1

# grep sd /proc/interrupts
 99:        572          0          0          0     GIC-0 197 Level     ee100000.sd
100:        540          0          0          0     GIC-0 199 Level     ee140000.sd
220:          0          0          0          0  e6053000.gpio   6 Edge      ee100000.sd cd
236:          0          0          0          0  e6053000.gpio  22 Edge      ee140000.sd cd

# cat /sys/devices/platform/ee100000.sd/mmc_host/mmc1/mmc1:*/cid
1b534d303030303010ed85537600fc00
# dd if=/dev/mmcblk1 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 14.5894 s, 36.8 MB/

# cat /sys/devices/platform/ee140000.sd/mmc_host/mmc2/mmc2:*/cid
1b534d303030303010f0c957f500fc00
# dd if=/dev/mmcblk2 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 18.8921 s, 28.4 MB/s

# grep sd /proc/interrupts
 99:      12860          0          0          0     GIC-0 197 Level     ee100000.sd
100:      12828          0          0          0     GIC-0 199 Level     ee140000.sd
220:          0          0          0          0  e6053000.gpio   6 Edge      ee100000.sd cd
236:          0          0          0          0  e6053000.gpio  22 Edge      ee140000.sd cd

Without Cleanup
---------------

f2cd281b9f7d (mmc/next) mmc: sdhci-pci: Enable card detect wake for Intel BYT-related SD controllers

# dmesg | egrep '(sd|mmc)'
[    2.310760] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    2.316185] sh_mobile_sdhi ee140000.sd: Got CD GPIO
[    2.375581] sh_mmcif ee220000.mmc: Chip version 0x0003, clock rate 12MHz
[    2.482371] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    2.695738] sh_mobile_sdhi ee100000.sd: mmc1 base at 0xee100000 max clock rate 195 MHz
[    2.704210] sh_mobile_sdhi ee140000.sd: Got CD GPIO
[    2.784707] mmc0: new high speed MMC card at address 0001
[    2.790501] mmcblk0: mmc0:0001 MMC08G 7.33 GiB
[    2.795219] mmcblk0boot0: mmc0:0001 MMC08G partition 1 2.00 MiB
[    2.804059] mmcblk0boot1: mmc0:0001 MMC08G partition 2 2.00 MiB
[    2.811731]  mmcblk0: p1
[    2.915727] sh_mobile_sdhi ee140000.sd: mmc2 base at 0xee140000 max clock rate 97 MHz
[    3.122796] mmc1: new ultra high speed SDR104 SDHC card at address 0001
[    3.129798] mmcblk1: mmc1:0001 00000 29.8 GiB
[    3.143603]  mmcblk1: p1
[    3.335704] mmc2: new ultra high speed SDR50 SDHC card at address 0001
[    3.342565] mmcblk2: mmc2:0001 00000 29.8 GiB
[    3.356510]  mmcblk2: p1

# grep sd /proc/interrupts
 99:        572          0          0          0     GIC-0 197 Level     ee100000.sd
100:        538          0          0          0     GIC-0 199 Level     ee140000.sd
220:          0          0          0          0  e6053000.gpio   6 Edge      ee100000.sd cd
236:          0          0          0          0  e6053000.gpio  22 Edge      ee140000.sd cd

# cat /sys/devices/platform/ee100000.sd/mmc_host/mmc1/mmc1:*/cid
1b534d303030303010ed85537600fc00
# dd if=/dev/mmcblk1 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 14.6023 s, 36.8 MB/s

# cat /sys/devices/platform/ee140000.sd/mmc_host/mmc2/mmc2:*/cid
1b534d303030303010f0c957f500fc00
# dd if=/dev/mmcblk2 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 18.8882 s, 28.4 MB/s

# grep sd /proc/interrupts
 99:      12860          0          0          0     GIC-0 197 Level     ee100000.sd
100:      12826          0          0          0     GIC-0 199 Level     ee140000.sd
220:          0          0          0          0  e6053000.gpio   6 Edge      ee100000.sd cd
236:          0          0          0          0  e6053000.gpio  22 Edge      ee140000.sd cd
