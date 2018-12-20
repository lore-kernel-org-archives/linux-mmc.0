From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v4.20-rc8
Date: Thu, 20 Dec 2018 10:58:32 +0100
Message-ID: <20181220095832.7375-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v4.20-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd:

  Linux 4.20-rc7 (2018-12-16 15:46:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.20-rc7

for you to fetch changes up to e3ae3401aa19432ee4943eb0bbc2ec704d07d793:

  mmc: core: Use a minimum 1600ms timeout when enabling CACHE ctrl (2018-12-17 08:59:42 +0100)

----------------------------------------------------------------
MMC core:
 - Restore code to allow BKOPS and CACHE ctrl even if no HPI support
 - Reset HPI enabled state during re-init
 - Use a default minimum timeout when enabling CACHE ctrl

MMC host:
 - omap_hsmmc: Fix DMA API warning
 - sdhci-tegra: Fix dt parsing of SDMMC pads autocal values
 - Correct register accesses when enabling v4 mode

----------------------------------------------------------------
Russell King (1):
      mmc: omap_hsmmc: fix DMA API warning

Sowjanya Komatineni (2):
      mmc: sdhci: Fix sdhci_do_enable_v4_mode
      mmc: tegra: Fix for SDMMC pads autocal parsing from dt

Ulf Hansson (3):
      mmc: core: Reset HPI enabled state during re-init and in case of errors
      mmc: core: Allow BKOPS and CACHE ctrl even if no HPI support
      mmc: core: Use a minimum 1600ms timeout when enabling CACHE ctrl

 drivers/mmc/core/mmc.c         | 24 +++++++++++++++---------
 drivers/mmc/host/omap_hsmmc.c  | 12 +++++++++++-
 drivers/mmc/host/sdhci-tegra.c |  8 ++++----
 drivers/mmc/host/sdhci.c       |  4 ++--
 4 files changed, 32 insertions(+), 16 deletions(-)
