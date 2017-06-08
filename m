From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH/RFC 0/5 repost] mmc: renesas_sdhi: add support for R-Car Gen3 SDHI DMAC
Date: Thu,  8 Jun 2017 15:13:10 +0200
Message-ID: <1496927595-19521-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:60503 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbdFHNNd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2017 09:13:33 -0400
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
More run-time information below.

Simon Horman (4):
  mmc: sh_mobile_sdhi: set max_segs and max_blk_count values R-Car Gen3
  mmc: tmio: add complete to DMA ops
  mmc: renesas_sdhi: add support for R-Car Gen3 SDHI DMAC
  mmc: renesas-sdhi: remove gen3 support from sysc dmac driver

Yoshihiro Shimoda (1):
  mmc: tmio: add max_segs and max_blk_count in tmio_mmc_data

 drivers/mmc/host/Kconfig                      |  17 ++
 drivers/mmc/host/Makefile                     |   8 +-
 drivers/mmc/host/renesas_sdhi.h               |   2 +
 drivers/mmc/host/renesas_sdhi_core.c          |   2 +
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 275 ++++++++++++++++++++++++++
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      |  23 +--
 drivers/mmc/host/tmio_mmc.h                   |   2 +
 drivers/mmc/host/tmio_mmc_core.c              |  16 +-
 include/linux/mfd/tmio.h                      |   2 +
 9 files changed, 319 insertions(+), 28 deletions(-)
 create mode 100644 drivers/mmc/host/renesas_sdhi_internal_dmac.c

-- 
2.1.4

M3-W ES1.0

fd9437fc8884 (topic/sdhi-gen3-dma-2017) mmc: renesas-sdhi: remove gen3 support from sysc dmac driver

# dmesg | egrep '(sd|mmc)'
[    1.412911] sdhci: Secure Digital Host Controller Interface driver
[    1.419120] sdhci: Copyright(c) Pierre Ossman
[    1.423990] renesas_sdhi_internal_dmac ee100000.sd: Got CD GPIO
[    1.429951] renesas_sdhi_internal_dmac ee100000.sd: Got WP GPIO
[    1.560503] renesas_sdhi_internal_dmac ee140000.sd: mmc0 base at 0xee140000 max clock rate 200 MHz
[    1.569871] renesas_sdhi_internal_dmac ee160000.sd: Got CD GPIO
[    1.575846] renesas_sdhi_internal_dmac ee160000.sd: Got WP GPIO
[    1.590584] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.638687] renesas_sdhi_internal_dmac ee100000.sd: Got CD GPIO
[    1.644661] renesas_sdhi_internal_dmac ee100000.sd: Got WP GPIO
[    1.772556] renesas_sdhi_internal_dmac ee100000.sd: mmc1 base at 0xee100000 max clock rate 200 MHz
[    1.782613] renesas_sdhi_internal_dmac ee160000.sd: Got CD GPIO
[    1.788580] renesas_sdhi_internal_dmac ee160000.sd: Got WP GPIO
[    1.842940] mmc0: new high speed MMC card at address 0001
[    1.852857] mmcblk0: mmc0:0001 eMMC   28.8 GiB
[    1.857624] mmcblk0boot0: mmc0:0001 eMMC   partition 1 4.00 MiB
[    1.867734] mmcblk0boot1: mmc0:0001 eMMC   partition 2 4.00 MiB
[    1.877858] mmcblk0rpmb: mmc0:0001 eMMC   partition 3 4.00 MiB
[    1.887028]  mmcblk0: p1
[    1.916589] renesas_sdhi_internal_dmac ee160000.sd: mmc2 base at 0xee160000 max clock rate 200 MHz
[    2.060534] mmc1: new ultra high speed SDR50 SDHC card at address e624
[    2.071600] mmcblk1: mmc1:e624 SU08G 7.40 GiB
[    2.086875]  mmcblk1: p1
[    2.260532] mmc2: new ultra high speed SDR50 SDHC card at address 0001
[    2.267407] mmcblk2: mmc2:0001 00000 29.8 GiB
[    2.281572]  mmcblk2: p1

# grep sd /proc/interrupts
100:      24972          0     GIC-0 197 Level     ee100000.sd
101:        604          0     GIC-0 199 Level     ee140000.sd
102:      24980          0     GIC-0 200 Level     ee160000.sd
178:          0          0  e6053000.gpio  12 Edge      ee100000.sd cd
197:          0          0  e6054000.gpio  15 Edge      ee160000.sd cd

