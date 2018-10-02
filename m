From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v4.19-rc7
Date: Tue,  2 Oct 2018 09:22:33 +0200
Message-ID: <20181002072233.2814-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Linus <torvalds@linux-foundation.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Greg,

Here's a PR with a few MMC fixes intended for v4.19-rc7. Details about the
highlights are found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 7876320f88802b22d4e2daf7eb027dd14175a0f8:

  Linux 4.19-rc4 (2018-09-16 11:52:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.19-rc4

for you to fetch changes up to 1b09d9c232cdaea59fb50ac437d3921ed1f1eafb:

  mmc: slot-gpio: Fix debounce time to use miliseconds again (2018-09-28 17:43:48 +0200)

----------------------------------------------------------------
MMC core:
 - Fixup conversion of debounce time to/from ms/us

MMC host:
 - sdhi: Fixup whitelisting for Gen3 types

----------------------------------------------------------------
Marek Szyprowski (1):
      mmc: slot-gpio: Fix debounce time to use miliseconds again

Tony Lindgren (1):
      mmc: core: Fix debounce time to use microseconds

Wolfram Sang (1):
      mmc: sdhi: sys_dmac: check for all Gen3 types when whitelisting

 drivers/mmc/core/host.c                  | 2 +-
 drivers/mmc/core/slot-gpio.c             | 2 +-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)
