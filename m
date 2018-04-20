From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.17-rc2
Date: Fri, 20 Apr 2018 08:51:47 +0200
Message-ID: <1524207107-3397-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v4.17-rc2. Details about
the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit fc167daff581c01ebce8695e9618231cae3561a1:

  mmc: tmio: Fix error handling when issuing CMD23 (2018-04-04 12:21:27 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.17-3

for you to fetch changes up to 0cbc94daa55441c21999e96a07061952d873dcb7:

  mmc: renesas_sdhi_internal_dmac: limit DMA RX for old SoCs (2018-04-19 14:57:17 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci-pci: Fixup tuning for AMD for eMMC HS200 mode
 - renesas_sdhi_internal_dmac: Avoid data corruption by limiting DMA RX

----------------------------------------------------------------
Daniel Kurtz (1):
      mmc: sdhci-pci: Only do AMD tuning for HS200

Wolfram Sang (1):
      mmc: renesas_sdhi_internal_dmac: limit DMA RX for old SoCs

 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 39 ++++++++++++++++++++++-----
 drivers/mmc/host/sdhci-pci-core.c             | 25 +++++++++++++++--
 2 files changed, 56 insertions(+), 8 deletions(-)
