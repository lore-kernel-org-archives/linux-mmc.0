From: Viswanath Puttagunta <vishp@ti.com>
Subject: [PATCH 0/3] mmc:sd hotplug fixes for omap
Date: Thu, 24 May 2012 15:14:24 -0500
Message-ID: <1337890467-32573-1-git-send-email-vishp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59556 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758942Ab2EXUOc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 May 2012 16:14:32 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q4OKEWsu007514
	for <linux-mmc@vger.kernel.org>; Thu, 24 May 2012 15:14:32 -0500
Received: from DFLE70.ent.ti.com (dfle70.ent.ti.com [128.247.5.40])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q4OKEV5Y010818
	for <linux-mmc@vger.kernel.org>; Thu, 24 May 2012 15:14:31 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linux-mmc <linux-mmc@vger.kernel.org>
Cc: T Krishnamoorthy Balaji <balajitk@ti.com>, Venkatraman S <svenkatr@ti.com>, Semen Protsenko <semen.protsenko@ti.com>, Volodymyr Riazantsev <v.riazantsev@ti.com>, Viswanath Puttagunta <vishp@ti.com>

This patch set has fixes for SD card hotplug for OMAP SOCs.

Viswanath Puttagunta (3):
  mmc: omap_hsmmc: Errata i705: SD hot unplug
  mmc: omap_hsmmc: Errata: Fix SD card removal detection
  mfd: Enable Debounce logic for SD hotplug detection

 drivers/mfd/twl6030-irq.c     |    8 ++++++++
 drivers/mmc/host/omap_hsmmc.c |   41 ++++++++++++++++++++++++++++++++++++++---
 include/linux/i2c/twl.h       |    5 +++++
 3 files changed, 51 insertions(+), 3 deletions(-)

-- 
1.7.4.1

