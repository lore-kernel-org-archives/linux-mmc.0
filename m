From: Simon Baatz <gmbnomis@gmail.com>
Subject: [PATCH V2 08/10] mmc: mvsdio: use standard MMC device-tree binding parser mmc_of_parse()
Date: Mon, 13 May 2013 23:18:59 +0200
Message-ID: <1368479941-10084-9-git-send-email-gmbnomis@gmail.com>
References: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:39757 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309Ab3EMVT6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 May 2013 17:19:58 -0400
In-Reply-To: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Instead of parsing the DT binding on our own, use the standard parser
mmc_of_parse(), introduced by commit 6c56e7a.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 drivers/mmc/host/mvsdio.c |   73 +++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 33 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 8960fc8..edfc481 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -35,7 +35,7 @@
 
 #define DRIVER_NAME	"mvsdio"
 
-static int maxfreq = MVSD_CLOCKRATE_MAX;
+static int maxfreq;
 static int nodma;
 
 struct mvsd_host {
@@ -685,7 +685,6 @@ static int __init mvsd_probe(struct platform_device *pdev)
 	const struct mbus_dram_target_info *dram;
 	struct resource *r;
 	int ret, irq;
-	int gpio_card_detect, gpio_write_protect;
 	struct pinctrl *pinctrl;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -718,6 +717,20 @@ static int __init mvsd_probe(struct platform_device *pdev)
 	if (!IS_ERR(host->clk))
 		clk_prepare_enable(host->clk);
 
+	mmc->ops = &mvsd_ops;
+
+	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
+
+	mmc->f_min = DIV_ROUND_UP(host->base_clock, MVSD_BASE_DIV_MAX);
+	mmc->f_max = MVSD_CLOCKRATE_MAX;
+
+	mmc->max_blk_size = 2048;
+	mmc->max_blk_count = 65535;
+
+	mmc->max_segs = 1;
+	mmc->max_seg_size = mmc->max_blk_size * mmc->max_blk_count;
+	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
+
 	if (np) {
 		if (IS_ERR(host->clk)) {
 			dev_err(&pdev->dev, "DT platforms must have a clock associated\n");
@@ -726,35 +739,38 @@ static int __init mvsd_probe(struct platform_device *pdev)
 		}
 
 		host->base_clock = clk_get_rate(host->clk) / 2;
-		gpio_card_detect = of_get_named_gpio(np, "cd-gpios", 0);
-		gpio_write_protect = of_get_named_gpio(np, "wp-gpios", 0);
+		ret = mmc_of_parse(mmc);
+		if (ret < 0)
+			goto out;
 	} else {
 		const struct mvsdio_platform_data *mvsd_data;
+
 		mvsd_data = pdev->dev.platform_data;
 		if (!mvsd_data) {
 			ret = -ENXIO;
 			goto out;
 		}
+		mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SDIO_IRQ |
+			    MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
 		host->base_clock = mvsd_data->clock / 2;
-		gpio_card_detect = mvsd_data->gpio_card_detect ? : -EINVAL;
-		gpio_write_protect = mvsd_data->gpio_write_protect ? : -EINVAL;
-	}
-
-	mmc->ops = &mvsd_ops;
-
-	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
-	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SDIO_IRQ |
-		    MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
-
-	mmc->f_min = DIV_ROUND_UP(host->base_clock, MVSD_BASE_DIV_MAX);
-	mmc->f_max = maxfreq;
+		/* GPIO 0 regarded as invalid for backward compatibility */
+		if (mvsd_data->gpio_card_detect &&
+		    gpio_is_valid(mvsd_data->gpio_card_detect)) {
+			ret = mmc_gpio_request_cd(mmc,
+						  mvsd_data->gpio_card_detect);
+			if (ret)
+				goto out;
+		} else {
+			mmc->caps |= MMC_CAP_NEEDS_POLL;
+		}
 
-	mmc->max_blk_size = 2048;
-	mmc->max_blk_count = 65535;
+		if (mvsd_data->gpio_write_protect &&
+		    gpio_is_valid(mvsd_data->gpio_write_protect))
+			mmc_gpio_request_ro(mmc, mvsd_data->gpio_write_protect);
+	}
 
-	mmc->max_segs = 1;
-	mmc->max_seg_size = mmc->max_blk_size * mmc->max_blk_count;
-	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
+	if (maxfreq)
+		mmc->f_max = maxfreq;
 
 	spin_lock_init(&host->lock);
 
@@ -777,15 +793,6 @@ static int __init mvsd_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	if (gpio_is_valid(gpio_card_detect)) {
-		ret = mmc_gpio_request_cd(mmc, gpio_card_detect);
-		if (ret)
-			goto out;
-	} else
-		mmc->caps |= MMC_CAP_NEEDS_POLL;
-
-	mmc_gpio_request_ro(mmc, gpio_write_protect);
-
 	setup_timer(&host->timer, mvsd_timeout_timer, (unsigned long)host);
 	platform_set_drvdata(pdev, mmc);
 	ret = mmc_add_host(mmc);
@@ -793,10 +800,10 @@ static int __init mvsd_probe(struct platform_device *pdev)
 		goto out;
 
 	if (!(mmc->caps & MMC_CAP_NEEDS_POLL))
-		dev_notice(&pdev->dev, "using GPIO %d for card detection\n",
-			   gpio_card_detect);
+		dev_notice(&pdev->dev, "using GPIO for card detection\n");
 	else
-		dev_notice(&pdev->dev, "lacking card detect (fall back to polling)\n");
+		dev_notice(&pdev->dev,
+			   "lacking card detect (fall back to polling)\n");
 	return 0;
 
 out:
-- 
1.7.9.5

