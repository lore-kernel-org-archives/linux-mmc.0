From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v4.20-rc7
Date: Thu, 13 Dec 2018 11:57:28 +0100
Message-ID: <20181213105728.32426-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v4.20-rc7. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 2595646791c319cadfdbf271563aac97d0843dc7:

  Linux 4.20-rc5 (2018-12-02 15:07:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.20-rc5

for you to fetch changes up to b704441e38f645dcfba1348ca3cc1ba43d1a9f31:

  mmc: sdhci: fix the timeout check window for clock and reset (2018-12-06 11:22:00 +0100)

----------------------------------------------------------------
MMC core:
 - Fixup RPMB requests to use mrq->sbc when sending CMD23

MMC host:
 - omap: Fix broken MMC/SD on OMAP15XX/OMAP5910/OMAP310
 - sdhci-omap: Fix DCRC error handling during tuning
 - sdhci: Fixup the timeout check window for clock and reset

----------------------------------------------------------------
Aaro Koskinen (1):
      MMC: OMAP: fix broken MMC on OMAP15XX/OMAP5910/OMAP310

Alek Du (1):
      mmc: sdhci: fix the timeout check window for clock and reset

Faiz Abbas (1):
      mmc: sdhci-omap: Fix DCRC error handling during tuning

Wolfram Sang (1):
      mmc: core: use mrq->sbc when sending CMD23 for RPMB

 drivers/mmc/core/block.c      | 15 ++++++++++-----
 drivers/mmc/host/omap.c       | 11 +++++++++--
 drivers/mmc/host/sdhci-omap.c | 12 ++++++++----
 drivers/mmc/host/sdhci.c      | 18 +++++++++++++-----
 4 files changed, 40 insertions(+), 16 deletions(-)
