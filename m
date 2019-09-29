From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC updates for v5.4 take 2
Date: Sun, 29 Sep 2019 21:38:10 +0200
Message-ID: <20190929193810.2551-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple more updates/fixes for MMC fixes intended for v5.4.
No worries if this doesn't get included in rc1.

Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 3c6a6910a81eae3566bb5fef6ea0f624382595e6:

  Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 (2019-09-23 09:31:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.4-2

for you to fetch changes up to e51df6ce668a8f75ce27f83ce0f60103c568c375:

  mmc: host: sdhci-pci: Add Genesys Logic GL975x support (2019-09-27 20:48:20 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci-pci: Add Genesys Logic GL975x support
 - sdhci-tegra: Recover loss in throughput for DMA
 - sdhci-of-esdhc: Fix DMA bug

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci: Let drivers define their DMA mask

Ben Chuang (1):
      mmc: host: sdhci-pci: Add Genesys Logic GL975x support

Nicolin Chen (1):
      mmc: tegra: Implement ->set_dma_mask()

Russell King (2):
      mmc: sdhci: improve ADMA error reporting
      mmc: sdhci-of-esdhc: set DMA snooping based on DMA coherence

 drivers/mmc/host/Kconfig          |   1 +
 drivers/mmc/host/Makefile         |   2 +-
 drivers/mmc/host/sdhci-of-esdhc.c |   7 +-
 drivers/mmc/host/sdhci-pci-core.c |   2 +
 drivers/mmc/host/sdhci-pci-gli.c  | 352 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h      |   5 +
 drivers/mmc/host/sdhci-tegra.c    |  48 +++---
 drivers/mmc/host/sdhci.c          |  27 +--
 drivers/mmc/host/sdhci.h          |   1 +
 9 files changed, 410 insertions(+), 35 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-pci-gli.c
