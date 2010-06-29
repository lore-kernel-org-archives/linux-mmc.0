From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 0/3] add non-standard SDIO card support
Date: Tue, 29 Jun 2010 16:49:22 +0300
Message-ID: <1277819365-2761-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Adrian Hunter <adrian.hunter@nokia.com>, Tony Lindgren <tony@atomide.com>, Bob Copeland <me@bobcopeland.com>, Kalle Valo <kvalo@adurom.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: linux-mmc@vger.kernel.org

This is my attempt to make SDIO interfaced TI WL1251 wifi chip usable
on mainline kernels. It's driver has already been merged several releases
back, but the problem is current SDIO core can't detect the card because
it's not following SDIO standards and does not have any required SDIO
registers. Currenty attempting to use this chip only results in several
pages of complains about invalid register data from SDIO core.
WL1251 is used on various HTC devices and Pandora handheld at least.

People wanting to use this are forced to use forked trees or patches.
My solution to this problem is to add new MMC quirk that will tell SDIO
core not to access any SDIO registers and rely on host's init_card
callback instead, which is now responsible for filling card related
structures for SDIO core to function. Patches 2 and 3 set up the card
for pandora, similar method could be used for MSM too.

Only patches 2,3 depend on each other, so patch 1 can be merged separately.

Grazvydas Ignotas (3):
  sdio: allow non-standard SDIO cards
  omap_hsmmc: add init_card pass-through callback
  omap: pandora: pass information about wl1251 to SDIO core

 arch/arm/mach-omap2/board-omap3pandora.c |   16 +++++++++++++
 arch/arm/mach-omap2/hsmmc.c              |    1 +
 arch/arm/mach-omap2/hsmmc.h              |    4 +++
 arch/arm/plat-omap/include/plat/mmc.h    |    2 +
 drivers/mmc/core/sdio.c                  |   36 +++++++++++++++++++++++++-----
 drivers/mmc/host/omap_hsmmc.c            |   10 ++++++++
 include/linux/mmc/card.h                 |    2 +
 7 files changed, 65 insertions(+), 6 deletions(-)

