From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH 4/7] mmc: omap: Remove mem_res field from struct mmc_omap_host
Date: Wed,  4 Dec 2013 21:14:11 +0000
Message-ID: <1386191654-7686-5-git-send-email-jarkko.nikula@bitmer.com>
References: <20131202193459.GL26766@atomide.com>
 <1386191654-7686-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:48194 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756010Ab3LDTOc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 4 Dec 2013 14:14:32 -0500
In-Reply-To: <1386191654-7686-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Dan Carpenter <dan.carpenter@oracle.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Jarkko Lavinen <j.lavinen@samsung.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>

Field mem_res in struct mmc_omap_host is used only once in mmc_omap_probe
when setting the phys_base field so we may just se the phys_base straight
and remove needless mem_res.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
 drivers/mmc/host/omap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index b438f0a..0d669cf 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -130,7 +130,6 @@ struct mmc_omap_host {
 	u32			dma_rx_burst;
 	struct dma_chan		*dma_tx;
 	u32			dma_tx_burst;
-	struct resource		*mem_res;
 	void __iomem		*virt_base;
 	unsigned int		phys_base;
 	int			irq;
@@ -1372,10 +1371,9 @@ static int mmc_omap_probe(struct platform_device *pdev)
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
1.8.4.3

