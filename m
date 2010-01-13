From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 0/8] omap_hsmmc changes
Date: Wed, 13 Jan 2010 13:40:10 +0200
Message-ID: <20100113114010.7615.84920.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:20666 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755903Ab0AMLkb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2010 06:40:31 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@nokia.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Madhusudhan Chikkature <madhu.cr@ti.com>

Hi

Here are some changes we need for omap_hsmmc.  They are dependent on OMAP
board files so it would be simplest if the patches all went via the OMAP
tree.

Adrian Hunter (7):
      omap_hsmmc: move gpio and regulator control from board file
      OMAP: rename mmc-twl4030 to hsmmc
      OMAP: reconnect hsmmc context loss count
      omap_hsmmc: RX51: set padconfs to pull down when powering off eMMC
      omap_hsmmc: allow for power saving without going off
      omap_hsmmc: fix disable timeouts
      omap_hsmmc: allow for a shared VccQ

Denis Karpov (1):
      omap_hsmmc: set DVFS/PM constraints

 arch/arm/configs/rx51_defconfig                |    4 +-
 arch/arm/mach-omap2/Makefile                   |   28 +-
 arch/arm/mach-omap2/board-2430sdp.c            |    6 +-
 arch/arm/mach-omap2/board-3430sdp.c            |    6 +-
 arch/arm/mach-omap2/board-cm-t35.c             |    6 +-
 arch/arm/mach-omap2/board-igep0020.c           |    6 +-
 arch/arm/mach-omap2/board-ldp.c                |    6 +-
 arch/arm/mach-omap2/board-omap3beagle.c        |    6 +-
 arch/arm/mach-omap2/board-omap3evm.c           |    6 +-
 arch/arm/mach-omap2/board-omap3pandora.c       |    6 +-
 arch/arm/mach-omap2/board-omap3touchbook.c     |    6 +-
 arch/arm/mach-omap2/board-overo.c              |    6 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c   |   65 +++-
 arch/arm/mach-omap2/board-zoom-peripherals.c   |    4 +-
 arch/arm/mach-omap2/control.c                  |    2 +
 arch/arm/mach-omap2/hsmmc.c                    |  145 +++++++
 arch/arm/mach-omap2/{mmc-twl4030.h => hsmmc.h} |   16 +-
 arch/arm/mach-omap2/mmc-twl4030.c              |  537 ------------------------
 arch/arm/plat-omap/include/plat/control.h      |    6 +
 arch/arm/plat-omap/include/plat/mmc.h          |   12 +-
 drivers/mmc/host/omap_hsmmc.c                  |  456 +++++++++++++++++++-
 21 files changed, 716 insertions(+), 619 deletions(-)
 create mode 100644 arch/arm/mach-omap2/hsmmc.c
 rename arch/arm/mach-omap2/{mmc-twl4030.h => hsmmc.h} (58%)
 delete mode 100644 arch/arm/mach-omap2/mmc-twl4030.c
 
Regards
Adrian

