From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH mmc/next v2 0/4] mmc: renesas_sdhi: add support for R-Car Gen3 SDHI DMAC
Date: Fri, 16 Jun 2017 11:58:50 +0200
Message-ID: <1497607134-10241-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:45944 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753409AbdFPJ7K (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jun 2017 05:59:10 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

Hi,

this series adds support for the internal DMAC used by r8a779[56] SoCs.
This is achieved by adding a new variant of the SDHI driver for this
DMA controller with compat strings for the r8a779[56] SoCs.
Compat strings for these SoCs are also removed from the existing SYS DMAC
variant of the SDHI driver.

Based on mmc/next

Headline performance boost: 9.5MB/s -> 39.7MB/s
Details below.

Changes since v1:
* Address review of v2 as noted in changelog of individual patches

Simon Horman (3):
  mmc: tmio, renesas-sdhi: add complete to DMA ops
  mmc: renesas-sdhi: add support for R-Car Gen3 SDHI DMAC
  mmc: renesas-sdhi: remove gen3 support from SYS-DMAC driver

Yoshihiro Shimoda (1):
  mmc: tmio, renesas-sdhi: add max_{segs,blk_count} to tmio_mmc_data

 drivers/mmc/host/Kconfig                      |  19 ++
 drivers/mmc/host/Makefile                     |   8 +-
 drivers/mmc/host/renesas_sdhi.h               |   2 +
 drivers/mmc/host/renesas_sdhi_core.c          |   2 +
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 275 ++++++++++++++++++++++++++
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      |  29 +--
 drivers/mmc/host/tmio_mmc.h                   |   2 +
 drivers/mmc/host/tmio_mmc_core.c              |  16 +-
 include/linux/mfd/tmio.h                      |   2 +
 9 files changed, 327 insertions(+), 28 deletions(-)
 create mode 100644 drivers/mmc/host/renesas_sdhi_internal_dmac.c

-- 
2.1.4

Salvator-X/M3-W ES1.0
=====================

With Gen3 DMA Patches
---------------------

f97c698336e1 (topic/sdhi-gen3-dma-2017-v2) mmc: renesas-sdhi: remove gen3 support from SYS-DMAC driver

# dmesg | egrep '(sd|mmc)'
[    1.415083] sdhci: Secure Digital Host Controller Interface driver
[    1.421291] sdhci: Copyright(c) Pierre Ossman
[    1.426164] renesas_sdhi_internal_dmac ee100000.sd: Got CD GPIO
[    1.432123] renesas_sdhi_internal_dmac ee100000.sd: Got WP GPIO
[    1.559507] renesas_sdhi_internal_dmac ee140000.sd: mmc0 base at 0xee140000 max clock rate 200 MHz
[    1.568922] renesas_sdhi_internal_dmac ee160000.sd: Got CD GPIO
[    1.574928] renesas_sdhi_internal_dmac ee160000.sd: Got WP GPIO
[    1.589703] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.638824] renesas_sdhi_internal_dmac ee100000.sd: Got CD GPIO
[    1.644806] renesas_sdhi_internal_dmac ee100000.sd: Got WP GPIO
[    1.771574] renesas_sdhi_internal_dmac ee100000.sd: mmc1 base at 0xee100000 max clock rate 200 MHz
[    1.781631] renesas_sdhi_internal_dmac ee160000.sd: Got CD GPIO
[    1.787624] renesas_sdhi_internal_dmac ee160000.sd: Got WP GPIO
[    1.844780] mmc0: new high speed MMC card at address 0001
[    1.851126] mmcblk0: mmc0:0001 eMMC   28.8 GiB
[    1.861040] mmcblk0boot0: mmc0:0001 eMMC   partition 1 4.00 MiB
[    1.871305] mmcblk0boot1: mmc0:0001 eMMC   partition 2 4.00 MiB
[    1.881414] mmcblk0rpmb: mmc0:0001 eMMC   partition 3 4.00 MiB
[    1.890595]  mmcblk0: p1
[    1.915609] renesas_sdhi_internal_dmac ee160000.sd: mmc2 base at 0xee160000 max clock rate 200 MHz
[    2.055552] mmc1: new ultra high speed SDR50 SDHC card at address e624
[    2.066569] mmcblk1: mmc1:e624 SU08G 7.40 GiB
[    2.081831]  mmcblk1: p1
[    2.275547] mmc2: new ultra high speed SDR50 SDHC card at address 0001
[    2.282419] mmcblk2: mmc2:0001 00000 29.8 GiB
[    2.296600]  mmcblk2: p1

