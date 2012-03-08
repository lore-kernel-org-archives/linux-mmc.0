From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Update][PATCH 3/3] sh_mmcif / PM: Use PM QoS latency constraint
Date: Fri, 9 Mar 2012 00:03:52 +0100
Message-ID: <201203090003.52635.rjw@sisk.pl>
References: <201203040101.53177.rjw@sisk.pl> <201203080027.27435.rjw@sisk.pl> <201203090000.17664.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:34582 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752456Ab2CHXAa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Mar 2012 18:00:30 -0500
In-Reply-To: <201203090000.17664.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux MMC list <linux-mmc@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Make sh_mmcif call dev_pm_qos_expose_latency_limit() to expose
the PM QoS latency limit to user space and specify the initial
value of it as 100 microseconds.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/mmc/host/sh_mmcif.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux/drivers/mmc/host/sh_mmcif.c
===================================================================
--- linux.orig/drivers/mmc/host/sh_mmcif.c
+++ linux/drivers/mmc/host/sh_mmcif.c
@@ -56,6 +56,7 @@
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
+#include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
 #include <linux/module.h>
@@ -1346,6 +1347,8 @@ static int __devinit sh_mmcif_probe(stru
 	if (ret < 0)
 		goto clean_up5;
 
+	dev_pm_qos_expose_latency_limit(&pdev->dev, 100);
+
 	dev_info(&pdev->dev, "driver version %s\n", DRIVER_VERSION);
 	dev_dbg(&pdev->dev, "chip ver H'%04x\n",
 		sh_mmcif_readl(host->addr, MMCIF_CE_VERSION) & 0x0000ffff);
@@ -1376,6 +1379,8 @@ static int __devexit sh_mmcif_remove(str
 	host->dying = true;
 	pm_runtime_get_sync(&pdev->dev);
 
+	dev_pm_qos_hide_latency_limit(&pdev->dev);
+
 	mmc_remove_host(host->mmc);
 	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
 

