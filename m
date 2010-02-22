From: David Vrabel <david.vrabel@csr.com>
Subject: [PATCH 0/2] mmc: omap_hsmmc: support SDIO cards (#2)
Date: Mon, 22 Feb 2010 14:24:17 +0000
Message-ID: <cover.1266847842.git.david.vrabel@csr.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33559 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191Ab0BVOYl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 22 Feb 2010 09:24:41 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, madhu.cr@ti.com, David Vrabel <david.vrabel@csr.com>

These patches add support for SDIO cards to the omap_hsmmc driver.
Power management changes to prevent SDIO cards from being turned off
and losing all state, and card interrupts.

I've been unable to test these exact patches as I only have an N900 for 
testing and the N900 support in mainline is incomplete.

Changes since v1:
- (hopefully) get all cards working again by removing a second call to
  read MMCi_STAT in the interrupt handler.
- flush posted writes after enabling/disabling SDIO interrupts.
- tweak the FIXME commit on disabling FCLK to better match what really
  going on (at least I think so anyway).

David Vrabel (2):
  mmc: omap_hsmmc: don't turn SDIO cards off when idle
  mmc: omap_hsmmc: enable SDIO card interrupts

 drivers/mmc/host/omap_hsmmc.c |  114 ++++++++++++++++++++++++++++-------------
 1 files changed, 79 insertions(+), 35 deletions(-)

