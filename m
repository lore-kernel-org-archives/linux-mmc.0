From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.13 rc1
Date: Fri, 14 Jul 2017 11:54:53 +0200
Message-ID: <CAPDyKFqTVbzyajfxFQcQcTPOfC7e8qO1Y4j_mFh-=V9Ptvep+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here are a couple of mmc fixes intended for v4.13 rc1. They are based
on a commit from your tree earlier during the merge window and have
been tested in linux-next for a few days.

Details are as usual found in the signed tag. Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 9967468c0a109644e4a1f5b39b39bf86fe7507a7:

  Merge branch 'akpm' (patches from Andrew) (2017-07-10 16:58:42 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.13-2

for you to fetch changes up to 9c284c41c0886f09e75c323a16278b6d353b0b4a:

  mmc: tmio-mmc: fix bad pointer math (2017-07-13 11:56:35 +0200)

----------------------------------------------------------------
MMC core:
 - Restore some behaviour of MMC_IOC_MULTI_CMD commands
 - Fix using un-initialized variable in mmc_blk_issue_drv_op()
 - Fix mmc block queue cleanup

MMC host:
 - sdhci-acpi: Workaround conflict with PCI wifi on GPD Win handheld
 - tmio-mmc: Fix bad pointer math

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci-acpi: Workaround conflict with PCI wifi on GPD Win handheld

Chris Brandt (1):
      mmc: tmio-mmc: fix bad pointer math

Geert Uytterhoeven (2):
      mmc: block: Initialize ret in mmc_blk_issue_drv_op() for MMC_DRV_OP_IOCTL
      mmc: block: Let MMC_IOC_MULTI_CMD return zero again for zero entries

Grzegorz Sluja (1):
      mmc: block: Prevent new req entering queue after its cleanup

 drivers/mmc/core/block.c         |  6 +++-
 drivers/mmc/host/sdhci-acpi.c    | 70 ++++++++++++++++++++++++++++++++++++----
 drivers/mmc/host/tmio_mmc_core.c | 19 ++++++-----
 3 files changed, 78 insertions(+), 17 deletions(-)
