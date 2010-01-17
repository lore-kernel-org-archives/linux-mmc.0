From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V2 0/10] omap_hsmmc changes V2
Date: Sun, 17 Jan 2010 03:28:02 +0200
Message-ID: <20100117012802.16545.88531.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37028 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116Ab0AQB2Q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Jan 2010 20:28:16 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

Hi

Here are some changes we need for omap_hsmmc.  They are dependent on OMAP
board files so it would be simplest if the patches all went via the OMAP
tree.

This is version 2 of this patch set.  Thank you Tony, Paul and Madhu for
your comments.

Changes from version 1:
	- amended patch 'omap_hsmmc: Move gpio and regulator control from
	board file' so that system control functions remain in the board
	file
	- for clarity, split patch 'omap: Rename mmc-twl4030 to hsmmc' into
	'omap: Rename mmc-twl4030 files to hsmmc' and
	'omap: Rename hsmmc symbols to reflect independence from twl4030'
	- removed patch 'omap_hsmmc: set DVFS/PM constraints'
	- added patch 'omap: Add functions for dynamic remuxing of pins'
	- renamed and reworked patch 'omap: RX51: Remux to pull eMMC lines
	down when powering off' (was 'omap_hsmmc: RX51: set padconfs to pull
	down when powering off eMMC')
	- added patch 'omap_hsmmc: Ensure regulator enable / disable are
	paired'
	- fixed mistakes in patch 'omap_hsmmc: Allow for a shared VccQ'


Adrian Hunter (9):
      omap_hsmmc: Move gpio and regulator control from board file
      omap: Rename mmc-twl4030 files to hsmmc
      omap: Rename hsmmc symbols to reflect independence from twl4030
      omap: Reconnect hsmmc context loss count
      omap: RX51: Remux to pull eMMC lines down when powering off
      omap_hsmmc: Allow for power saving without going off
      omap_hsmmc: Fix disable timeouts
      omap_hsmmc: Ensure regulator enable / disable are paired
      omap_hsmmc: Allow for a shared VccQ

Tony Lindgren (1):
      omap: Add functions for dynamic remuxing of pins

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
 arch/arm/mach-omap2/board-rx51-peripherals.c   |   63 +++-
 arch/arm/mach-omap2/board-zoom-peripherals.c   |    6 +-
 arch/arm/mach-omap2/hsmmc.c                    |  261 ++++++++++++
 arch/arm/mach-omap2/{mmc-twl4030.h => hsmmc.h} |   14 +-
 arch/arm/mach-omap2/mmc-twl4030.c              |  537 ------------------------
 arch/arm/mach-omap2/mux.c                      |   22 +-
 arch/arm/mach-omap2/mux.h                      |   24 +
 arch/arm/plat-omap/include/plat/mmc.h          |   35 ++-
 drivers/mmc/host/omap_hsmmc.c                  |  375 ++++++++++++++++-
 21 files changed, 788 insertions(+), 641 deletions(-)
 create mode 100644 arch/arm/mach-omap2/hsmmc.c
 rename arch/arm/mach-omap2/{mmc-twl4030.h => hsmmc.h} (63%)
 delete mode 100644 arch/arm/mach-omap2/mmc-twl4030.c


 
Regards
Adrian

