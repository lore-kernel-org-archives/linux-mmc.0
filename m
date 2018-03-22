From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.16-rc7
Date: Thu, 22 Mar 2018 11:05:52 +0100
Message-ID: <1521713152-4201-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v4.16-rc7. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 661e50bc853209e41a5c14a290ca4decc43cbfd1:

  Linux 4.16-rc4 (2018-03-04 14:54:11 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.16-rc4

for you to fetch changes up to d58ac803cfbb92ede501409dd6afe9abb111d4f1:

  mmc: sdhci-acpi: Fix IRQ 0 (2018-03-21 11:10:20 +0100)

----------------------------------------------------------------
MMC host:
 - dw_mmc: Fix the suspend/resume issue for Exynos5433
 - dw_mmc: Fix the DTO/CTO timeout overflow calculation for 32-bit systems
 - dw_mmc: Make PIO mode work when failing with idmac when dw_mci_reset occurs
 - sdhci-acpi: Re-allow IRQ 0 to fix broken probe

MMC core:
 - Update EXT_CSD caches to correctly switch partition for ioctl calls
 - Fix tracepoint print of blk_addr and blksz
 - Disable HPI on broken Micron (Numonyx) eMMC cards

----------------------------------------------------------------
Adrian Hunter (2):
      mmc: core: Fix tracepoint print of blk_addr and blksz
      mmc: sdhci-acpi: Fix IRQ 0

Bastian Stender (1):
      mmc: block: fix updating ext_csd caches on ioctl call

Dirk Behme (1):
      mmc: core: Disable HPI for certain Micron (Numonyx) eMMC cards

Evgeniy Didin (2):
      mmc: dw_mmc: Fix the DTO/CTO timeout overflow calculation for 32-bit systems
      mmc: dw_mmc: fix falling from idmac to PIO mode when dw_mci_reset occurs

Jaehoon Chung (1):
      mmc: dw_mmc: exynos: fix the suspend/resume issue for exynos5433

 drivers/mmc/core/block.c         | 19 +++++++++++++++++++
 drivers/mmc/core/card.h          |  1 +
 drivers/mmc/core/quirks.h        |  6 ++++++
 drivers/mmc/host/dw_mmc-exynos.c |  8 +++++++-
 drivers/mmc/host/dw_mmc.c        | 15 ++++++++++-----
 drivers/mmc/host/sdhci-acpi.c    |  2 +-
 include/trace/events/mmc.h       |  4 ++--
 7 files changed, 46 insertions(+), 9 deletions(-)
