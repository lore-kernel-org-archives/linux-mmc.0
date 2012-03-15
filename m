From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH RESEND 8/8] mmc: omap4: hsmmc: fix module re-insertion
Date: Thu, 15 Mar 2012 20:03:42 +0530
Message-ID: <1331822022-26714-9-git-send-email-svenkatr@ti.com>
References: <y>
 <1331822022-26714-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53284 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761104Ab2COOfA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 15 Mar 2012 10:35:00 -0400
In-Reply-To: <1331822022-26714-1-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, balajitk@ti.com, balbi@ti.com

From: Balaji T K <balajitk@ti.com>

OMAP4 and OMAP3 HSMMC IP registers differ by 0x100 offset.
Addng the offset to platform_device resource structure
increments the start address for every insmod operation.
MMC command fails on re-insertion as module due to incorrect register base.
Fix this by updating the ioremap base address only.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4476b26..f324cf4 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1813,8 +1813,6 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	if (res == NULL || irq < 0)
 		return -ENXIO;
 
-	res->start += pdata->reg_offset;
-	res->end += pdata->reg_offset;
 	res = request_mem_region(res->start, resource_size(res), pdev->name);
 	if (res == NULL)
 		return -EBUSY;
@@ -1838,7 +1836,7 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 	host->dma_ch	= -1;
 	host->irq	= irq;
 	host->slot_id	= 0;
-	host->mapbase	= res->start;
+	host->mapbase	= res->start + pdata->reg_offset;
 	host->base	= ioremap(host->mapbase, SZ_4K);
 	host->power_mode = MMC_POWER_OFF;
 	host->flags	= AUTO_CMD12;
-- 
1.7.10.rc0.41.gfa678

