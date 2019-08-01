From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.3-rc3
Date: Thu,  1 Aug 2019 12:43:19 +0200
Message-ID: <20190801104319.25247-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.3-rc3. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc1

for you to fetch changes up to 3a6ffb3c8c3274a39dc8f2514526e645c5d21753:

  mmc: mmc_spi: Enable stable writes (2019-07-22 15:31:00 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci-sprd: Add a missing pm_runtime_put_noidle() to fix deferred probe
 - dw_mmc: Fix occasional hang after tuning on eMMC
 - meson-mx-sdio: Fix misuse of GENMASK macro
 - mmc_spi: Fix CRC problems for writes by using BDI_CAP_STABLE_WRITES

----------------------------------------------------------------
Andreas Koop (1):
      mmc: mmc_spi: Enable stable writes

Baolin Wang (1):
      mmc: host: sdhci-sprd: Fix the missing pm_runtime_put_noidle()

Douglas Anderson (1):
      mmc: dw_mmc: Fix occasional hang after tuning on eMMC

Joe Perches (1):
      mmc: meson-mx-sdio: Fix misuse of GENMASK macro

 drivers/mmc/core/queue.c         | 5 +++++
 drivers/mmc/host/dw_mmc.c        | 3 +--
 drivers/mmc/host/meson-mx-sdio.c | 2 +-
 drivers/mmc/host/sdhci-sprd.c    | 1 +
 4 files changed, 8 insertions(+), 3 deletions(-)
