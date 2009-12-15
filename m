From: akpm@linux-foundation.org
Subject: [patch 174/196] mmci-omap: remove bogus check for host->iclk
Date: Mon, 14 Dec 2009 18:01:24 -0800
Message-ID: <200912150201.nBF21OGw022589@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37787 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758638AbZLOCMj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Dec 2009 21:12:39 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, ladis@linux-mips.org, linux-mmc@vger.kernel.org, tony@atomide.com

From: Ladislav Michl <ladis@linux-mips.org>

Remove check for host->iclk being NULL from error path since we already
know it is non-null and use return value from clk_get.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Acked-by: Tony Lindgren <tony@atomide.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/omap.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff -puN drivers/mmc/host/omap.c~mmci-omap-remove-bogus-check-for-host-iclk drivers/mmc/host/omap.c
--- a/drivers/mmc/host/omap.c~mmci-omap-remove-bogus-check-for-host-iclk
+++ a/drivers/mmc/host/omap.c
@@ -1459,8 +1459,10 @@ static int __init mmc_omap_probe(struct 
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
_
