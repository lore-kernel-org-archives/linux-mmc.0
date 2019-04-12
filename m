From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.1-rc5
Date: Fri, 12 Apr 2019 14:02:52 +0200
Message-ID: <20190412120252.3704-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.1-rc5. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00:

  Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.1-rc2

for you to fetch changes up to 5c41ea6d52003b5bc77c2a82fd5ca7d480237d89:

  mmc: sdhci-omap: Don't finish_mrq() on a command error during tuning (2019-04-11 12:40:32 +0200)

----------------------------------------------------------------
MMC host:
 - alcor: Stabilize data write requests
 - sdhci-omap: Fix command error path during tuning

----------------------------------------------------------------
Daniel Drake (1):
      mmc: alcor: don't write data before command has completed

Faiz Abbas (1):
      mmc: sdhci-omap: Don't finish_mrq() on a command error during tuning

 drivers/mmc/host/alcor.c      | 34 +++++++++++++---------------------
 drivers/mmc/host/sdhci-omap.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 21 deletions(-)
