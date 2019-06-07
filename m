From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC and MEMSTICK fixes for v5.2-rc4
Date: Fri,  7 Jun 2019 12:39:11 +0200
Message-ID: <20190607103911.4623-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC and MEMSTICK fixes intended for v5.2-rc4.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:

  Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.2-rc2

for you to fetch changes up to 7397993145872c74871ab2aa7fa26a427144088a:

  mmc: sdhci_am654: Fix SLOTTYPE write (2019-06-03 15:18:25 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci: Fix SDIO IRQ thread deadlock
 - sdhci-tegra: Fix a warning message
 - sdhci_am654: Fix SLOTTYPE write
 - meson-gx: Fix IRQ ack
 - tmio: Fix SCC error handling to avoid false positive CRC error

MEMSTICK core:
 - mspro_block: Fix returning a correct error code

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci: Fix SDIO IRQ thread deadlock

Dan Carpenter (2):
      memstick: mspro_block: Fix an error code in mspro_block_issue_req()
      mmc: tegra: Fix a warning message

Faiz Abbas (1):
      mmc: sdhci_am654: Fix SLOTTYPE write

Jerome Brunet (1):
      mmc: meson-gx: fix irq ack

Takeshi Saito (1):
      mmc: tmio: fix SCC error handling to avoid false positive CRC error

 drivers/memstick/core/mspro_block.c | 13 ++++++-------
 drivers/mmc/host/meson-gx-mmc.c     |  6 +++---
 drivers/mmc/host/sdhci-tegra.c      |  2 +-
 drivers/mmc/host/sdhci.c            | 24 +++++++++++++-----------
 drivers/mmc/host/sdhci_am654.c      |  2 +-
 drivers/mmc/host/tmio_mmc_core.c    |  3 ++-
 6 files changed, 26 insertions(+), 24 deletions(-)
