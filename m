From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.3-rc7
Date: Fri, 30 Aug 2019 09:41:47 +0200
Message-ID: <20190830074147.3691-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.3-rc7. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1:

  Linux 5.3-rc5 (2019-08-18 14:31:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc5

for you to fetch changes up to e73a3896eaca95ea5fc895720502a3f040eb4b39:

  mmc: sdhci-cadence: enable v4_mode to fix ADMA 64-bit addressing (2019-08-30 09:17:53 +0200)

----------------------------------------------------------------
MMC core:
 - Fix init of SD cards reporting an invalid VDD range

MMC host:
 - sdhci-sprd: Fixes for clocks, card-detect, write-protect etc
 - sdhci-cadence: Fix ADMA 64-bit addressing
 - sdhci-tegra: Re-allow writing to SD card when GPIO pin is absent
 - sdhci-of-at91: Fix eMMC init by clearing HS200 cap as it's not supported

----------------------------------------------------------------
Chunyan Zhang (5):
      mmc: sdhci-sprd: fixed incorrect clock divider
      mmc: sdhci-sprd: add get_ro hook function
      mmc: sdhci-sprd: add SDHCI_QUIRK2_PRESET_VALUE_BROKEN
      mms: sdhci-sprd: add SDHCI_QUIRK_BROKEN_CARD_DETECTION
      mmc: sdhci-sprd: clear the UHS-I modes read from registers

Dmitry Osipenko (1):
      Revert "mmc: sdhci-tegra: drop ->get_ro() implementation"

Eugen Hristev (1):
      mmc: sdhci-of-at91: add quirk for broken HS200

Masahiro Yamada (1):
      mmc: sdhci-cadence: enable v4_mode to fix ADMA 64-bit addressing

Ulf Hansson (1):
      mmc: core: Fix init of SD cards reporting an invalid VDD range

 drivers/mmc/core/sd.c            |  6 ++++++
 drivers/mmc/host/sdhci-cadence.c |  1 +
 drivers/mmc/host/sdhci-of-at91.c |  3 +++
 drivers/mmc/host/sdhci-sprd.c    | 30 +++++++++++++++++++++++++-----
 drivers/mmc/host/sdhci-tegra.c   | 14 ++++++++++++++
 5 files changed, 49 insertions(+), 5 deletions(-)
