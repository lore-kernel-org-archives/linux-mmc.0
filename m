From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 05/05] tmio_mmc: Balance cell enable()/disable() calls
Date: Wed, 17 Feb 2010 16:38:23 +0900
Message-ID: <20100217073823.32726.10307.sendpatchset@t400s>
References: <20100217073735.32726.12020.sendpatchset@t400s>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:61066 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934100Ab0BQHio (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Feb 2010 02:38:44 -0500
In-Reply-To: <20100217073735.32726.12020.sendpatchset@t400s>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: sameo@linux.intel.com, linux-sh@vger.kernel.org, linus.ml.walleij@gmail.com, akpm@linux-foundation.org, goda.yusuke@renesas.com, ian@mnementh.co.uk, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, g.liakhovetski@gmx.de

From: Magnus Damm <damm@opensource.se>

This patch adds cell->disable() calls to the tmio-mmc
probe() error handling and the remove() function.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Previously posted to linux-mmc 20091126 as
 "[PATCH 03/03] mmc: Balance tmio-mmc cell enable()/disable() calls"

 drivers/mmc/host/tmio_mmc.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- 0004/drivers/mmc/host/tmio_mmc.c
+++ work/drivers/mmc/host/tmio_mmc.c	2010-02-17 15:54:01.000000000 +0900
@@ -569,14 +569,14 @@ static int __devinit tmio_mmc_probe(stru
 	if (ret >= 0)
 		host->irq = ret;
 	else
-		goto unmap_ctl;
+		goto cell_disable;
 
 	disable_mmc_irqs(host, TMIO_MASK_ALL);
 
 	ret = request_irq(host->irq, tmio_mmc_irq, IRQF_DISABLED |
 		IRQF_TRIGGER_FALLING, dev_name(&dev->dev), host);
 	if (ret)
-		goto unmap_ctl;
+		goto cell_disable;
 
 	mmc_add_host(mmc);
 
@@ -588,6 +588,9 @@ static int __devinit tmio_mmc_probe(stru
 
 	return 0;
 
+cell_disable:
+	if (cell->disable)
+		cell->disable(dev);
 unmap_ctl:
 	iounmap(host->ctl);
 host_free:
@@ -598,6 +601,7 @@ out:
 
 static int __devexit tmio_mmc_remove(struct platform_device *dev)
 {
+	struct mfd_cell	*cell = (struct mfd_cell *)dev->dev.platform_data;
 	struct mmc_host *mmc = platform_get_drvdata(dev);
 
 	platform_set_drvdata(dev, NULL);
@@ -606,6 +610,8 @@ static int __devexit tmio_mmc_remove(str
 		struct tmio_mmc_host *host = mmc_priv(mmc);
 		mmc_remove_host(mmc);
 		free_irq(host->irq, host);
+		if (cell->disable)
+			cell->disable(dev);
 		iounmap(host->ctl);
 		mmc_free_host(mmc);
 	}
