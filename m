From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.3-rc9
Date: Fri, 13 Sep 2019 13:57:24 +0200
Message-ID: <20190913115724.22341-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.3-rc9. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit f74c2bb98776e2de508f4d607cd519873065118e:

  Linux 5.3-rc8 (2019-09-08 13:33:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.3-rc8

for you to fetch changes up to 87b5d602a1cc76169b8d81ec2c74c8d95d9350dc:

  mmc: tmio: Fixup runtime PM management during remove (2019-09-13 13:49:09 +0200)

----------------------------------------------------------------
MMC host:
 - tmio: Fixup runtime PM management during probe and remove
 - sdhci-pci-o2micro: Fix eMMC initialization for an AMD SoC
 - bcm2835: Prevent lockups when terminating work

----------------------------------------------------------------
Daniel Drake (1):
      Revert "mmc: sdhci: Remove unneeded quirk2 flag of O2 SD host controller"

Stefan Wahren (1):
      Revert "mmc: bcm2835: Terminate timeout work synchronously"

Ulf Hansson (3):
      Revert "mmc: tmio: move runtime PM enablement to the driver implementations"
      mmc: tmio: Fixup runtime PM management during probe
      mmc: tmio: Fixup runtime PM management during remove

 drivers/mmc/host/bcm2835.c           |  2 +-
 drivers/mmc/host/renesas_sdhi_core.c |  6 ------
 drivers/mmc/host/sdhci-pci-o2micro.c |  2 +-
 drivers/mmc/host/tmio_mmc.c          |  5 -----
 drivers/mmc/host/tmio_mmc.h          |  1 +
 drivers/mmc/host/tmio_mmc_core.c     | 27 ++++++++++++++-------------
 drivers/mmc/host/uniphier-sd.c       |  3 ---
 7 files changed, 17 insertions(+), 29 deletions(-)
