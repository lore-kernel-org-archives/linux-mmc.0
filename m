From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH FIX+RESEND 4/7] mmc: omap: Remove mem_res field from struct mmc_omap_host
Date: Sun,  6 Oct 2013 20:36:15 +0300
Message-ID: <1381080978-29127-4-git-send-email-jarkko.nikula@bitmer.com>
References: <1381080978-29127-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:46796 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753947Ab3JFRil (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 6 Oct 2013 13:38:41 -0400
In-Reply-To: <1381080978-29127-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, aaro.koskinen@iki.fi, Jarkko Nikula <jarkko.nikula@bitmer.com>

Field mem_res in struct mmc_omap_host is used only once in mmc_omap_probe
when setting the phys_base field so we may just se the phys_base straight
and remove needless mem_res.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 drivers/mmc/host/omap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 7668d47..ec5defa 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -141,7 +141,6 @@ struct mmc_omap_host {
 	u32			dma_rx_burst;
 	struct dma_chan		*dma_tx;
 	u32			dma_tx_burst;
-	struct resource		*mem_res;
 	void __iomem		*virt_base;
 	unsigned int		phys_base;
 	int			irq;
@@ -1383,10 +1382,9 @@ static int mmc_omap_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, host);
 
 	host->id = pdev->id;
-	host->mem_res = res;
 	host->irq = irq;
 	host->use_dma = 1;
-	host->phys_base = host->mem_res->start;
+	host->phys_base = res->start;
 	host->virt_base = ioremap(res->start, resource_size(res));
 	if (!host->virt_base)
 		goto err_ioremap;
-- 
1.8.4.rc3

