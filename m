From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 1/2] mmc: mxcmmc: Convert to devm-* API
Date: Sat, 22 Feb 2014 18:46:11 +0400
Message-ID: <1393080372-6760-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fallback5.mail.ru ([94.100.176.59]:40098 "EHLO
	fallback5.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbaBVOqt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Feb 2014 09:46:49 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Alexander Shiyan <shc_work@mail.ru>

Replace existing resource handling in the driver with managed
device resource, this ensures more consistent error values and
simplifies error paths.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/mmc/host/mxcmmc.c | 101 +++++++++++++++++-----------------------------
 1 file changed, 38 insertions(+), 63 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index f7199c8..84d630e 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -124,9 +124,8 @@ enum mxcmci_type {
 
 struct mxcmci_host {
 	struct mmc_host		*mmc;
-	struct resource		*res;
 	void __iomem		*base;
-	int			irq;
+	dma_addr_t		phys_base;
 	int			detect_irq;
 	struct dma_chan		*dma;
 	struct dma_async_tx_descriptor *desc;
@@ -241,33 +240,26 @@ static inline void mxcmci_writew(struct mxcmci_host *host, u16 val, int reg)
 
 static void mxcmci_set_clk_rate(struct mxcmci_host *host, unsigned int clk_ios);
 
-static inline void mxcmci_init_ocr(struct mxcmci_host *host)
+static void mxcmci_init_ocr(struct mxcmci_host *host)
 {
-	host->vcc = regulator_get(mmc_dev(host->mmc), "vmmc");
-
+	host->vcc = devm_regulator_get(mmc_dev(host->mmc), "vmmc");
 	if (IS_ERR(host->vcc)) {
-		host->vcc = NULL;
+		if (host->pdata && host->pdata->ocr_avail)
+			host->mmc->ocr_avail = host->pdata->ocr_avail;
+		else
+			host->mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 	} else {
 		host->mmc->ocr_avail = mmc_regulator_get_ocrmask(host->vcc);
 		if (host->pdata && host->pdata->ocr_avail)
 			dev_warn(mmc_dev(host->mmc),
 				"pdata->ocr_avail will not be used\n");
 	}
-
-	if (host->vcc == NULL) {
-		/* fall-back to platform data */
-		if (host->pdata && host->pdata->ocr_avail)
-			host->mmc->ocr_avail = host->pdata->ocr_avail;
-		else
-			host->mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
-	}
 }
 
-static inline void mxcmci_set_power(struct mxcmci_host *host,
-				    unsigned char power_mode,
-				    unsigned int vdd)
+static void mxcmci_set_power(struct mxcmci_host *host, unsigned char power_mode,
+			     unsigned int vdd)
 {
-	if (host->vcc) {
+	if (!IS_ERR(host->vcc)) {
 		if (power_mode == MMC_POWER_UP)
 			mmc_regulator_set_ocr(host->mmc, host->vcc, vdd);
 		else if (power_mode == MMC_POWER_OFF)
@@ -299,7 +291,6 @@ static void mxcmci_softreset(struct mxcmci_host *host)
 
 	mxcmci_writew(host, 0xff, MMC_REG_RES_TO);
 }
-static int mxcmci_setup_dma(struct mmc_host *mmc);
 
 #if IS_ENABLED(CONFIG_PPC_MPC512x)
 static inline void buffer_swap32(u32 *buf, int len)
@@ -868,8 +859,8 @@ static int mxcmci_setup_dma(struct mmc_host *mmc)
 	struct mxcmci_host *host = mmc_priv(mmc);
 	struct dma_slave_config *config = &host->dma_slave_config;
 
-	config->dst_addr = host->res->start + MMC_REG_BUFFER_ACCESS;
-	config->src_addr = host->res->start + MMC_REG_BUFFER_ACCESS;
+	config->dst_addr = host->phys_base + MMC_REG_BUFFER_ACCESS;
+	config->src_addr = host->phys_base + MMC_REG_BUFFER_ACCESS;
 	config->dst_addr_width = 4;
 	config->src_addr_width = 4;
 	config->dst_maxburst = host->burstlen;
@@ -1040,8 +1031,8 @@ static const struct mmc_host_ops mxcmci_ops = {
 static int mxcmci_probe(struct platform_device *pdev)
 {
 	struct mmc_host *mmc;
-	struct mxcmci_host *host = NULL;
-	struct resource *iores, *r;
+	struct mxcmci_host *host;
+	struct resource *res;
 	int ret = 0, irq;
 	bool dat3_card_detect = false;
 	dma_cap_mask_t mask;
@@ -1052,21 +1043,25 @@ static int mxcmci_probe(struct platform_device *pdev)
 
 	of_id = of_match_device(mxcmci_of_match, &pdev->dev);
 
-	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
-	if (!iores || irq < 0)
+	if (irq < 0)
 		return -EINVAL;
 
-	r = request_mem_region(iores->start, resource_size(iores), pdev->name);
-	if (!r)
-		return -EBUSY;
+	mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
+	if (!mmc)
+		return -ENOMEM;
 
-	mmc = mmc_alloc_host(sizeof(struct mxcmci_host), &pdev->dev);
-	if (!mmc) {
-		ret = -ENOMEM;
-		goto out_release_mem;
+	host = mmc_priv(mmc);
+
+	host->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(host->base)) {
+		ret = PTR_ERR(host->base);
+		goto out_free;
 	}
 
+	host->phys_base = res->start;
+
 	ret = mmc_of_parse(mmc);
 	if (ret)
 		goto out_free;
@@ -1084,13 +1079,6 @@ static int mxcmci_probe(struct platform_device *pdev)
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
 	mmc->max_seg_size = mmc->max_req_size;
 
-	host = mmc_priv(mmc);
-	host->base = ioremap(r->start, resource_size(r));
-	if (!host->base) {
-		ret = -ENOMEM;
-		goto out_free;
-	}
-
 	if (of_id) {
 		const struct platform_device_id *id_entry = of_id->data;
 		host->devtype = id_entry->driver_data;
@@ -1120,19 +1108,16 @@ static int mxcmci_probe(struct platform_device *pdev)
 	else
 		host->default_irq_mask = 0;
 
-	host->res = r;
-	host->irq = irq;
-
 	host->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(host->clk_ipg)) {
 		ret = PTR_ERR(host->clk_ipg);
-		goto out_iounmap;
+		goto out_free;
 	}
 
 	host->clk_per = devm_clk_get(&pdev->dev, "per");
 	if (IS_ERR(host->clk_per)) {
 		ret = PTR_ERR(host->clk_per);
-		goto out_iounmap;
+		goto out_free;
 	}
 
 	clk_prepare_enable(host->clk_per);
@@ -1159,9 +1144,9 @@ static int mxcmci_probe(struct platform_device *pdev)
 	if (!host->pdata) {
 		host->dma = dma_request_slave_channel(&pdev->dev, "rx-tx");
 	} else {
-		r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-		if (r) {
-			host->dmareq = r->start;
+		res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+		if (res) {
+			host->dmareq = res->start;
 			host->dma_data.peripheral_type = IMX_DMATYPE_SDHC;
 			host->dma_data.priority = DMA_PRIO_LOW;
 			host->dma_data.dma_request = host->dmareq;
@@ -1178,7 +1163,8 @@ static int mxcmci_probe(struct platform_device *pdev)
 
 	INIT_WORK(&host->datawork, mxcmci_datawork);
 
-	ret = request_irq(host->irq, mxcmci_irq, 0, DRIVER_NAME, host);
+	ret = devm_request_irq(&pdev->dev, irq, mxcmci_irq, 0,
+			       dev_name(&pdev->dev), host);
 	if (ret)
 		goto out_free_dma;
 
@@ -1188,7 +1174,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 		ret = host->pdata->init(&pdev->dev, mxcmci_detect_irq,
 				host->mmc);
 		if (ret)
-			goto out_free_irq;
+			goto out_free_dma;
 	}
 
 	init_timer(&host->watchdog);
@@ -1199,20 +1185,17 @@ static int mxcmci_probe(struct platform_device *pdev)
 
 	return 0;
 
-out_free_irq:
-	free_irq(host->irq, host);
 out_free_dma:
 	if (host->dma)
 		dma_release_channel(host->dma);
+
 out_clk_put:
 	clk_disable_unprepare(host->clk_per);
 	clk_disable_unprepare(host->clk_ipg);
-out_iounmap:
-	iounmap(host->base);
+
 out_free:
 	mmc_free_host(mmc);
-out_release_mem:
-	release_mem_region(iores->start, resource_size(iores));
+
 	return ret;
 }
 
@@ -1223,23 +1206,15 @@ static int mxcmci_remove(struct platform_device *pdev)
 
 	mmc_remove_host(mmc);
 
-	if (host->vcc)
-		regulator_put(host->vcc);
-
 	if (host->pdata && host->pdata->exit)
 		host->pdata->exit(&pdev->dev, mmc);
 
-	free_irq(host->irq, host);
-	iounmap(host->base);
-
 	if (host->dma)
 		dma_release_channel(host->dma);
 
 	clk_disable_unprepare(host->clk_per);
 	clk_disable_unprepare(host->clk_ipg);
 
-	release_mem_region(host->res->start, resource_size(host->res));
-
 	mmc_free_host(mmc);
 
 	return 0;
-- 
1.8.3.2

