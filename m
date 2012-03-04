From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/3] sh_mmcif / PM: Use PM QoS requests
Date: Sun, 4 Mar 2012 01:04:49 +0100
Message-ID: <201203040104.50170.rjw@sisk.pl>
References: <201203040101.53177.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:53893 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752933Ab2CDAA6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 3 Mar 2012 19:00:58 -0500
In-Reply-To: <201203040101.53177.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Make sh_mmcif populate the pm_qos_req member of struct mmc_host, to
let the core know that it should create the pm_latency_limit_ms
host attribute for it, and set the defaul value of that attribute
to 100 ms.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/mmc/host/sh_mmcif.c |    9 +++++++++
 1 file changed, 9 insertions(+)

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
 
+	mmc->pm_qos_req = kzalloc(sizeof(*mmc->pm_qos_req), GFP_KERNEL);
+	if (mmc->pm_qos_req)
+		mmc->pm_qos_val = 100;
+	else
+		dev_err(&pdev->dev, "Not enough memory for PM QoS.\n");
+
 	INIT_DELAYED_WORK(&host->timeout_work, mmcif_timeout_work);
 
 	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
@@ -1397,6 +1404,8 @@ static int __devexit sh_mmcif_remove(str
 
 	platform_set_drvdata(pdev, NULL);
 
+	kfree(host->mmc->pm_qos_req);
+
 	clk_disable(host->hclk);
 	mmc_free_host(host->mmc);
 	pm_runtime_put_sync(&pdev->dev);

