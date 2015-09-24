From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: All OMAP platforms: MMC is broken
Date: Thu, 24 Sep 2015 10:00:48 +0100
Message-ID: <20150924090048.GA21626@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:43689 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbbIXJA6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Sep 2015 05:00:58 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Nightly testing has revealed that both the OMAP3430 LDP and the OMAP4430
SDP fail to boot due to lack of working MMC.  Both platforms fail to
find their rootfs, which is on a SD card.

The breakage occurred somewhere between trees of September 9th (commit
4e4adb2f4628) and September 12th (commit b0a1ea51bda4), so during the
merge window.

Diffing those two trees show no changes to OMAP platform code, but
substantial changes in the MMC code:

 drivers/mmc/card/block.c                           |    17 +
 drivers/mmc/core/core.c                            |    46 +-
 drivers/mmc/core/host.c                            |    42 +-
 drivers/mmc/host/Kconfig                           |     8 +
 drivers/mmc/host/Makefile                          |     1 +
 drivers/mmc/host/android-goldfish.c                |     2 +-
 drivers/mmc/host/atmel-mci.c                       |     1 -
 drivers/mmc/host/dw_mmc-rockchip.c                 |     3 +
 drivers/mmc/host/dw_mmc.c                          |   284 +-
 drivers/mmc/host/omap.c                            |     9 +-
 drivers/mmc/host/omap_hsmmc.c                      |   347 +-
 drivers/mmc/host/pxamci.c                          |   200 +-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   114 +-
 drivers/mmc/host/sdhci-esdhc.h                     |     3 +-
 drivers/mmc/host/sdhci-msm.c                       |     5 +
 drivers/mmc/host/sdhci-of-arasan.c                 |     4 +
 drivers/mmc/host/sdhci-of-at91.c                   |   191 +
 drivers/mmc/host/sdhci-of-esdhc.c                  |     6 +
 drivers/mmc/host/sdhci-pci.c                       |     1 +
 drivers/mmc/host/sdhci-sirf.c                      |     4 +-
 drivers/mmc/host/sdhci.c                           |   123 +-
 drivers/mmc/host/sdhci.h                           |    10 +-
 drivers/mmc/host/sh_mmcif.c                        |     2 +
 drivers/mmc/host/sunxi-mmc.c                       |     2 +-
 drivers/mmc/host/tmio_mmc_pio.c                    |     6 +-
 drivers/mmc/host/usdhi6rol0.c                      |    15 +-

So this probably results from the MMC update during the merge window:

85579ad7f1df Merge tag 'mmc-v4.3' of git://git.linaro.org/people/ulf.hansson/mmc

The OMAP4430 reports this during it's boot log:

mmc0: new high speed MMC card at address 0001
mmcblk0: mmc0:0001 SEM08G 7.39 GiB
mmcblk0boot0: mmc0:0001 SEM08G partition 1 1.00 MiB
mmcblk0boot1: mmc0:0001 SEM08G partition 2 1.00 MiB
...
VFS: Cannot open root device "mmcblk0p2" or unknown-block(179,2): error -6
b300         7757824 mmcblk0  driver: mmcblk
b310            1024 mmcblk0boot1  (driver?)
b308            1024 mmcblk0boot0  (driver?)
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(179,2)

whereas previous kernels reported:

mmc0: host does not support reading read-only switch, assuming write-enable
mmc0: new high speed SD card at address 0002
mmcblk0: mmc0:0002 00000 971 MiB
 mmcblk0: p1 p2
Waiting 2 sec before mounting root device...
mmc1: new high speed MMC card at address 0001
mmcblk1: mmc1:0001 SEM08G 7.39 GiB
mmcblk1boot0: mmc1:0001 SEM08G partition 1 1.00 MiB
mmcblk1boot1: mmc1:0001 SEM08G partition 2 1.00 MiB
...
VFS: Mounted root (ext3 filesystem) on device 179:2.

OMAP3430 only reports:

VFS: Cannot open root device "mmcblk0p2" or unknown-block(0,0): error -6

where previous kernels reported:

mmc0: host does not support reading read-only switch, assuming write-enable
mmc0: new high speed SD card at address 0002
mmcblk0: mmc0:0002 00000 971 MiB
 mmcblk0: p1 p2
...
VFS: Mounted root (ext2 filesystem) on device 179:2.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
