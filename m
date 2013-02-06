From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v3 07/13] mmc: tmio-mmc: parse device-tree bindings
Date: Wed,  6 Feb 2013 20:46:54 +0100
Message-ID: <1360180020-18555-8-git-send-email-g.liakhovetski@gmx.de>
References: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:62473 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757990Ab3BFTrL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Feb 2013 14:47:11 -0500
In-Reply-To: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Arnd Bergmann <arnd@arndb.de>

Add parsing of common and driver-specific DT bindings to the tmio-mmc
MMC host driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Arnd Bergmann <arnd@arndb.de>
---

v3: remove the "toshiba,mmc-cap-sdio-irq" property

 drivers/mmc/host/tmio_mmc_pio.c |   24 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index b25adb4..e32e9b4 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -918,6 +918,21 @@ static void tmio_mmc_init_ocr(struct tmio_mmc_host *host)
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
+	if (of_get_property(np, "toshiba,mmc-has-idle-wait", NULL))
+		pdata->flags |= TMIO_MMC_HAS_IDLE_WAIT;
+}
+
 int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 				  struct platform_device *pdev,
 				  struct tmio_mmc_data *pdata)
@@ -928,6 +943,8 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	int ret;
 	u32 irq_mask = TMIO_MASK_CMD;
 
+	tmio_mmc_of_parse(pdev, pdata);
+
 	if (!(pdata->flags & TMIO_MMC_HAS_IDLE_WAIT))
 		pdata->write16_hook = NULL;
 
@@ -939,6 +956,8 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	if (!mmc)
 		return -ENOMEM;
 
+	mmc_of_parse(mmc);
+
 	pdata->dev = &pdev->dev;
 	_host = mmc_priv(mmc);
 	_host->pdata = pdata;
@@ -959,7 +978,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	}
 
 	mmc->ops = &tmio_mmc_ops;
-	mmc->caps = MMC_CAP_4_BIT_DATA | pdata->capabilities;
+	mmc->caps |= MMC_CAP_4_BIT_DATA | pdata->capabilities;
 	mmc->caps2 = pdata->capabilities2;
 	mmc->max_segs = 32;
 	mmc->max_blk_size = 512;
@@ -971,7 +990,8 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 
 	_host->native_hotplug = !(pdata->flags & TMIO_MMC_USE_GPIO_CD ||
 				  mmc->caps & MMC_CAP_NEEDS_POLL ||
-				  mmc->caps & MMC_CAP_NONREMOVABLE);
+				  mmc->caps & MMC_CAP_NONREMOVABLE ||
+				  mmc->slot.cd_irq >= 0);
 
 	_host->power = false;
 	pm_runtime_enable(&pdev->dev);
-- 
1.7.2.5

