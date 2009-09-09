From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V3 0/30] mmc and omap_hsmmc patches
Date: Wed, 09 Sep 2009 14:56:33 +0300
Message-ID: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:24133 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973AbZIIL4r (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Sep 2009 07:56:47 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Pierre Ossman <pierre@ossman.eu>, Matt Fleming <matt@console-pimps.org>

Hi

Here is version 3 of our 30 patches for mmc and omap_hsmmc.

They exclude Matt Fleming's change for card caps

They split into 2 groups: the first 7 affect mmc core only
and the remaining ones affect omap_hsmmc only.

Madhusudhan Chikkature's patch:
	[PATCH V2] omap_hsmmc: Fix for the db clock failure message
still applies cleanly on top.

Adrian Hunter (18):
      mmc: add 'enable' and 'disable' methods to mmc host
      mmc: allow host claim / release nesting
      mmc: add MMC_CAP_NONREMOVABLE host capability
      mmc: add ability to save power by powering off cards
      mmc: check status after MMC SWITCH command
      omap_hsmmc: make use of new enable/disable interface
      omap_hsmmc: keep track of power mode
      omap_hsmmc: ensure workqueues are empty before suspend
      omap_hsmmc: make use of new MMC_CAP_NONREMOVABLE host capability
      ARM: OMAP: mmc-twl4030: add regulator sleep / wake function
      omap_hsmmc: put MMC regulator to sleep
      omap_hsmmc: clear interrupt status after init sequence
      omap_hsmmc: cater for weird CMD6 behaviour
      omap_hsmmc: prevent races with irq handler
      omap_hsmmc: protect the card when the cover is open
      omap_hsmmc: ensure all clock enables and disables are paired
      omap_hsmmc: set a large data timeout for commands with busy signal
      ARM: OMAP: RX51: set MMC capabilities and power-saving flag

Denis Karpov (8):
      mmc: power off once at removal
      omap_hsmmc: add debugfs entry (host registers)
      ARM: OMAP: mmc-twl4030: add context loss counter support
      omap_hsmmc: context save/restore support
      omap_hsmmc: set open drain bit correctly
      omap_hsmmc: support for deeper power saving states
      omap_hsmmc: cleanup macro usage
      omap_hsmmc: code refactoring

Jarkko Lavinen (4):
      mmc: add mmc card sleep and awake support
      omap_hsmmc: fix scatter-gather list sanity checking
      omap_hsmmc: add mmc card sleep and awake support
      omap_hsmmc: fix NULL pointer dereference

 arch/arm/mach-omap2/board-rx51-peripherals.c |    4 +
 arch/arm/mach-omap2/mmc-twl4030.c            |   78 ++
 arch/arm/mach-omap2/mmc-twl4030.h            |    2 +
 arch/arm/plat-omap/include/mach/mmc.h        |   11 +
 drivers/mmc/core/core.c                      |  275 +++++++-
 drivers/mmc/core/core.h                      |    4 +
 drivers/mmc/core/host.c                      |    1 +
 drivers/mmc/core/host.h                      |    2 +
 drivers/mmc/core/mmc.c                       |  130 +++-
 drivers/mmc/core/mmc_ops.c                   |   59 ++
 drivers/mmc/core/mmc_ops.h                   |    1 +
 drivers/mmc/core/sd.c                        |   52 ++-
 drivers/mmc/host/omap_hsmmc.c                | 1035 +++++++++++++++++++++-----
 include/linux/mmc/card.h                     |    2 +
 include/linux/mmc/core.h                     |    1 +
 include/linux/mmc/host.h                     |   58 ++
 include/linux/mmc/mmc.h                      |    3 +
 17 files changed, 1503 insertions(+), 215 deletions(-)

Regards
Adrian

