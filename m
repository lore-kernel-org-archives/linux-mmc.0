From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.0-rc7
Date: Fri, 15 Feb 2019 10:49:01 +0100
Message-ID: <20190215094901.27471-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.0-rc7. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:

  Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.0-rc5

for you to fetch changes up to 83e418a805d880a8b18add07f94d19b2a5a80307:

  mmc: meson-gx: fix interrupt name (2019-02-13 08:41:15 +0100)

----------------------------------------------------------------
MMC core:
 - Fix deadlock bug for block I/O requests

MMC host:
 - sunxi: Disable broken HS-DDR mode for H5 by default
 - sunxi: Avoid unsupported speed modes declared via DT
 - meson-gx: Restore interrupt name

----------------------------------------------------------------
Chen-Yu Tsai (2):
      mmc: sunxi: Disable HS-DDR mode for H5 eMMC controller by default
      mmc: sunxi: Filter out unsupported modes declared in the device tree

Martin Blumenstingl (1):
      mmc: meson-gx: fix interrupt name

Zachary Hays (1):
      mmc: block: handle complete_work on separate workqueue

 drivers/mmc/core/block.c        | 10 +++++++++-
 drivers/mmc/host/meson-gx-mmc.c |  3 ++-
 drivers/mmc/host/sunxi-mmc.c    | 26 +++++++++++++++++++++++++-
 include/linux/mmc/card.h        |  1 +
 4 files changed, 37 insertions(+), 3 deletions(-)
