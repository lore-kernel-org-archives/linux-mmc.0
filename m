From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v2 0/6] mmc: renesas-sdhi: refactor DMA support
Date: Wed, 10 May 2017 11:25:24 +0200
Message-ID: <1494408330-28161-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram, Hi Ulf, Hi Arnd, Hi all,

the intention of this patch-set is to refactor the DMA support in
the Renesas SDHI driver in order to make it easier to add support
for using the SDHI hardware with different DMA implementations.

This is based on earlier work, posted as "[PATCH/RFC v3 0/6] mmc:
renesas_sdhi: add R-Car Gen-3 DMA support". It attempts to implement
the reworking of the driver proposed by Arnd[1] in his review of that
patch-set.

[1] http://www.spinics.net/lists/linux-mmc/msg38004.html

Unlike that patch-set this patch-set does not add support for
R-Car Gen-3 DMA. Rather it focuses on refactoring the code.

Changes between RFC and v2:

* Drop filenames from comment at top of source
* Consistently check for if (host->dma_ops) before using dma_ops.


Simon Horman (6):
  mmc: tmio: drop filenames from comment at top of source
  mmc: renesas-sdhi, tmio: make dma more modular
  mmc: tmio: rename tmio_mmc_{pio => core}.c
  mmc: renesas-sdhi: rename tmio_mmc_dma.c => renesas_sdhi_sys_dmac.c
  mmc: renesas-sdhi: rename sh_mobile_sdhi.c => renesas_sdhi_core.c
  mmc: renesas-sdhi: make renesas_sdhi_sys_dmac main module file

 drivers/mmc/host/Kconfig                           |   4 +-
 drivers/mmc/host/Makefile                          |   4 +-
 drivers/mmc/host/renesas_sdhi.h                    |  39 ++++
 .../host/{sh_mobile_sdhi.c => renesas_sdhi_core.c} | 229 +++++----------------
 .../{tmio_mmc_dma.c => renesas_sdhi_sys_dmac.c}    | 164 +++++++++++++--
 drivers/mmc/host/tmio_mmc.c                        |  10 +-
 drivers/mmc/host/tmio_mmc.h                        |  53 ++---
 .../mmc/host/{tmio_mmc_pio.c => tmio_mmc_core.c}   |  51 ++++-
 8 files changed, 304 insertions(+), 250 deletions(-)
 create mode 100644 drivers/mmc/host/renesas_sdhi.h
 rename drivers/mmc/host/{sh_mobile_sdhi.c => renesas_sdhi_core.c} (68%)
 rename drivers/mmc/host/{tmio_mmc_dma.c => renesas_sdhi_sys_dmac.c} (58%)
 rename drivers/mmc/host/{tmio_mmc_pio.c => tmio_mmc_core.c} (97%)


The following data was collected when running some basic tests to check for
regressions introduced by this patchset. None were observed.


With patchset
=============

r8a7796/Salvator-X
------------------

# dmesg | egrep '(mmc|sd)'
[    1.238331] sdhci: Secure Digital Host Controller Interface driver
[    1.245342] sdhci: Copyright(c) Pierre Ossman
[    1.250351] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    1.255490] sh_mobile_sdhi ee100000.sd: Got WP GPIO
[    1.384901] sh_mobile_sdhi ee140000.sd: mmc0 base at 0xee140000 max clock rate 200 MHz
[    1.393232] sh_mobile_sdhi ee160000.sd: Got CD GPIO
[    1.398171] sh_mobile_sdhi ee160000.sd: Got WP GPIO
[    1.409884] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.463047] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    1.468438] sh_mobile_sdhi ee100000.sd: Got WP GPIO
[    1.596969] sh_mobile_sdhi ee100000.sd: mmc1 base at 0xee100000 max clock rate 200 MHz
[    1.606120] sh_mobile_sdhi ee160000.sd: Got CD GPIO
[    1.611045] sh_mobile_sdhi ee160000.sd: Got WP GPIO
[    1.670227] mmc0: new high speed MMC card at address 0001
[    1.680019] mmcblk0: mmc0:0001 eMMC   28.8 GiB
[    1.688712] mmcblk0boot0: mmc0:0001 eMMC   partition 1 4.00 MiB
[    1.698770] mmcblk0boot1: mmc0:0001 eMMC   partition 2 4.00 MiB
[    1.708302]  mmcblk0: p1
[    1.736993] sh_mobile_sdhi ee160000.sd: mmc2 base at 0xee160000 max clock rate 200 MHz
[    1.892948] mmc1: new ultra high speed SDR50 SDHC card at address e624
[    1.903919] mmcblk1: mmc1:e624 SU08G 7.40 GiB
[    1.919446]  mmcblk1: p1
[    2.012943] mmc2: new ultra high speed SDR50 SDHC card at address 0001
[    2.023797] mmcblk2: mmc2:0001 00000 29.8 GiB
[    2.038384]  mmcblk2: p1

