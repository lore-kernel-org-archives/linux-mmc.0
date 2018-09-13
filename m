From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v4.19-rc4
Date: Thu, 13 Sep 2018 17:06:04 +0200
Message-ID: <20180913150604.3887-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v4.19-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.19-rc2

for you to fetch changes up to c483a5cc9d09f4ceaa9abb106f863cc89cb643d9:

  mmc: meson-mx-sdio: fix OF child-node lookup (2018-09-05 08:28:45 +0200)

----------------------------------------------------------------
MMC host:
 - meson-mx-sdio: Fix OF child-node lookup
 - omap_hsmmc: Fix wakeirq handling on removal

----------------------------------------------------------------
Andreas Kemnade (1):
      mmc: omap_hsmmc: fix wakeirq handling on removal

Johan Hovold (1):
      mmc: meson-mx-sdio: fix OF child-node lookup

 drivers/mmc/host/meson-mx-sdio.c | 8 ++++++--
 drivers/mmc/host/omap_hsmmc.c    | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)
