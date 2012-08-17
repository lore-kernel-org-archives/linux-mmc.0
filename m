From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 00/10] Assorted MMC / OMAP HSMMC patches
Date: Sat, 18 Aug 2012 00:22:20 +0530
Message-ID: <1345229550-8672-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55024 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932379Ab2HQSx0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 17 Aug 2012 14:53:26 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, balajitk@ti.com, vishp@ti.com, Venkatraman S <svenkatr@ti.com>

Essentially, a lot of cleanups leading up to adding a new
feature for OMAP HSMMC. The idea is to convert to the use
of software timer instead of IP timer for timekeeping, due
to the limitations of the counting range of the IP timer.

Also added myself as OMAP HSMMC maintainer.

Patch 9/10 is in draft state and needs more testing.

These patches are also available at
  git://github.com/svenkatr/linux.git my/mmc/3.6/hrtimer_updates

Venkatraman S (10):
  mmc: core: Add TRANsfer state to non-HPI state
  mmc: debugfs: Print ext_csd in ascending order
  mmc: omap: remove unused variables and includes
  mmc: omap: fix mmc_omap_report_irq to use dev_dbg macros
  mmc: omap_hsmmc: remove unused vars and includes
  mmc: omap_hsmmc: remove access to SYSCONFIG register
  mmc: omap_hsmmc: consolidate flush posted writes for HSMMC IRQs
  mmc: omap_hsmmc: consolidate error report handling of HSMMC IRQ
  mmc: omap_hsmmc: convert from IP timer to hrtimer
  mmc: omap_hsmmc: Move to Maintained state in MAINTAINERS

 MAINTAINERS                   |   4 +-
 drivers/mmc/core/core.c       |   3 +-
 drivers/mmc/core/debugfs.c    |   2 +-
 drivers/mmc/host/omap.c       |  39 ++++----
 drivers/mmc/host/omap_hsmmc.c | 212 ++++++++++++++++--------------------------
 5 files changed, 103 insertions(+), 157 deletions(-)

-- 
1.7.11.1.25.g0e18bef

