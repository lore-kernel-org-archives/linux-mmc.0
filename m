From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH mmc/next v3 0/4] mmc: renesas_sdhi: add support for R-Car Gen3 SDHI DMAC
Date: Wed, 21 Jun 2017 16:00:26 +0200
Message-ID: <1498053630-7780-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Hi,

this series adds support for the internal DMAC used by r8a779[56] SoCs.
This is achieved by adding a new variant of the SDHI driver for this
DMA controller with compat strings for the r8a779[56] SoCs.
Compat strings for these SoCs are also removed from the existing SYS DMAC
variant of the SDHI driver.

Based on mmc/next

Headline performance boost: 9.5MB/s -> 39.7MB/s
Details below.

Simon Horman (3):
  mmc: tmio, renesas-sdhi: add dataend to DMA ops
  mmc: renesas-sdhi: add support for R-Car Gen3 SDHI DMAC
  mmc: renesas-sdhi: remove gen3 support from SYS-DMAC driver

Yoshihiro Shimoda (1):
  mmc: tmio, renesas-sdhi: add max_{segs,blk_count} to tmio_mmc_data

 drivers/mmc/host/Kconfig                      |  19 ++
 drivers/mmc/host/Makefile                     |   8 +-
 drivers/mmc/host/renesas_sdhi.h               |   2 +
 drivers/mmc/host/renesas_sdhi_core.c          |   2 +
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 271 ++++++++++++++++++++++++++
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      |  29 +--
 drivers/mmc/host/tmio_mmc.h                   |   2 +
 drivers/mmc/host/tmio_mmc_core.c              |  16 +-
 include/linux/mfd/tmio.h                      |   2 +
 9 files changed, 323 insertions(+), 28 deletions(-)
 create mode 100644 drivers/mmc/host/renesas_sdhi_internal_dmac.c

-- 
2.1.4


Salvator-X/M3-W ES1.0
=====================

With Gen3 DMA Patches
---------------------

97ac7011f8d3 (topic/sdhi-gen3-dma-2017-v3) mmc: renesas-sdhi: remove gen3 support from SYS-DMAC driver

# dmesg | egrep '(sd|mmc)'
[    1.419150] sdhci: Secure Digital Host Controller Interface driver
[    1.425367] sdhci: Copyright(c) Pierre Ossman
[    1.430237] renesas_sdhi_internal_dmac ee100000.sd: Got CD GPIO
[    1.436224] renesas_sdhi_internal_dmac ee100000.sd: Got WP GPIO
[    1.564915] renesas_sdhi_internal_dmac ee140000.sd: mmc0 base at 0xee140000 max clock rate 200 MHz
[    1.574277] renesas_sdhi_internal_dmac ee160000.sd: Got CD GPIO
[    1.580250] renesas_sdhi_internal_dmac ee160000.sd: Got WP GPIO
[    1.595002] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.643641] renesas_sdhi_internal_dmac ee100000.sd: Got CD GPIO
[    1.649678] renesas_sdhi_internal_dmac ee100000.sd: Got WP GPIO
[    1.780987] renesas_sdhi_internal_dmac ee100000.sd: mmc1 base at 0xee100000 max clock rate 200 MHz
[    1.791301] renesas_sdhi_internal_dmac ee160000.sd: Got CD GPIO
[    1.797269] renesas_sdhi_internal_dmac ee160000.sd: Got WP GPIO
[    1.830209] mmc0: new high speed MMC card at address 0001
[    1.836044] mmcblk0: mmc0:0001 eMMC   28.8 GiB 
[    1.844818] mmcblk0boot0: mmc0:0001 eMMC   partition 1 4.00 MiB
[    1.854940] mmcblk0boot1: mmc0:0001 eMMC   partition 2 4.00 MiB
[    1.866738] mmcblk0rpmb: mmc0:0001 eMMC   partition 3 4.00 MiB
[    1.877064]  mmcblk0: p1
[    1.933007] renesas_sdhi_internal_dmac ee160000.sd: mmc2 base at 0xee160000 max clock rate 200 MHz
[    2.080957] mmc1: new ultra high speed SDR50 SDHC card at address e624
[    2.087962] mmcblk1: mmc1:e624 SU08G 7.40 GiB 
[    2.103240]  mmcblk1: p1
[    2.188956] mmc2: new ultra high speed SDR50 SDHC card at address 0001
[    2.195833] mmcblk2: mmc2:0001 00000 29.8 GiB 
[    2.209999]  mmcblk2: p1

