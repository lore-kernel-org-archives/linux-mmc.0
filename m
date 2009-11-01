From: Ladislav.Michl@seznam.cz
Subject: [PATCH] mmci-omap: remove bogus check for host->iclk
Date: Sun, 1 Nov 2009 13:03:59 +0100
Message-ID: <20091101120359.GC15144@localhost.localdomain>
Reply-To: Ladislav Michl <ladis@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.seznam.cz ([77.75.72.43]:35337 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751763AbZKALEI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 1 Nov 2009 06:04:08 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-mmc@vger.kernel.org

Remove check for host->iclk being NULL from error path since we already know
it is non-null and use return value from clk_get.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Acked-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 5d773b8..c6d7e8e 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1459,8 +1459,10 @@ static int __init mmc_omap_probe(struct platform_device *pdev)
 		goto err_ioremap;
 
 	host->iclk = clk_get(&pdev->dev, "ick");
-	if (IS_ERR(host->iclk))
+	if (IS_ERR(host->iclk)) {
+		ret = PTR_ERR(host->iclk);
 		goto err_free_mmc_host;
+	}
 	clk_enable(host->iclk);
 
 	host->fclk = clk_get(&pdev->dev, "fck");
@@ -1500,10 +1502,8 @@ err_free_irq:
 err_free_fclk:
 	clk_put(host->fclk);
 err_free_iclk:
-	if (host->iclk != NULL) {
-		clk_disable(host->iclk);
-		clk_put(host->iclk);
-	}
+	clk_disable(host->iclk);
+	clk_put(host->iclk);
 err_free_mmc_host:
 	iounmap(host->virt_base);
 err_ioremap:

