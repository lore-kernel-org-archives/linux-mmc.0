From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.4-rc5
Date: Fri, 25 Oct 2019 16:00:58 +0200
Message-ID: <20191025140058.10668-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.4-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 7d194c2100ad2a6dded545887d02754948ca5241:

  Linux 5.4-rc4 (2019-10-20 15:56:22 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.4-rc4

for you to fetch changes up to 2bb9f7566ba7ab3c2154964461e37b52cdc6b91b:

  mmc: mxs: fix flags passed to dmaengine_prep_slave_sg (2019-10-21 16:16:38 +0200)

----------------------------------------------------------------
MMC host:
 - mxs: Fix flags passed to dmaengine_prep_slave_sg
 - cqhci: Add a missing memory barrier
 - sdhci-omap: Fix tuning procedure for temperatures < -20C

----------------------------------------------------------------
Faiz Abbas (2):
      mmc: sdhci-omap: Fix Tuning procedure for temperatures < -20C
      mmc: cqhci: Commit descriptors before setting the doorbell

Sascha Hauer (1):
      mmc: mxs: fix flags passed to dmaengine_prep_slave_sg

 drivers/mmc/host/cqhci.c      | 3 ++-
 drivers/mmc/host/mxs-mmc.c    | 7 ++++---
 drivers/mmc/host/sdhci-omap.c | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)
