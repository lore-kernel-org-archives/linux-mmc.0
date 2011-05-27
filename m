From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: sdhi: fix module unloading
Date: Fri, 27 May 2011 16:54:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105271650380.29270@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

MMC host drivers must be able to process interrupts during
mmc_remove_host().

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index c1c1386..ce500f0 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -165,13 +165,14 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 
 	p->pdata = NULL;
 
+	tmio_mmc_host_remove(host);
+
 	for (i = 0; i < 3; i++) {
 		irq = platform_get_irq(pdev, i);
 		if (irq >= 0)
 			free_irq(irq, host);
 	}
 
-	tmio_mmc_host_remove(host);
 	clk_disable(priv->clk);
 	clk_put(priv->clk);
 	kfree(priv);
-- 
1.7.2.5

