From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.1-rc2
Date: Fri, 22 Mar 2019 11:15:36 +0100
Message-ID: <20190322101536.25315-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.1-rc2. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.1-rc1

for you to fetch changes up to c9a9497ccef205ed4ed2e247011382627876d831:

  mmc: renesas_sdhi: limit block count to 16 bit for old revisions (2019-03-21 11:41:46 +0100)

----------------------------------------------------------------
MMC host:
 - alcor: Fix DMA reads
 - renesas_sdhi: Limit block count to 16-bit for old revisions
 - sdhci-omap: Fixup support for read-only pins
 - mxcmmc: Revert support for highmem pages
 - davinci/pxamci: Fix clang build warnings

----------------------------------------------------------------
Alexander Shiyan (1):
      mmc: mxcmmc: "Revert mmc: mxcmmc: handle highmem pages"

Arnd Bergmann (2):
      mmc: pxamci: fix enum type confusion
      mmc: davinci: remove extraneous __init annotation

Daniel Drake (1):
      mmc: alcor: fix DMA reads

Kishon Vijay Abraham I (1):
      mmc: sdhci-omap: Set caps2 to indicate no physical write protect pin

Wolfram Sang (1):
      mmc: renesas_sdhi: limit block count to 16 bit for old revisions

 drivers/mmc/host/alcor.c             | 25 +++++++++++++++++++------
 drivers/mmc/host/davinci_mmc.c       |  2 +-
 drivers/mmc/host/mxcmmc.c            | 16 ++++------------
 drivers/mmc/host/pxamci.c            |  2 +-
 drivers/mmc/host/renesas_sdhi_core.c |  8 +++++++-
 drivers/mmc/host/sdhci-omap.c        |  3 +++
 6 files changed, 35 insertions(+), 21 deletions(-)
