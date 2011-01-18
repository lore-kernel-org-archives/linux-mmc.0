From: Kishore Kadiyala <kishore.kadiyala@ti.com>
Subject: [PATCH 0/4] omap4: hsmmc: Adding ADMA support
Date: Tue, 18 Jan 2011 22:56:27 +0530
Message-ID: <1295371591-13610-1-git-send-email-kishore.kadiyala@ti.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59487 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab1ARRUG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jan 2011 12:20:06 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, Kishore Kadiyala <kishore.kadiyala@ti.com>

This patch series adds support for ADMA on MMC1 & MMC2 controllers on OMAP4.
There is no performance improvement observed using ADMA over SDMA.
Advantage using ADMA could be reducing contention over SDMA.
Also the series includes some cleanup.

The series is based on 2.6.37-rc8 and tested on OMAP4430SDP & OMAP3430SDP.


Kishore Kadiyala (4):
  omap: hsmmc: Rename use_dma to xfer_type and define possible
    transfers
  omap: hsmmc: Rename and cleanup omap_hsmmc_dma_cleanup
  omap4: hsmmc: Adding ADMA support for MMC1 & MMC2 controllers
  omap4: hsmmc: enable ADMA for MMC1 & MMC2

 arch/arm/mach-omap2/hsmmc.c           |   13 ++-
 arch/arm/plat-omap/include/plat/mmc.h |    1 +
 drivers/mmc/host/omap_hsmmc.c         |  241 +++++++++++++++++++++++++++------
 3 files changed, 210 insertions(+), 45 deletions(-)

