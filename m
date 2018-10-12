From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v4.19-rc8
Date: Fri, 12 Oct 2018 12:35:29 +0200
Message-ID: <20181012103529.4688-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Linus <torvalds@linux-foundation.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Greg,

Here's a PR with two MMC/WIFI/SDIO fixes intended for v4.19-rc8. Details about
the highlights are found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:

  Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.19-rc7

for you to fetch changes up to 4f666675cdff0b986195413215eb062b7da6586f:

  libertas: call into generic suspend code before turning off power (2018-10-10 14:01:50 +0200)

----------------------------------------------------------------
MMC core:
 - Avoid fragile multiblock reads for the last sector in SPI mode

WIFI/SDIO:
 - libertas: Fixup suspend sequence for the SDIO card

----------------------------------------------------------------
Chris Boot (1):
      mmc: block: avoid multiblock reads for the last sector in SPI mode

Daniel Mack (1):
      libertas: call into generic suspend code before turning off power

 drivers/mmc/core/block.c                        | 10 ++++++++++
 drivers/net/wireless/marvell/libertas/if_sdio.c |  4 ++++
 2 files changed, 14 insertions(+)
