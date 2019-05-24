From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.2-rc2
Date: Fri, 24 May 2019 12:10:28 +0200
Message-ID: <20190524101028.8158-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a few MMC fixes intended for v5.2-rc2. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 5ac94332248ee017964ba368cdda4ce647e3aba7:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2019-05-14 20:56:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.2-2

for you to fetch changes up to ec0970e0a1b2c807c908d459641a9f9a1be3e130:

  mmc: sdhci-iproc: Set NO_HISPD bit to fix HS50 data hold time problem (2019-05-15 13:52:05 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci-iproc: Fix HS50 data hold time problem for a few variants

----------------------------------------------------------------
Trac Hoang (2):
      mmc: sdhci-iproc: cygnus: Set NO_HISPD bit to fix HS50 data hold time problem
      mmc: sdhci-iproc: Set NO_HISPD bit to fix HS50 data hold time problem

 drivers/mmc/host/sdhci-iproc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
