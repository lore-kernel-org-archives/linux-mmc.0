From: Axel Haslam <ahaslam@baylibre.com>
Subject: [PATCH 1/2] MMC: davinci: use mmc_of_parse to parse common mmc configuration
Date: Tue, 15 Nov 2016 17:28:21 +0100
Message-ID: <20161115162822.25791-2-ahaslam@baylibre.com>
References: <20161115162822.25791-1-ahaslam@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161115162822.25791-1-ahaslam@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, nsekhar@ti.com, khilman@baylibre.com, david@lechnology.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>
List-Id: linux-mmc@vger.kernel.org

Card detect and write protect are currently not working on a DT
boot, and the driver relies on polling to get the state
of the card. The current code depends on platform data callbacks
to register and get the state of the gpios.

mmc core provides a generic way to parse device tree configuration,
which will take care of registering the gpios for us, lets use it
so that we don't need to poll, and parse the same properties.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/mmc/host/davinci_mmc.c | 119 +++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 64 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 8fa478c..619e50e 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -35,6 +35,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/mmc/slot-gpio.h>
 
 #include <linux/platform_data/mmc-davinci.h>
 
@@ -1029,9 +1030,10 @@ static int mmc_davinci_get_cd(struct mmc_host *mmc)
 	struct platform_device *pdev = to_platform_device(mmc->parent);
 	struct davinci_mmc_config *config = pdev->dev.platform_data;
 
-	if (!config || !config->get_cd)
-		return -ENOSYS;
-	return config->get_cd(pdev->id);
+	if (config && config->get_cd)
+		return config->get_cd(pdev->id);
+
+	return mmc_gpio_get_cd(mmc);
 }
 
 static int mmc_davinci_get_ro(struct mmc_host *mmc)
@@ -1039,9 +1041,10 @@ static int mmc_davinci_get_ro(struct mmc_host *mmc)
 	struct platform_device *pdev = to_platform_device(mmc->parent);
 	struct davinci_mmc_config *config = pdev->dev.platform_data;
 
-	if (!config || !config->get_ro)
-		return -ENOSYS;
-	return config->get_ro(pdev->id);
+	if (config && config->get_ro)
+		return config->get_ro(pdev->id);
+
+	return mmc_gpio_get_ro(mmc);
 }
 
 static void mmc_davinci_enable_sdio_irq(struct mmc_host *mmc, int enable)
@@ -1159,49 +1162,42 @@ static const struct of_device_id davinci_mmc_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, davinci_mmc_dt_ids);
 
-static struct davinci_mmc_config
-	*mmc_parse_pdata(struct platform_device *pdev)
+static int mmc_davinci_parse_pdata(struct mmc_host *mmc)
 {
-	struct device_node *np;
+	struct platform_device *pdev = to_platform_device(mmc->parent);
 	struct davinci_mmc_config *pdata = pdev->dev.platform_data;
-	const struct of_device_id *match =
-		of_match_device(davinci_mmc_dt_ids, &pdev->dev);
-	u32 data;
-
-	np = pdev->dev.of_node;
-	if (!np)
-		return pdata;
-
-	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata) {
-		dev_err(&pdev->dev, "Failed to allocate memory for struct davinci_mmc_config\n");
-		goto nodata;
-	}
+	struct mmc_davinci_host *host;
 
-	if (match)
-		pdev->id_entry = match->data;
+	if (!pdata)
+		return -EINVAL;
 
-	if (of_property_read_u32(np, "max-frequency", &pdata->max_freq))
-		dev_info(&pdev->dev, "'max-frequency' property not specified, defaulting to 25MHz\n");
+	host = mmc_priv(mmc);
+	if (!host)
+		return -EINVAL;
 
