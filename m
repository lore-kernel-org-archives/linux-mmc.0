From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v2 07/11] mmc: tmio-mmc: parse device-tree bindings
Date: Wed, 23 Jan 2013 16:32:34 +0100
Message-ID: <1358955158-1510-8-git-send-email-g.liakhovetski@gmx.de>
References: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:51561 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755893Ab3AWPkS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Jan 2013 10:40:18 -0500
In-Reply-To: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Add parsing of common and driver-specific DT bindings to the tmio-mmc
MMC host driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2: check, if DT assigned a card-detect IRQ, in which case don't enable TMIO 
native CD IRQ.

 drivers/mmc/host/tmio_mmc_pio.c |   27 +++++++++++++++++++++++++--
 1 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index b25adb4..13729b6 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -918,6 +918,24 @@ static void tmio_mmc_init_ocr(struct tmio_mmc_host *host)
 		dev_warn(mmc_dev(mmc), "Platform OCR mask is ignored\n");
 }
 
+static void tmio_mmc_of_parse(struct platform_device *pdev,
+			      struct tmio_mmc_data *pdata)
+{
+	const struct device_node *np = pdev->dev.of_node;
+	if (!np)
+		return;
+
+	if (of_get_property(np, "toshiba,mmc-wrprotect-disable", NULL))
+		pdata->flags |= TMIO_MMC_WRPROTECT_DISABLE;
+	if (of_get_property(np, "toshiba,mmc-blksz-2bytes", NULL))
+		pdata->flags |= TMIO_MMC_BLKSZ_2BYTES;
+	if (of_get_property(np, "toshiba,mmc-cap-sdio-irq", NULL) &&
+	    pdata->flags & TMIO_MMC_SDIO_IRQ)
+		pdata->capabilities |= MMC_CAP_SDIO_IRQ;
+	if (of_get_property(np, "toshiba,mmc-has-idle-wait", NULL))
+		pdata->flags |= TMIO_MMC_HAS_IDLE_WAIT;
+}
+
 int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 				  struct platform_device *pdev,
 				  struct tmio_mmc_data *pdata)
@@ -928,6 +946,8 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	int ret;
 	u32 irq_mask = TMIO_MASK_CMD;
 
+	tmio_mmc_of_parse(pdev, pdata);
+
 	if (!(pdata->flags & TMIO_MMC_HAS_IDLE_WAIT))
 		pdata->write16_hook = NULL;
 
@@ -939,6 +959,8 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	if (!mmc)
 		return -ENOMEM;
 
+	mmc_of_parse(mmc);
+
 	pdata->dev = &pdev->dev;
 	_host = mmc_priv(mmc);
 	_host->pdata = pdata;
@@ -959,7 +981,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	}
 
 	mmc->ops = &tmio_mmc_ops;
-	mmc->caps = MMC_CAP_4_BIT_DATA | pdata->capabilities;
+	mmc->caps |= MMC_CAP_4_BIT_DATA | pdata->capabilities;
 	mmc->caps2 = pdata->capabilities2;
 	mmc->max_segs = 32;
 	mmc->max_blk_size = 512;
@@ -971,7 +993,8 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 
 	_host->native_hotplug = !(pdata->flags & TMIO_MMC_USE_GPIO_CD ||
 				  mmc->caps & MMC_CAP_NEEDS_POLL ||
-				  mmc->caps & MMC_CAP_NONREMOVABLE);
+				  mmc->caps & MMC_CAP_NONREMOVABLE ||
+				  mmc->slot.cd_irq >= 0);
 
 	_host->power = false;
 	pm_runtime_enable(&pdev->dev);
-- 
1.7.2.5

