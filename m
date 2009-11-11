From: akpm@linux-foundation.org
Subject: [patch 23/35] mmci-omap: free irq resource
Date: Wed, 11 Nov 2009 14:26:43 -0800
Message-ID: <200911112226.nABMQhjl012103@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33832 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758868AbZKKW0y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Nov 2009 17:26:54 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, ladis@linux-mips.org, linux-mmc@vger.kernel.org, tony@atomide.com

From: Ladislav Michl <ladis@linux-mips.org>

Free IRQ on remove.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Acked-by: Tony Lindgren <tony@atomide.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---


diff -puN drivers/mmc/host/omap.c~mmci-omap-free-irq-resource drivers/mmc/host/omap.c
--- a/drivers/mmc/host/omap.c~mmci-omap-free-irq-resource
+++ a/drivers/mmc/host/omap.c
@@ -1529,6 +1529,7 @@ static int mmc_omap_remove(struct platfo
 		host->pdata->cleanup(&pdev->dev);
 
 	mmc_omap_fclk_enable(host, 0);
+	free_irq(host->irq, host);
 	clk_put(host->fclk);
 	clk_disable(host->iclk);
 	clk_put(host->iclk);
_