-	of_property_read_u32(np, "bus-width", &data);
-	switch (data) {
-	case 1:
-	case 4:
-	case 8:
-		pdata->wires = data;
-		break;
-	default:
-		pdata->wires = 1;
-		dev_info(&pdev->dev, "Unsupported buswidth, defaulting to 1 bit\n");
-	}
-nodata:
-	return pdata;
+	if (pdata && pdata->nr_sg)
+		host->nr_sg = pdata->nr_sg - 1;
+
+	if (pdata && (pdata->wires == 4 || pdata->wires == 0))
+		mmc->caps |= MMC_CAP_4_BIT_DATA;
+
+	if (pdata && (pdata->wires == 8))
+		mmc->caps |= (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA);
+
+	mmc->caps |= MMC_CAP_NEEDS_POLL;
+	mmc->f_min = 312500;
+	mmc->f_max = 25000000;
+	if (pdata && pdata->max_freq)
+		mmc->f_max = pdata->max_freq;
+	if (pdata && pdata->caps)
+		mmc->caps |= pdata->caps;
+
+	return 0;
 }
 
 static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 {
-	struct davinci_mmc_config *pdata = NULL;
+	const struct of_device_id *match;
 	struct mmc_davinci_host *host = NULL;
 	struct mmc_host *mmc = NULL;
 	struct resource *r, *mem = NULL;
@@ -1209,12 +1205,6 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 	size_t mem_size;
 	const struct platform_device_id *id_entry;
 
-	pdata = mmc_parse_pdata(pdev);
-	if (pdata == NULL) {
-		dev_err(&pdev->dev, "Couldn't get platform data\n");
-		return -ENOENT;
-	}
-
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r)
 		return -ENODEV;
@@ -1253,14 +1243,28 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 
 	host->mmc_input_clk = clk_get_rate(host->clk);
 
-	init_mmcsd_host(host);
-
-	if (pdata->nr_sg)
-		host->nr_sg = pdata->nr_sg - 1;
+	match = of_match_device(davinci_mmc_dt_ids, &pdev->dev);
+	if (match) {
+		pdev->id_entry = match->data;
+		ret = mmc_of_parse(mmc);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"could not parse of data: %d\n", ret);
+			goto parse_fail;
+		}
+	} else {
+		ret = mmc_davinci_parse_pdata(mmc);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"could not parse platform data: %d\n", ret);
+			goto parse_fail;
+	}	}
 
 	if (host->nr_sg > MAX_NR_SG || !host->nr_sg)
 		host->nr_sg = MAX_NR_SG;
 
+	init_mmcsd_host(host);
+
 	host->use_dma = use_dma;
 	host->mmc_irq = irq;
 	host->sdio_irq = platform_get_irq(pdev, 1);
@@ -1273,27 +1277,13 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 			host->use_dma = 0;
 	}
 
-	/* REVISIT:  someday, support IRQ-driven card detection.  */
-	mmc->caps |= MMC_CAP_NEEDS_POLL;
 	mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
 
-	if (pdata && (pdata->wires == 4 || pdata->wires == 0))
-		mmc->caps |= MMC_CAP_4_BIT_DATA;
-
-	if (pdata && (pdata->wires == 8))
-		mmc->caps |= (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA);
-
 	id_entry = platform_get_device_id(pdev);
 	if (id_entry)
 		host->version = id_entry->driver_data;
 
 	mmc->ops = &mmc_davinci_ops;
-	mmc->f_min = 312500;
-	mmc->f_max = 25000000;
-	if (pdata && pdata->max_freq)
-		mmc->f_max = pdata->max_freq;
-	if (pdata && pdata->caps)
-		mmc->caps |= pdata->caps;
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 
 	/* With no iommu coalescing pages, each phys_seg is a hw_seg.
@@ -1354,6 +1344,7 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
 	mmc_davinci_cpufreq_deregister(host);
 cpu_freq_fail:
 	davinci_release_dma_channels(host);
+parse_fail:
 dma_probe_defer:
 	clk_disable_unprepare(host->clk);
 clk_prepare_enable_fail:
-- 
2.10.1
