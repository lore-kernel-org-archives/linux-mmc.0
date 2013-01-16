From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 07/11] mmc: tmio-mmc: parse device-tree bindings
Date: Wed, 16 Jan 2013 17:54:42 +0100
Message-ID: <1358355286-26029-8-git-send-email-g.liakhovetski@gmx.de>
References: <1358355286-26029-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1358355286-26029-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Add parsing of common and driver-specific DT bindings to the tmio-mmc
MMC host driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc_pio.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index b25adb4..84582b3 100644
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
-- 
1.7.2.5

