From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.4-rc4
Date: Fri, 18 Oct 2019 12:08:14 +0200
Message-ID: <20191018100814.5265-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.4-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.4-rc1

for you to fetch changes up to 28c9fac09ab0147158db0baeec630407a5e9b892:

  memstick: jmb38x_ms: Fix an error handling path in 'jmb38x_ms_probe()' (2019-10-09 11:08:03 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci-iproc: Prevent some spurious interrupts
 - renesas_sdhi/sh_mmcif: Avoid false warnings about IRQs not found

MEMSTICK host:
 - jmb38x_ms: Fix an error handling path at ->probe()

----------------------------------------------------------------
Christophe JAILLET (1):
      memstick: jmb38x_ms: Fix an error handling path in 'jmb38x_ms_probe()'

Geert Uytterhoeven (2):
      mmc: renesas_sdhi: Do not use platform_get_irq() to count interrupts
      mmc: sh_mmcif: Use platform_get_irq_optional() for optional interrupt

Nicolas Saenz Julienne (1):
      mmc: sdhci-iproc: fix spurious interrupts on Multiblock reads with bcm2711

 drivers/memstick/host/jmb38x_ms.c    |  2 +-
 drivers/mmc/host/renesas_sdhi_core.c | 31 +++++++++++++++++++------------
 drivers/mmc/host/sdhci-iproc.c       |  1 +
 drivers/mmc/host/sh_mmcif.c          |  6 ++----
 4 files changed, 23 insertions(+), 17 deletions(-)