# grep sd /proc/interrupts
100:        396          0     GIC-0 197 Level     ee100000.sd
101:        676          0     GIC-0 199 Level     ee140000.sd
102:        394          0     GIC-0 200 Level     ee160000.sd
178:          0          0  e6053000.gpio  12 Edge      ee100000.sd cd
197:          0          0  e6054000.gpio  15 Edge      ee160000.sd cd

# cat /sys/devices/platform/soc/ee100000.sd/mmc_host/mmc1/mmc1:*/cid
035344535530384780b1b8a11200d300
# dd if=/dev/mmcblk1 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 13.4726 s, 39.8 MB/s
# dd if=/dev/urandom of=/dev/mmcblk1 bs=1M count=512 oflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 25.1835 s, 21.3 MB/s
# dd if=/dev/zero of=/dev/mmcblk1 bs=1M count=512 oflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 20.9813 s, 25.6 MB/s

# cat /sys/devices/platform/soc/ee160000.sd/mmc_host/mmc2/mmc2:*/cid
1b534d3030303030103916141700f600
# dd if=/dev/mmcblk2 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 17.4752 s, 30.7 MB/s
# dd if=/dev/urandom of=/dev/mmcblk2 bs=1M count=512 oflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 25.9727 s, 20.7 MB/s
# dd if=/dev/zero of=/dev/mmcblk2 bs=1M count=512 oflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 21.4667 s, 25.0 MB/s

# grep sd /proc/interrupts
100:      90886          0     GIC-0 197 Level     ee100000.sd
101:        676          0     GIC-0 199 Level     ee140000.sd
102:      90884          0     GIC-0 200 Level     ee160000.sd
178:          0          0  e6053000.gpio  12 Edge      ee100000.sd cd
197:          0          0  e6054000.gpio  15 Edge      ee160000.sd cd

Without Gen3 DMA Patches
------------------------

2fe35968fecc (mmc/next) mmc: renesas-sdhi: improve checkpatch cleanness

# dmesg | egrep '(sd|mmc)'
[    1.415665] sdhci: Secure Digital Host Controller Interface driver
[    1.421875] sdhci: Copyright(c) Pierre Ossman
[    1.426803] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    1.431720] sh_mobile_sdhi ee100000.sd: Got WP GPIO
[    1.560977] sh_mobile_sdhi ee140000.sd: mmc0 base at 0xee140000 max clock rate 200 MHz
[    1.569334] sh_mobile_sdhi ee160000.sd: Got CD GPIO
[    1.574274] sh_mobile_sdhi ee160000.sd: Got WP GPIO
[    1.588023] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.637177] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    1.642138] sh_mobile_sdhi ee100000.sd: Got WP GPIO
[    1.769034] sh_mobile_sdhi ee100000.sd: mmc1 base at 0xee100000 max clock rate 200 MHz
[    1.778299] sh_mobile_sdhi ee160000.sd: Got CD GPIO
[    1.783226] sh_mobile_sdhi ee160000.sd: Got WP GPIO
[    1.838282] mmc0: new high speed MMC card at address 0001
[    1.848093] mmcblk0: mmc0:0001 eMMC   28.8 GiB 
[    1.856812] mmcblk0boot0: mmc0:0001 eMMC   partition 1 4.00 MiB
[    1.866898] mmcblk0boot1: mmc0:0001 eMMC   partition 2 4.00 MiB
[    1.876978] mmcblk0rpmb: mmc0:0001 eMMC   partition 3 4.00 MiB
[    1.886453]  mmcblk0: p1
[    1.909059] sh_mobile_sdhi ee160000.sd: mmc2 base at 0xee160000 max clock rate 200 MHz
[    2.085013] mmc1: new ultra high speed SDR50 SDHC card at address e624
[    2.096042] mmcblk1: mmc1:e624 SU08G 7.40 GiB 
[    2.225010] mmc2: new ultra high speed SDR50 SDHC card at address 0001
[    2.231895] mmcblk2: mmc2:0001 00000 29.8 GiB 

# grep sd /proc/interrupts
100:       1156          0     GIC-0 197 Level     ee100000.sd
101:       2980          0     GIC-0 199 Level     ee140000.sd
102:       1158          0     GIC-0 200 Level     ee160000.sd
178:          0          0  e6053000.gpio  12 Edge      ee100000.sd cd
197:          0          0  e6054000.gpio  15 Edge      ee160000.sd cd

