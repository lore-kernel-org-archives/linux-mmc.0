From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/3] tmio_mmc / PM: Use PM QoS latency constraint
Date: Thu, 8 Mar 2012 00:29:50 +0100
Message-ID: <201203080029.51225.rjw@sisk.pl>
References: <201203040101.53177.rjw@sisk.pl> <201203042053.19314.rjw@sisk.pl> <201203080027.27435.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:32885 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753964Ab2CGX0i (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 7 Mar 2012 18:26:38 -0500
In-Reply-To: <201203080027.27435.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux MMC list <linux-mmc@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Make tmio_mmc call dev_pm_qos_expose_latency_limit() to expose
the PM QoS latency limit to user space and specify the initial
value of it as 100 microseconds.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/mmc/host/tmio_mmc_pio.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux/drivers/mmc/host/tmio_mmc_pio.c
===================================================================
--- linux.orig/drivers/mmc/host/tmio_mmc_pio.c
+++ linux/drivers/mmc/host/tmio_mmc_pio.c
@@ -39,6 +39,7 @@
 #include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
+#include <linux/pm_qos.h>
 #include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
 #include <linux/spinlock.h>
@@ -955,6 +956,8 @@ int __devinit tmio_mmc_host_probe(struct
 
 	mmc_add_host(mmc);
 
+	dev_pm_qos_expose_latency_limit(&pdev->dev, 100);
+
 	/* Unmask the IRQs we want to know about */
 	if (!_host->chan_rx)
 		irq_mask |= TMIO_MASK_READOP;
@@ -993,6 +996,8 @@ void tmio_mmc_host_remove(struct tmio_mm
 		|| host->mmc->caps & MMC_CAP_NONREMOVABLE)
 		pm_runtime_get_sync(&pdev->dev);
 
+	dev_pm_qos_hide_latency_limit(&pdev->dev);
+
 	mmc_remove_host(host->mmc);
 	cancel_work_sync(&host->done);
 	cancel_delayed_work_sync(&host->delayed_reset_work);

