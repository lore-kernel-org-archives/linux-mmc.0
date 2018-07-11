From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.18-rc5
Date: Wed, 11 Jul 2018 14:08:16 +0200
Message-ID: <20180711120816.13767-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v4.18-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.18-rc3

for you to fetch changes up to 92748beac07c471d995fbec642b63572dc01b3dc:

  mmc: sdhci-esdhc-imx: allow 1.8V modes without 100/200MHz pinctrl states (2018-07-09 11:17:47 +0200)

----------------------------------------------------------------
MMC core:
 - Fixup devname in /proc/interrupts for card detect GPIO

MMC host:
 - sdhci-esdhc-imx: Allow 1.8V speed-modes without 100/200MHz pinctrls
 - sunxi: Disable IRQ in low power state to prevent IRQ storm
 - dw_mmc: Fix card threshold control configuration
 - renesas_sdhi_internal_dmac: Fixup DMA error paths

----------------------------------------------------------------
Anson Huang (1):
      mmc: core: cd_label must be last entry of mmc_gpio struct

Stefan Agner (1):
      mmc: sdhci-esdhc-imx: allow 1.8V modes without 100/200MHz pinctrl states

Stefan Mavrodiev (1):
      mmc: sunxi: Disable irq during pm_suspend

Yoshihiro Shimoda (2):
      mmc: renesas_sdhi_internal_dmac: Fix missing unmap in error patch
      mmc: renesas_sdhi_internal_dmac: Cannot clear the RX_IN_USE in abort

x00270170 (1):
      mmc: dw_mmc: fix card threshold control configuration

 drivers/mmc/core/slot-gpio.c                  |  2 +-
 drivers/mmc/host/dw_mmc.c                     |  7 ++++---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 15 +++++++--------
 drivers/mmc/host/sdhci-esdhc-imx.c            | 21 +++++++++------------
 drivers/mmc/host/sunxi-mmc.c                  |  7 +++++++
 5 files changed, 28 insertions(+), 24 deletions(-)