# cat /sys/devices/platform/soc/ee100000.sd/mmc_host/mmc1/mmc1:*/cid
035344535530384780b1b8a11200d300
# dd if=/dev/mmcblk1 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 56.9853 s, 9.4 MB/s
# dd if=/dev/urandom of=/dev/mmcblk1 bs=1M count=512 oflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 33.6495 s, 16.0 MB/s
(run twice)
# dd if=/dev/zero of=/dev/mmcblk1 bs=1M count=512 oflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 28.9672 s, 18.5 MB/s

# cat /sys/devices/platform/soc/ee160000.sd/mmc_host/mmc2/mmc2:*/cid
1b534d3030303030103916141700f600
# dd if=/dev/mmcblk2 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 56.6979 s, 9.5 MB/s
# dd if=/dev/urandom of=/dev/mmcblk2 bs=1M count=512 oflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 32.6627 s, 16.4 MB/s
# dd if=/dev/zero of=/dev/mmcblk2 bs=1M count=512 oflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 28.0254 s, 19.2 MB/s

# grep sd /proc/interrupts
100:    4260209          0     GIC-0 197 Level     ee100000.sd
101:       2980          0     GIC-0 199 Level     ee140000.sd
102:    3194148          0     GIC-0 200 Level     ee160000.sd
178:          0          0  e6053000.gpio  12 Edge      ee100000.sd cd
197:          0          0  e6054000.gpio  15 Edge      ee160000.sd cd


Lager/H2 ES2.0
==============

With Gen3 DMA Patches
---------------------

97ac7011f8d3 (topic/sdhi-gen3-dma-2017-v3) mmc: renesas-sdhi: remove gen3 support from SYS-DMAC driver

# dmesg | egrep '(sd|mmc)'
[    2.310666] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    2.316097] sh_mobile_sdhi ee140000.sd: Got CD GPIO
[    2.375103] sh_mmcif ee220000.mmc: Chip version 0x0003, clock rate 12MHz
[    2.481791] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    2.695235] sh_mobile_sdhi ee100000.sd: mmc1 base at 0xee100000 max clock rate 195 MHz
[    2.703702] sh_mobile_sdhi ee140000.sd: Got CD GPIO
[    2.783372] mmc0: new high speed MMC card at address 0001
[    2.789193] mmcblk0: mmc0:0001 MMC08G 7.33 GiB 
[    2.793912] mmcblk0boot0: mmc0:0001 MMC08G partition 1 2.00 MiB
[    2.800052] mmcblk0boot1: mmc0:0001 MMC08G partition 2 2.00 MiB
[    2.807724]  mmcblk0: p1
[    2.915243] sh_mobile_sdhi ee140000.sd: mmc2 base at 0xee140000 max clock rate 97 MHz
[    3.152305] mmc1: new ultra high speed SDR104 SDHC card at address 0001
[    3.159305] mmcblk1: mmc1:0001 00000 29.8 GiB 
[    3.395217] mmc2: new ultra high speed SDR50 SDHC card at address 0001
[    3.402084] mmcblk2: mmc2:0001 00000 29.8 GiB 

# grep sd /proc/interrupts
 99:        325          0          0          0     GIC-0 197 Level     ee100000.sd
100:        295          0          0          0     GIC-0 199 Level     ee140000.sd
220:          0          0          0          0  e6053000.gpio   6 Edge      ee100000.sd cd
236:          0          0          0          0  e6053000.gpio  22 Edge      ee140000.sd cd

# cat /sys/devices/platform/ee100000.sd/mmc_host/mmc1/mmc1:*/cid
1b534d303030303010ed85537600fc00
# dd if=/dev/mmcblk1 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 10.7666 s, 49.9 MB/s
# dd if=/dev/urandom of=/dev/mmcblk1 bs=1M count=512 oflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 25.6582 s, 20.9 MB/s
# dd if=/dev/zero of=/dev/mmcblk1 bs=1M count=512 oflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 16.8331 s, 31.9 MB/s

