From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [RESEND 4/7] mmc: omap: Remove mem_res field from struct mmc_omap_host
Date: Sat, 22 Feb 2014 18:01:40 +0200
Message-ID: <1393084903-7194-5-git-send-email-jarkko.nikula@bitmer.com>
References: <1393084903-7194-1-git-send-email-jarkko.nikula@bitmer.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1393084903-7194-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-mmc@vger.kernel.org

Field mem_res in struct mmc_omap_host is used only once in mmc_omap_probe
when setting the phys_base field so we may just se the phys_base straight
and remove needless mem_res.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/mmc/host/omap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index b438f0addb3c..0d669cfa6af6 100644
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
1.8.5.3

