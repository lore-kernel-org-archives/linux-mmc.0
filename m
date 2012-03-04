From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/3] sh_mmcif / PM: Use PM QoS requests, v2
Date: Sun, 4 Mar 2012 20:56:56 +0100
Message-ID: <201203042056.57012.rjw@sisk.pl>
References: <201203040101.53177.rjw@sisk.pl> <201203042053.19314.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54417 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754806Ab2CDTxK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 4 Mar 2012 14:53:10 -0500
In-Reply-To: <201203042053.19314.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Make sh_mmcif populate the pm_qos member of struct mmc_host, to
let the core know that it should create the pm_latency_limit_ms
host attribute for it, and set the default value of that attribute
to 100 ms.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/mmc/host/sh_mmcif.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

Index: linux/drivers/mmc/host/sh_mmcif.c
===================================================================
--- linux.orig/drivers/mmc/host/sh_mmcif.c
+++ linux/drivers/mmc/host/sh_mmcif.c
@@ -57,6 +57,7 @@
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/module.h>
 
@@ -1327,6 +1328,12 @@ static int __devinit sh_mmcif_probe(stru
 	if (ret < 0)
 		goto clean_up2;
 
+	mmc->pm_qos = kzalloc(sizeof(*mmc->pm_qos), GFP_KERNEL);
+	if (mmc->pm_qos)
+		mmc->pm_qos->val = 100;
+	else
+		dev_err(&pdev->dev, "Not enough memory for PM QoS.\n");
+
 	INIT_DELAYED_WORK(&host->timeout_work, mmcif_timeout_work);
 
 	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
@@ -1356,6 +1363,7 @@ clean_up5:
 clean_up4:
 	free_irq(irq[0], host);
 clean_up3:
+	kfree(mmc->pm_qos);
 	pm_runtime_suspend(&pdev->dev);
 clean_up2:
 	pm_runtime_disable(&pdev->dev);
@@ -1397,6 +1405,8 @@ static int __devexit sh_mmcif_remove(str
 
 	platform_set_drvdata(pdev, NULL);
 
+	kfree(host->mmc->pm_qos);
+
 	clk_disable(host->hclk);
 	mmc_free_host(host->mmc);
 	pm_runtime_put_sync(&pdev->dev);

