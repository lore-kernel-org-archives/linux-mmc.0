From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 25/29] mmc: tmio: add OF support
Date: Thu,  3 May 2012 17:05:54 +0200
Message-ID: <1336057558-11031-26-git-send-email-g.liakhovetski@gmx.de>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:53182 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757452Ab2ECPGE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 May 2012 11:06:04 -0400
In-Reply-To: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>

Add OF support to the TMIO MMC to parse both standard and driver-specific
properties.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/mmc/host/tmio_mmc_pio.c |   39 ++++++++++++++++++++++++++++++++++++---
 1 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 85daa53..efa7bde 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -39,6 +39,7 @@
 #include <linux/mmc/slot-gpio.h>
 #include <linux/mmc/tmio.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
 #include <linux/pm_qos.h>
@@ -905,7 +906,7 @@ static const struct mmc_host_ops tmio_mmc_ops = {
 	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
 };
 
-static void tmio_mmc_init_ocr(struct tmio_mmc_host *host)
+static void __devinit tmio_mmc_init_ocr(struct tmio_mmc_host *host)
 {
 	struct tmio_mmc_data *pdata = host->pdata;
 	struct mmc_host *mmc = host->mmc;
@@ -923,6 +924,22 @@ static void tmio_mmc_init_ocr(struct tmio_mmc_host *host)
 		mmc->ocr_avail = pdata->ocr_mask ? : MMC_VDD_32_33 | MMC_VDD_33_34;
 }
 
+static void __devinit tmio_mmc_parse_of(struct tmio_mmc_host *host)
+{
+	struct device_node *node = host->pdev->dev.of_node;
+	struct tmio_mmc_data *pdata = host->pdata;
+
+	if (!node || !of_device_is_available(node))
+		return;
+
+	if (of_get_property(node, "tmio,high_speed", NULL))
+		pdata->capabilities |= MMC_CAP_SD_HIGHSPEED;
+	if (of_get_property(node, "tmio,wrprotect_disable", NULL))
+		pdata->flags |= TMIO_MMC_WRPROTECT_DISABLE;
+	if (of_get_property(node, "tmio,idle_wait", NULL))
+		pdata->flags |= TMIO_MMC_HAS_IDLE_WAIT;
+}
+
 int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 				  struct platform_device *pdev,
 				  struct tmio_mmc_data *pdata)
@@ -960,8 +977,19 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 		goto host_free;
 	}
 
+	tmio_mmc_parse_of(_host);
+	/*
+	 * After OF parsing we have 3 possibilities:
+	 * 1. mmc->slot.cd_irq >= 0	- an IRQ-capable GPIO has been found and
+	 *				  an ISR has been installed
+	 * 2. MMC_CAP_NEEDS_POLL	- a GPIO has been found, polling will be
+	 *				  used
+	 * 3. none of the above		- no usable GPIO CD has been detected
+	 */
+	mmc_of_get(mmc);
+
 	mmc->ops = &tmio_mmc_ops;
-	mmc->caps = MMC_CAP_4_BIT_DATA | pdata->capabilities;
+	mmc->caps |= MMC_CAP_4_BIT_DATA | pdata->capabilities;
 	mmc->max_segs = 32;
 	mmc->max_blk_size = 512;
 	mmc->max_blk_count = (PAGE_CACHE_SIZE / mmc->max_blk_size) *
@@ -972,7 +1000,8 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 
 	_host->native_hotplug = !(pdata->flags & TMIO_MMC_USE_GPIO_CD ||
 				  mmc->caps & MMC_CAP_NEEDS_POLL ||
-				  mmc->caps & MMC_CAP_NONREMOVABLE);
+				  mmc->caps & MMC_CAP_NONREMOVABLE ||
+				  mmc->slot.cd_irq >= 0);
 
 	_host->power = false;
 	pm_runtime_enable(&pdev->dev);
@@ -1053,6 +1082,7 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 
 pm_disable:
 	pm_runtime_disable(&pdev->dev);
+	mmc_of_put(mmc);
 	iounmap(_host->ctl);
 host_free:
 	mmc_free_host(mmc);
@@ -1074,6 +1104,9 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 		 */
 		mmc_gpio_free_cd(mmc);
 
+	/* This will disable OF-configured card-detection, do early */
+	mmc_of_put(mmc);
+
 	if (!host->native_hotplug)
 		pm_runtime_get_sync(&pdev->dev);
 
-- 
1.7.2.5