# grep sd /proc/interrupts
 92:       2163     GIC-0 197 Level     ee100000.sd
 93:       2823     GIC-0 199 Level     ee140000.sd
 94:       2163     GIC-0 200 Level     ee160000.sd
170:          0  e6053000.gpio  12 Edge      ee100000.sd cd
189:          0  e6054000.gpio  15 Edge      ee160000.sd cd

# cat /sys/devices/platform/soc/ee140000.sd/mmc_host/mmc0/mmc0:0001/cid
89010a654d4d4320200126140246b200
# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 56.1146 s, 9.6 MB/s

# cat /sys/devices/platform/soc/ee100000.sd/mmc_host/mmc1/mmc1:e624/cid
035344535530384780b1b8a11200d300
# dd if=/dev/mmcblk1 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 56.6648 s, 9.5 MB/s

# cat /sys/devices/platform/soc/ee160000.sd/mmc_host/mmc2/mmc2:0001/cid
1b534d3030303030103916141700f600
# dd if=/dev/mmcblk2 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 56.6475 s, 9.5 MB/s

r8a7795/Lager
-------------

# dmesg | egrep '(mmc|sd)'
[    2.280660] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    2.286122] sh_mobile_sdhi ee140000.sd: Got CD GPIO
[    2.345125] sh_mmcif ee220000.mmc: Chip version 0x0003, clock rate 12MHz
[    2.539393] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    2.745265] sh_mobile_sdhi ee100000.sd: mmc1 base at 0xee100000 max clock rate 195 MHz
[    2.753832] sh_mobile_sdhi ee140000.sd: Got CD GPIO
[    2.762714] mmc0: new high speed MMC card at address 0001
[    2.768598] mmcblk0: mmc0:0001 MMC08G 7.33 GiB
[    2.773382] mmcblk0boot0: mmc0:0001 MMC08G partition 1 2.00 MiB
[    2.779583] mmcblk0boot1: mmc0:0001 MMC08G partition 2 2.00 MiB
[    2.787500]  mmcblk0: p1
[    2.965271] sh_mobile_sdhi ee140000.sd: mmc2 base at 0xee140000 max clock rate 97 MHz
[    3.242325] mmc1: new ultra high speed SDR104 SDHC card at address 0001
[    3.253457] mmcblk1: mmc1:0001 00000 29.8 GiB
[    3.271452]  mmcblk1: p1
[    3.435245] mmc2: new ultra high speed SDR50 SDHC card at address 0001
[    3.446197] mmcblk2: mmc2:0001 00000 29.8 GiB
[    3.464177]  mmcblk2: p1

# grep sd /proc/interrupts
 99:        409          0          0          0     GIC-0 197 Level     ee100000.sd
100:        377          0          0          0     GIC-0 199 Level     ee140000.sd
220:          0          0          0          0  e6053000.gpio   6 Edge      ee100000.sd cd
236:          0          0          0          0  e6053000.gpio  22 Edge      ee140000.sd cd

# cat /sys/devices/platform/ee100000.sd/mmc_host/mmc1/mmc1:0001/cid
1b534d303030303010ed85537600fc00
# dd if=/dev/mmcblk1 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 14.5744 s, 36.8 MB/s

# cat /sys/devices/platform/ee140000.sd/mmc_host/mmc2/mmc2:0001/cid
1b534d303030303010f0c957f500fc00
# dd if=/dev/mmcblk2 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 18.9365 s, 28.4 MB/s

Base: mmc-v4.12
===============

r8a7796/Salvator-X
------------------

