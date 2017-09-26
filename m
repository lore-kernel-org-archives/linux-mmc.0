From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.14-rc3
Date: Wed, 27 Sep 2017 01:49:36 +0200
Message-ID: <1506469776-9973-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a few MMC fixes intended for v4.14-rc3. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.14-rc1

for you to fetch changes up to 6ae033689d7b1a419def78e8e990b0eab8bb6419:

  mmc: sdhci-pci: Fix voltage switch for some Intel host controllers (2017-09-22 11:06:45 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci-pci: Fix voltage switch for some Intel host controllers
 - tmio: remove broken and noisy debug macro

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci-pci: Fix voltage switch for some Intel host controllers

Wolfram Sang (1):
      mmc: tmio: remove broken and noisy debug macro

 drivers/mmc/host/sdhci-pci-core.c | 15 +++++++++++++
 drivers/mmc/host/tmio_mmc_core.c  | 47 ---------------------------------------
 2 files changed, 15 insertions(+), 47 deletions(-)
