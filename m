From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 0/5] mmc: omap_hsmmc: Few patches for omap_hsmmc
Date: Tue, 6 Nov 2012 22:22:11 +0530
Message-ID: <1352220737-14071-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37406 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866Ab2KFQwc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 6 Nov 2012 11:52:32 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Venkatraman S <svenkatr@ti.com>

Hi Chris,
  Please review and merge the below patches.
The first one is a bug fix that would be required to be sent
for 3.7-rcX, others are intended for 3.8.

Thanks,
Venkat.
=============

Felipe Balbi (1):
  mmc: omap_hsmmc: introduce omap_hsmmc_prepare/complete

Hebbar, Gururaja (1):
  mmc: omap_hsmmc: Enable HSPE bit for high speed cards

Venkatraman S (3):
  mmc: omap_hsmmc: Avoid host->cmd dereference during data transfer    
    failures
  mmc: omap_hsmmc: cleanup the bitmap definitions of Interrupt Register
  mmc: omap_hsmmc: convert critical failure reports to dev_err

 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   1 +
 arch/arm/plat-omap/include/plat/mmc.h              |   1 +
 drivers/mmc/host/omap_hsmmc.c                      | 143 +++++++++++++--------
 3 files changed, 94 insertions(+), 51 deletions(-)

-- 
1.8.0

