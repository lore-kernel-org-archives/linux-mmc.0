From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 0/6] tmio: add support for eMMC with 8 bit bus width
Date: Mon, 19 Sep 2016 14:49:15 +0200
Message-ID: <20160919124921.8172-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Dirk Behme <dirk.behme@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

This series enables SDHI instances on R-Car Gen3 to access eMMC with 8 bit bus
width. I think the patch descriptions speak for themselves.

I decided to not protect this new feature with a flag because it needs
specifically to be enabled by setting the bus width to 8. No legacy platform
does that.

Note that I decided to use the pattern that pinctrl-0 is 3.3v and
pinctrl-1 is 1.8v, although the eMMC is fixed at 1.8v. I tried a few ways to
only use pinctrl-0 being 1.8v here, but they all ended up to be confusing for
users IMO, so I sticked to the most consistent solution after all.

Changes since V1:

* merged the two distinct series (drivers + DTS) into one: patches 1-4 are for
  Ulf, I will ping Simon for patches 5+6 when the time is ready.

* DTS now contains 'non-removable' and we have a software workaround for now.

These patches are based on top of Simon's sdr104-v7 patches but they apply to
current mmc/next as well. A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/topic/sdhi-8bit-emmc

Please review, comment, apply...

   Wolfram

Wolfram Sang (6):
  mmc: add define for R1 response without CRC
  mmc: rtsx_pci: use new macro for R1 without CRC
  mmc: rtsx_usb: use new macro for R1 without CRC
  mmc: tmio: add eMMC support
  arm64: dts: r8a7795: salvator: enable on-board eMMC
  arm64: dts: r8a7796: salvator: enable on board eMMC

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 43 +++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts | 44 +++++++++++++++++++++-
 drivers/mmc/host/rtsx_pci_sdmmc.c                  |  2 +-
 drivers/mmc/host/rtsx_usb_sdmmc.c                  |  2 +-
 drivers/mmc/host/tmio_mmc.h                        |  3 ++
 drivers/mmc/host/tmio_mmc_pio.c                    | 38 +++++++++++++------
 include/linux/mmc/core.h                           |  3 ++
 7 files changed, 120 insertions(+), 15 deletions(-)

-- 
2.9.3