# cat /sys/devices/platform/soc/ee100000.sd/mmc_host/mmc1/mmc1:e624
035344535530384780b1b8a11200d300
# dd if=/dev/mmcblk1 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 13.5376 s, 39.7 MB/s

# cat /sys/devices/platform/soc/ee160000.sd/mmc_host/mmc2/mmc2:0001
1b534d3030303030103916141700f600
# dd if=/dev/mmcblk2 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 17.5562 s, 30.6 MB/s

# grep sd /proc/interrupts
100:      49548          0     GIC-0 197 Level     ee100000.sd
101:        604          0     GIC-0 199 Level     ee140000.sd
102:      49556          0     GIC-0 200 Level     ee160000.sd
178:          0          0  e6053000.gpio  12 Edge      ee100000.sd cd
197:          0          0  e6054000.gpio  15 Edge      ee160000.sd cd

-----------------------

6e75316c15df (mmc/next) mmc: tmio: make sure SDIO gets reinitialized after resume

# dmesg | egrep '(sd|mmc)'
[    1.428112] sdhci: Secure Digital Host Controller Interface driver
[    1.434620] sdhci: Copyright(c) Pierre Ossman
[    1.439831] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    1.444764] sh_mobile_sdhi ee100000.sd: Got WP GPIO
[    1.571160] sh_mobile_sdhi ee140000.sd: mmc0 base at 0xee140000 max clock rate 200 MHz
[    1.579496] sh_mobile_sdhi ee160000.sd: Got CD GPIO
[    1.584434] sh_mobile_sdhi ee160000.sd: Got WP GPIO
[    1.598138] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.647916] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    1.652857] sh_mobile_sdhi ee100000.sd: Got WP GPIO
[    1.779234] sh_mobile_sdhi ee100000.sd: mmc1 base at 0xee100000 max clock rate 200 MHz
[    1.788368] sh_mobile_sdhi ee160000.sd: Got CD GPIO
[    1.793300] sh_mobile_sdhi ee160000.sd: Got WP GPIO
[    1.832493] mmc0: new high speed MMC card at address 0001
[    1.842368] mmcblk0: mmc0:0001 eMMC   28.8 GiB
[    1.851133] mmcblk0boot0: mmc0:0001 eMMC   partition 1 4.00 MiB
[    1.857245] mmcblk0boot1: mmc0:0001 eMMC   partition 2 4.00 MiB
[    1.867323] mmcblk0rpmb: mmc0:0001 eMMC   partition 3 4.00 MiB
[    1.876809]  mmcblk0: p1
[    1.919252] sh_mobile_sdhi ee160000.sd: mmc2 base at 0xee160000 max clock rate 200 MHz
[    2.063208] mmc1: new ultra high speed SDR50 SDHC card at address e624
[    2.074300] mmcblk1: mmc1:e624 SU08G 7.40 GiB
[    2.089887]  mmcblk1: p1
[    2.263192] mmc2: new ultra high speed SDR50 SDHC card at address 0001
[    2.270073] mmcblk2: mmc2:0001 00000 29.8 GiB
[    2.284583]  mmcblk2: p1

# grep sd /proc/interrupts
100:       2276          0     GIC-0 197 Level     ee100000.sd
101:       3040          0     GIC-0 199 Level     ee140000.sd
102:       2284          0     GIC-0 200 Level     ee160000.sd
178:          0          0  e6053000.gpio  12 Edge      ee100000.sd cd
197:          0          0  e6054000.gpio  15 Edge      ee160000.sd cd

# cat /sys/devices/platform/soc/ee100000.sd/mmc_host/mmc1/mmc1:e624 
035344535530384780b1b8a11200d300

# cat /sys/devices/platform/soc/ee160000.sd/mmc_host/mmc2/mmc2:0001 
1b534d3030303030103916141700f600
# dd if=/dev/mmcblk2 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 56.7809 s, 9.5 MB/s

# grep sd /proc/interrupts
100:       2276          0     GIC-0 197 Level     ee100000.sd
101:       3040          0     GIC-0 199 Level     ee140000.sd
102:    2124012          0     GIC-0 200 Level     ee160000.sd
178:          0          0  e6053000.gpio  12 Edge      ee100000.sd cd
197:          0          0  e6054000.gpio  15 Edge      ee160000.sd cd