# grep sd /proc/interrupts
100:        396          0     GIC-0 197 Level     ee100000.sd
101:        658          0     GIC-0 199 Level     ee140000.sd
102:        406          0     GIC-0 200 Level     ee160000.sd
178:          0          0  e6053000.gpio  12 Edge      ee100000.sd cd
197:          0          0  e6054000.gpio  15 Edge      ee160000.sd cd

# cat /sys/devices/platform/soc/ee100000.sd/mmc_host/mmc1/mmc1:*/cid
035344535530384780b1b8a11200d300
# dd if=/dev/mmcblk1 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 13.5498 s, 39.6 MB/s

# cat /sys/devices/platform/soc/ee160000.sd/mmc_host/mmc2/mmc2:*/cid
1b534d3030303030103916141700f600
# dd if=/dev/mmcblk2 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 17.5571 s, 30.6 MB/s

# grep sd /proc/interrupts
100:      24972          0     GIC-0 197 Level     ee100000.sd
101:        658          0     GIC-0 199 Level     ee140000.sd
102:      24982          0     GIC-0 200 Level     ee160000.sd
178:          0          0  e6053000.gpio  12 Edge      ee100000.sd cd
197:          0          0  e6054000.gpio  15 Edge      ee160000.sd cd

Without Gen3 DMA Patches
------------------------

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

With Gen3 DMA Patches
---------------------

f97c698336e1 (topic/sdhi-gen3-dma-2017-v2) mmc: renesas-sdhi: remove gen3 support from SYS-DMAC driver

# dmesg | egrep '(sd|mmc)'
[    2.311352] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    2.316918] sh_mobile_sdhi ee140000.sd: Got CD GPIO
[    2.375558] sh_mmcif ee220000.mmc: Chip version 0x0003, clock rate 12MHz
[    2.482338] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    2.695677] sh_mobile_sdhi ee100000.sd: mmc1 base at 0xee100000 max clock rate 195 MHz
[    2.704157] sh_mobile_sdhi ee140000.sd: Got CD GPIO
[    2.773828] mmc0: new high speed MMC card at address 0001
[    2.779650] mmcblk0: mmc0:0001 MMC08G 7.33 GiB
[    2.784388] mmcblk0boot0: mmc0:0001 MMC08G partition 1 2.00 MiB
[    2.790544] mmcblk0boot1: mmc0:0001 MMC08G partition 2 2.00 MiB
[    2.798218]  mmcblk0: p1
[    2.917476] sh_mobile_sdhi ee140000.sd: mmc2 base at 0xee140000 max clock rate 97 MHz
[    3.142783] mmc1: new ultra high speed SDR104 SDHC card at address 0001
[    3.149772] mmcblk1: mmc1:0001 00000 29.8 GiB
[    3.163596]  mmcblk1: p1
[    3.335665] mmc2: new ultra high speed SDR50 SDHC card at address 0001
[    3.342532] mmcblk2: mmc2:0001 00000 29.8 GiB
[    3.356495]  mmcblk2: p1

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
536870912 bytes (537 MB) copied, 14.5833 s, 36.8 MB/s

# cat /sys/devices/platform/ee140000.sd/mmc_host/mmc2/mmc2:*/cid
1b534d303030303010f0c957f500fc00
# dd if=/dev/mmcblk2 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 18.8682 s, 28.5 MB/s

(above dd for mmcblk2 was run twice)

# grep sd /proc/interrupts
 99:      12860          0          0          0     GIC-0 197 Level     ee100000.sd
100:      12828          0          0          0     GIC-0 199 Level     ee140000.sd
220:          0          0          0          0  e6053000.gpio   6 Edge      ee100000.sd cd
236:          0          0          0          0  e6053000.gpio  22 Edge      ee140000.sd cd

Without Gen3 DMA Patches
------------------------

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
