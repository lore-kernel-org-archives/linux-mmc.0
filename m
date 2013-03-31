From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v3] mmc: mxcmmc: DT support
Date: Sun, 31 Mar 2013 20:07:38 +0200
Message-ID: <1364753258-16732-1-git-send-email-agust@denx.de>
References: <1364225659-29677-1-git-send-email-mpa@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:43804 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586Ab3CaSHr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 31 Mar 2013 14:07:47 -0400
In-Reply-To: <1364225659-29677-1-git-send-email-mpa@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: rob.herring@calxeda.com, rob@landley.net, kernel@pengutronix.de, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, mpa@pengutronix.de

From: Markus Pargmann <mpa@pengutronix.de>

Adding devicetree support for imx21-mmc and imx31-mmc. Based on generic
gpio helper functions by Guennadi and generic DMA devicetree bindings.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Signed-off-by:: Anatolij Gustschin <agust@denx.de>
---

Notes:
    Changes in v3:
    - fix first argument of dma_request_slave_channel(),
      it should be a pointer to struct device 
    Changes in v2:
    - Documentation fix
    - Use dma_request_slave_channel instead of of_*

 .../devicetree/bindings/mmc/fsl-imx-mmc.txt        |   24 ++++++
 drivers/mmc/host/mxcmmc.c                          |   79 +++++++++++++++-----
 2 files changed, 85 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-mmc.txt

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.txt
new file mode 100644
index 0000000..db44235
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.txt
@@ -0,0 +1,24 @@
+* Freescale Secure Digital Host Controller for i.MX2/3 series
+
+This file documents differences to the properties defined in mmc.txt.
+
+Required properties:
+- compatible : Should be "fsl,<chip>-mmc", chip can be imx21 or imx31
+
+Optional properties:
+- dmas: One DMA phandle with arguments as defined by the devicetree bindings
+	of the used DMA controller.
+- dma-names: Has to be "rx-tx".
+
+Example:
+
+sdhci1: sdhci@10014000 {
+	compatible = "fsl,imx27-mmc", "fsl,imx21-mmc";
+	reg = <0x10014000 0x1000>;
+	interrupts = <11>;
+	dmas = <&dma 7>;
+	dma-names = "rx-tx";
+	bus-width = <4>;
+	cd-gpios = <&gpio3 29>;
+	status = "okay";
+};
diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index a72936e..ff9e496 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -34,6 +34,10 @@
 #include <linux/regulator/consumer.h>
 #include <linux/dmaengine.h>
 #include <linux/types.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_dma.h>
+#include <linux/of_gpio.h>
 
 #include <asm/dma.h>
 #include <asm/irq.h>
@@ -173,6 +177,19 @@ static struct platform_device_id mxcmci_devtype[] = {
 };
 MODULE_DEVICE_TABLE(platform, mxcmci_devtype);
 
+static const struct of_device_id mxcmci_of_match[] = {
+	{
+		.compatible = "fsl,imx21-mmc",
+		.data = &mxcmci_devtype[IMX21_MMC],
+	}, {
+		.compatible = "fsl,imx31-mmc",
+		.data = &mxcmci_devtype[IMX31_MMC],
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, mxcmci_of_match);
+
 static inline int is_imx31_mmc(struct mxcmci_host *host)
 {
 	return host->devtype == IMX31_MMC;
@@ -935,10 +952,15 @@ static int mxcmci_probe(struct platform_device *pdev)
 	struct mxcmci_host *host = NULL;
 	struct resource *iores, *r;
 	int ret = 0, irq;
+	bool dat3_card_detect = false;
 	dma_cap_mask_t mask;
+	const struct of_device_id *of_id;
+	struct imxmmc_platform_data *pdata = pdev->dev.platform_data;
 
 	pr_info("i.MX SDHC driver\n");
 
+	of_id = of_match_device(mxcmci_of_match, &pdev->dev);
+
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
 	if (!iores || irq < 0)
@@ -954,8 +976,14 @@ static int mxcmci_probe(struct platform_device *pdev)
 		goto out_release_mem;
 	}
 
+	mmc_of_parse(mmc);
 	mmc->ops = &mxcmci_ops;
-	mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SDIO_IRQ;
+
+	/* For devicetree parsing, the bus width is read from devicetree */
+	if (pdata)
+		mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SDIO_IRQ;
+	else
+		mmc->caps |= MMC_CAP_SDIO_IRQ;
 
 	/* MMC core transfer sizes tunable parameters */
 	mmc->max_segs = 64;
@@ -971,14 +999,25 @@ static int mxcmci_probe(struct platform_device *pdev)
 		goto out_free;
 	}
 
+	if (of_id) {
+		const struct platform_device_id *id_entry = of_id->data;
+		host->devtype = id_entry->driver_data;
+	} else {
+		host->devtype = pdev->id_entry->driver_data;
+	}
 	host->mmc = mmc;
-	host->pdata = pdev->dev.platform_data;
-	host->devtype = pdev->id_entry->driver_data;
+	host->pdata = pdata;
 	spin_lock_init(&host->lock);
 
+	if (pdata)
+		dat3_card_detect = pdata->dat3_card_detect;
+	else if (!(mmc->caps & MMC_CAP_NONREMOVABLE)
+			&& !of_property_read_bool(pdev->dev.of_node, "cd-gpios"))
+		dat3_card_detect = true;
+
 	mxcmci_init_ocr(host);
 
-	if (host->pdata && host->pdata->dat3_card_detect)
+	if (dat3_card_detect)
 		host->default_irq_mask =
 			INT_CARD_INSERTION_EN | INT_CARD_REMOVAL_EN;
 	else
@@ -1020,21 +1059,24 @@ static int mxcmci_probe(struct platform_device *pdev)
 
 	writel(host->default_irq_mask, host->base + MMC_REG_INT_CNTR);
 
-	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-	if (r) {
-		host->dmareq = r->start;
-		host->dma_data.peripheral_type = IMX_DMATYPE_SDHC;
-		host->dma_data.priority = DMA_PRIO_LOW;
-		host->dma_data.dma_request = host->dmareq;
-		dma_cap_zero(mask);
-		dma_cap_set(DMA_SLAVE, mask);
-		host->dma = dma_request_channel(mask, filter, host);
-		if (host->dma)
-			mmc->max_seg_size = dma_get_max_seg_size(
-					host->dma->device->dev);
+	if (!host->pdata) {
+		host->dma = dma_request_slave_channel(&pdev->dev, "rx-tx");
+	} else {
+		r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+		if (r) {
+			host->dmareq = r->start;
+			host->dma_data.peripheral_type = IMX_DMATYPE_SDHC;
+			host->dma_data.priority = DMA_PRIO_LOW;
+			host->dma_data.dma_request = host->dmareq;
+			dma_cap_zero(mask);
+			dma_cap_set(DMA_SLAVE, mask);
+			host->dma = dma_request_channel(mask, filter, host);
+		}
 	}
-
-	if (!host->dma)
+	if (host->dma)
+		mmc->max_seg_size = dma_get_max_seg_size(
+				host->dma->device->dev);
+	else
 		dev_info(mmc_dev(host->mmc), "dma not available. Using PIO\n");
 
 	INIT_WORK(&host->datawork, mxcmci_datawork);
@@ -1153,6 +1195,7 @@ static struct platform_driver mxcmci_driver = {
 #ifdef CONFIG_PM
 		.pm	= &mxcmci_pm_ops,
 #endif
+		.of_match_table	= mxcmci_of_match,
 	}
 };
 
-- 
1.7.5.4