# dmesg | egrep '(mmc|sd)'
[    1.238302] sdhci: Secure Digital Host Controller Interface driver
[    1.245286] sdhci: Copyright(c) Pierre Ossman
[    1.250318] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    1.255493] sh_mobile_sdhi ee100000.sd: Got WP GPIO
[    1.385009] sh_mobile_sdhi ee140000.sd: mmc0 base at 0xee140000 max clock rate 200 MHz
[    1.393345] sh_mobile_sdhi ee160000.sd: Got CD GPIO
[    1.398282] sh_mobile_sdhi ee160000.sd: Got WP GPIO
[    1.410036] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.463947] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    1.469413] sh_mobile_sdhi ee100000.sd: Got WP GPIO
[    1.597087] sh_mobile_sdhi ee100000.sd: mmc1 base at 0xee100000 max clock rate 200 MHz
[    1.606308] sh_mobile_sdhi ee160000.sd: Got CD GPIO
[    1.611234] sh_mobile_sdhi ee160000.sd: Got WP GPIO
[    1.670327] mmc0: new high speed MMC card at address 0001
[    1.680135] mmcblk0: mmc0:0001 eMMC   28.8 GiB
[    1.688830] mmcblk0boot0: mmc0:0001 eMMC   partition 1 4.00 MiB
[    1.698891] mmcblk0boot1: mmc0:0001 eMMC   partition 2 4.00 MiB
[    1.708459]  mmcblk0: p1
[    1.737104] sh_mobile_sdhi ee160000.sd: mmc2 base at 0xee160000 max clock rate 200 MHz
[    1.893053] mmc1: new ultra high speed SDR50 SDHC card at address e624
[    1.904063] mmcblk1: mmc1:e624 SU08G 7.40 GiB
[    1.919680]  mmcblk1: p1
[    2.013047] mmc2: new ultra high speed SDR50 SDHC card at address 0001
[    2.023909] mmcblk2: mmc2:0001 00000 29.8 GiB
[    2.038490]  mmcblk2: p1

# grep sd /proc/interrupts
 92:       2163     GIC-0 197 Level     ee100000.sd
 93:       2827     GIC-0 199 Level     ee140000.sd
 94:       2163     GIC-0 200 Level     ee160000.sd
170:          0  e6053000.gpio  12 Edge      ee100000.sd cd
189:          0  e6054000.gpio  15 Edge      ee160000.sd cd

# cat /sys/devices/platform/soc/ee140000.sd/mmc_host/mmc0/mmc0:0001/cid
89010a654d4d4320200126140246b200
# dd if=/dev/mmcblk0 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 56.4546 s, 9.5 MB/s

# cat /sys/devices/platform/soc/ee100000.sd/mmc_host/mmc1/mmc1:e624/cid
035344535530384780b1b8a11200d300
# dd if=/dev/mmcblk1 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 56.6084 s, 9.5 MB/s

r8a7795/Lager
-------------

# dmesg | egrep '(mmc|sd)'
[    2.280766] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    2.286258] sh_mobile_sdhi ee140000.sd: Got CD GPIO
[    2.345162] sh_mmcif ee220000.mmc: Chip version 0x0003, clock rate 12MHz
[    2.539525] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    2.742755] mmc0: new high speed MMC card at address 0001
[    2.745317] sh_mobile_sdhi ee100000.sd: mmc1 base at 0xee100000 max clock rate 195 MHz
[    2.745853] sh_mobile_sdhi ee140000.sd: Got CD GPIO
[    2.761659] mmcblk0: mmc0:0001 MMC08G 7.33 GiB
[    2.766462] mmcblk0boot0: mmc0:0001 MMC08G partition 1 2.00 MiB
[    2.772646] mmcblk0boot1: mmc0:0001 MMC08G partition 2 2.00 MiB
[    2.780416]  mmcblk0: p1
[    2.955295] sh_mobile_sdhi ee140000.sd: mmc2 base at 0xee140000 max clock rate 97 MHz
[    3.232405] mmc1: new ultra high speed SDR104 SDHC card at address 0001
[    3.243560] mmcblk1: mmc1:0001 00000 29.8 GiB
[    3.261565]  mmcblk1: p1
[    3.425284] mmc2: new ultra high speed SDR50 SDHC card at address 0001
[    3.436272] mmcblk2: mmc2:0001 00000 29.8 GiB
[    3.454263]  mmcblk2: p1

# grep sd /proc/interrupts
 99:        409          0          0          0     GIC-0 197 Level     ee100000.sd
100:        377          0          0          0     GIC-0 199 Level     ee140000.sd
220:          0          0          0          0  e6053000.gpio   6 Edge      ee100000.sd cd
236:          0          0          0          0  e6053000.gpio  22 Edge      ee140000.sd cd

# cat /sys/devices/platform/ee100000.sd/mmc_host/mmc1/mmc1:0001/cid
1b534d303030303010ed85537600fc00
# dd if=/dev/mmcblk1 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 14.5339 s, 36.9 MB/s
# cat /sys/devices/platform/ee140000.sd/mmc_host/mmc2/mmc2:0001/cid
1b534d303030303010f0c957f500fc0000.sd/mmc_host/mmc2/mmc2:0001/cid

# cat /sys/devices/platform/ee140000.sd/mmc_host/mmc2/mmc2:0001/cid
1b534d303030303010f0c957f500fc00
# dd if=/dev/mmcblk2 of=/dev/null bs=1M count=512 iflag=direct
512+0 records in
512+0 records out
536870912 bytes (537 MB) copied, 18.9352 s, 28.4 MB/s