# cat /sys/devices/platform/ee140000.sd/mmc_host/mmc2/mmc2:*/cid
1b534d303030303010f0c957f500fc00
# dd if=/dev/mmcblk2 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 15.2234 s, 35.3 MB/s
# dd if=/dev/urandom of=/dev/mmcblk2 bs=1M count=512 oflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 30.2048 s, 17.8 MB/s
# dd if=/dev/zero of=/dev/mmcblk2 bs=1M count=512 oflag=direct
536870912 bytes (537 MB) copied, 21.3844 s, 25.1 MB/s

# grep sd /proc/interrupts
 99:      45879          0          0          0     GIC-0 197 Level     ee100000.sd
100:      45849          0          0          0     GIC-0 199 Level     ee140000.sd
220:          0          0          0          0  e6053000.gpio   6 Edge      ee100000.sd cd
236:          0          0          0          0  e6053000.gpio  22 Edge      ee140000.sd cd
 99:      46126          0          0          0     GIC-0 197 Level     ee100000.sd
100:      52421          0          0          0     GIC-0 199 Level     ee140000.sd
220:          0          0          0          0  e6053000.gpio   6 Edge      ee100000.sd cd
236:          0          0          0          0  e6053000.gpio  22 Edge      ee140000.sd cd

Without Gen3 DMA Patches
------------------------

2fe35968fecc (mmc/next) mmc: renesas-sdhi: improve checkpatch cleanness

# dmesg | egrep '(sd|mmc)'
[    2.311173] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    2.316724] sh_mobile_sdhi ee140000.sd: Got CD GPIO
[    2.375572] sh_mmcif ee220000.mmc: Chip version 0x0003, clock rate 12MHz
[    2.482393] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    2.695672] sh_mobile_sdhi ee100000.sd: mmc1 base at 0xee100000 max clock rate 195 MHz
[    2.704159] sh_mobile_sdhi ee140000.sd: Got CD GPIO
[    2.773784] mmc0: new high speed MMC card at address 0001
[    2.779592] mmcblk0: mmc0:0001 MMC08G 7.33 GiB 
[    2.784311] mmcblk0boot0: mmc0:0001 MMC08G partition 1 2.00 MiB
[    2.790422] mmcblk0boot1: mmc0:0001 MMC08G partition 2 2.00 MiB
[    2.798127]  mmcblk0: p1
[    2.915668] sh_mobile_sdhi ee140000.sd: mmc2 base at 0xee140000 max clock rate 97 MHz
[    3.172995] mmc1: new ultra high speed SDR104 SDHC card at address 0001
[    3.179996] mmcblk1: mmc1:0001 00000 29.8 GiB 
[    3.305653] mmc2: new ultra high speed SDR50 SDHC card at address 0001
[    3.314303] mmcblk2: mmc2:0001 00000 29.8 GiB 

# grep sd /proc/interrupts
 99:        327          0          0          0     GIC-0 197 Level     ee100000.sd
100:        289          0          0          0     GIC-0 199 Level     ee140000.sd
220:          0          0          0          0  e6053000.gpio   6 Edge      ee100000.sd cd
236:          0          0          0          0  e6053000.gpio  22 Edge      ee140000.sd cd

# cat /sys/devices/platform/ee100000.sd/mmc_host/mmc1/mmc1:*/cid
1b534d303030303010ed85537600fc00
# dd if=/dev/mmcblk1 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 10.8066 s, 49.7 MB/s
# dd if=/dev/urandom of=/dev/mmcblk1 bs=1M count=512 oflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 25.8626 s, 20.8 MB/s
# dd if=/dev/zero of=/dev/mmcblk1 bs=1M count=512 oflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 16.8923 s, 31.8 MB/s

# cat /sys/devices/platform/ee140000.sd/mmc_host/mmc2/mmc2:*/cid
1b534d303030303010f0c957f500fc00
# dd if=/dev/mmcblk2 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 15.2994 s, 35.1 MB/s
# dd if=/dev/urandom of=/dev/mmcblk2 bs=1M count=512 oflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 30.2488 s, 17.7 MB/s
# dd if=/dev/zero of=/dev/mmcblk2 bs=1M count=512 oflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 21.3787 s, 25.1 MB/s

# grep sd /proc/interrupts
 99:      45881          0          0          0     GIC-0 197 Level     ee100000.sd
100:      45843          0          0          0     GIC-0 199 Level     ee140000.sd
220:          0          0          0          0  e6053000.gpio   6 Edge      ee100000.sd cd
236:          0          0          0          0  e6053000.gpio  22 Edge      ee140000.sd cd
