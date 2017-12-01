From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.15-rc2
Date: Fri,  1 Dec 2017 11:25:12 +0100
Message-ID: <1512123912-11498-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v4.15-rc2. The changes as
based on a commit during the mergewindow and have been tested in linux-next for
a while by now.

Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 5a787756b809888e8925d722862167f1229b58f7:

  Merge tag 'pwm/for-4.15-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm (2017-11-22 21:09:18 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.15-2

for you to fetch changes up to c892b0d81705c566f575e489efc3c50762db1bde:

  mmc: core: prepend 0x to OCR entry in sysfs (2017-11-29 10:46:53 +0100)

----------------------------------------------------------------
MMC core:
 - Ensure that debugfs files are removed properly
 - Fix missing blk_put_request()
 - Deal with errors from blk_get_request()
 - Rewind mmc bus suspend operations at failures
 - Prepend '0x' to ocr and pre_eol_info in sysfs to identify as hex

MMC host:
 - sdhci-msm: Make it optional to wait for signal level changes
 - sdhci: Avoid swiotlb buffer being full

----------------------------------------------------------------
Adrian Hunter (4):
      mmc: block: Fix missing blk_put_request()
      mmc: block: Check return value of blk_get_request()
      mmc: core: Do not leave the block driver in a suspended state
      mmc: block: Ensure that debugfs files are removed

Bastian Stender (2):
      mmc: core: prepend 0x to pre_eol_info entry in sysfs
      mmc: core: prepend 0x to OCR entry in sysfs

Bjorn Andersson (1):
      mmc: sdhci-msm: Optionally wait for signal level changes

Ulf Hansson (1):
      mmc: sdhci: Avoid swiotlb buffer being full

 drivers/mmc/core/block.c     | 67 ++++++++++++++++++++++++++++++++++++++------
 drivers/mmc/core/bus.c       |  3 ++
 drivers/mmc/core/debugfs.c   |  1 +
 drivers/mmc/core/mmc.c       |  4 +--
 drivers/mmc/core/sd.c        |  2 +-
 drivers/mmc/host/sdhci-msm.c | 14 +++++++++
 drivers/mmc/host/sdhci.c     | 28 +++++++++++-------
 7 files changed, 98 insertions(+), 21 deletions(-)
