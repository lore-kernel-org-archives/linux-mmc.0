From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.3-rc4
Date: Fri,  9 Aug 2019 12:01:49 +0200
Message-ID: <20190809100149.7027-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.3-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit e21a712a9685488f5ce80495b37b9fdbe96c230d:

  Linux 5.3-rc3 (2019-08-04 18:40:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc3

for you to fetch changes up to b803974a86039913d5280add083d730b2b9ed8ec:

  mmc: cavium: Add the missing dma unmap when the dma has finished. (2019-08-06 18:59:14 +0200)

----------------------------------------------------------------
MMC host:
 - cavium: Fix DMA support
 - sdhci-sprd: Fix soft reset when runtime resuming

----------------------------------------------------------------
Baolin Wang (1):
      mmc: sdhci-sprd: Fix the incorrect soft reset operation when runtime resuming

Kevin Hao (2):
      mmc: cavium: Set the correct dma max segment size for mmc_host
      mmc: cavium: Add the missing dma unmap when the dma has finished.

 drivers/mmc/host/cavium.c          | 4 +++-
 drivers/mmc/host/sdhci-acpi.c      | 2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
 drivers/mmc/host/sdhci-of-at91.c   | 2 +-
 drivers/mmc/host/sdhci-pci-core.c  | 4 ++--
 drivers/mmc/host/sdhci-pxav3.c     | 2 +-
 drivers/mmc/host/sdhci-s3c.c       | 2 +-
 drivers/mmc/host/sdhci-sprd.c      | 2 +-
 drivers/mmc/host/sdhci-xenon.c     | 2 +-
 drivers/mmc/host/sdhci.c           | 4 ++--
 drivers/mmc/host/sdhci.h           | 2 +-
 11 files changed, 15 insertions(+), 13 deletions(-)
