From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 03/03] mmc: Balance tmio-mmc cell enable()/disable() calls
Date: Fri, 27 Nov 2009 14:00:22 +0900
Message-ID: <20091127050022.15251.43017.sendpatchset@rxone.opensource.se>
References: <20091127045956.15251.84958.sendpatchset@rxone.opensource.se>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751537AbZK0FF5@vger.kernel.org>
In-Reply-To: <20091127045956.15251.84958.sendpatchset@rxone.opensource.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, ian@mnementh.co.uk, lethal@linux-sh.org, philipp.zabel@gmail.com, akpm@linux-foundation.org, pierre@ossman.eu
List-Id: linux-mmc@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds cell->disable() calls to the tmio-mmc
probe() error handling and the remove() function.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/mmc/host/tmio_mmc.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- 0016/drivers/mmc/host/tmio_mmc.c
+++ work/drivers/mmc/host/tmio_mmc.c	2009-11-26 19:10:14.000000000 +0900
@@ -577,14 +577,14 @@ static int __devinit tmio_mmc_probe(stru
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
 
@@ -596,6 +596,9 @@ static int __devinit tmio_mmc_probe(stru
 
 	return 0;
 
+cell_disable:
+	if (cell->disable)
+		cell->disable(dev);
 unmap_ctl:
 	iounmap(host->ctl);
 host_free:
@@ -606,6 +609,7 @@ out:
 
 static int __devexit tmio_mmc_remove(struct platform_device *dev)
 {
+	struct mfd_cell	*cell = (struct mfd_cell *)dev->dev.platform_data;
 	struct mmc_host *mmc = platform_get_drvdata(dev);
 
 	platform_set_drvdata(dev, NULL);
@@ -614,6 +618,8 @@ static int __devexit tmio_mmc_remove(str
 		struct tmio_mmc_host *host = mmc_priv(mmc);
 		mmc_remove_host(mmc);
 		free_irq(host->irq, host);
+		if (cell->disable)
+			cell->disable(dev);
 		iounmap(host->ctl);
 		mmc_free_host(mmc);
 	}
