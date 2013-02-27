From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 04/12] mmc: mxs-mmc: move to use generic DMA helper
Date: Wed, 27 Feb 2013 23:25:40 +0800
Message-ID: <1361978748-25281-5-git-send-email-shawn.guo@linaro.org>
References: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [216.32.180.12] ([216.32.180.12]:18213 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1760001Ab3B0P17 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Feb 2013 10:27:59 -0500
In-Reply-To: <1361978748-25281-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Vinod Koul <vinod.koul@intel.com>, Arnd Bergmann <arnd@arndb.de>, Marek Vasut <marek.vasut@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, Huang Shijie <b32955@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

With the generic DMA device tree helper supported by mxs-dma driver,
client devices only need to call dma_request_slave_channel() for
requesting a DMA channel from dmaengine.

Since mxs is a DT only platform now, along with the changes, the non-DT
case checking in probe function also gets cleaned up.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org
---
 Documentation/devicetree/bindings/mmc/mxs-mmc.txt |   12 ++++--
 drivers/mmc/host/mxs-mmc.c                        |   48 +++------------------
 2 files changed, 13 insertions(+), 47 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mxs-mmc.txt b/Documentation/devicetree/bindings/mmc/mxs-mmc.txt
index 54949f6..9f55d85 100644
--- a/Documentation/devicetree/bindings/mmc/mxs-mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mxs-mmc.txt
@@ -9,15 +9,19 @@ and the properties used by the mxsmmc driver.
 Required properties:
 - compatible: Should be "fsl,<chip>-mmc".  The supported chips include
   imx23 and imx28.
-- interrupts: Should contain ERROR and DMA interrupts
-- fsl,ssp-dma-channel: APBH DMA channel for the SSP
+- interrupts: Should contain ERROR interrupt number
+- dmas: DMA specifier, consisting of a phandle to DMA controller node
+  and SSP DMA channel ID.
+  Refer to dma.txt and fsl-mxs-dma.txt for details.
+- dma-names: Must be "ssp".
 
 Examples:
 
 ssp0: ssp@80010000 {
 	compatible = "fsl,imx28-mmc";
 	reg = <0x80010000 2000>;
-	interrupts = <96 82>;
-	fsl,ssp-dma-channel = <0>;
+	interrupts = <96>;
+	dmas = <&dma_apbh 0>;
+	dma-names = "ssp";
 	bus-width = <8>;
 };
diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 4efe302..83fe0ad 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -548,22 +548,6 @@ static const struct mmc_host_ops mxs_mmc_ops = {
 	.enable_sdio_irq = mxs_mmc_enable_sdio_irq,
 };
 
-static bool mxs_mmc_dma_filter(struct dma_chan *chan, void *param)
-{
-	struct mxs_mmc_host *host = param;
-	struct mxs_ssp *ssp = &host->ssp;
-
-	if (!mxs_dma_is_apbh(chan))
-		return false;
-
-	if (chan->chan_id != ssp->dma_channel)
-		return false;
-
-	chan->private = &ssp->dma_data;
-
-	return true;
-}
-
 static struct platform_device_id mxs_ssp_ids[] = {
 	{
 		.name = "imx23-mmc",
@@ -591,20 +575,17 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct mxs_mmc_host *host;
 	struct mmc_host *mmc;
-	struct resource *iores, *dmares;
+	struct resource *iores;
 	struct pinctrl *pinctrl;
-	int ret = 0, irq_err, irq_dma;
-	dma_cap_mask_t mask;
+	int ret = 0, irq_err;
 	struct regulator *reg_vmmc;
 	enum of_gpio_flags flags;
 	struct mxs_ssp *ssp;
 	u32 bus_width = 0;
 
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	dmares = platform_get_resource(pdev, IORESOURCE_DMA, 0);
 	irq_err = platform_get_irq(pdev, 0);
-	irq_dma = platform_get_irq(pdev, 1);
-	if (!iores || irq_err < 0 || irq_dma < 0)
+	if (!iores || irq_err < 0)
 		return -EINVAL;
 
 	mmc = mmc_alloc_host(sizeof(struct mxs_mmc_host), &pdev->dev);
@@ -620,23 +601,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 		goto out_mmc_free;
 	}
 
-	if (np) {
-		ssp->devid = (enum mxs_ssp_id) of_id->data;
-		/*
-		 * TODO: This is a temporary solution and should be changed
-		 * to use generic DMA binding later when the helpers get in.
-		 */
-		ret = of_property_read_u32(np, "fsl,ssp-dma-channel",
-					   &ssp->dma_channel);
-		if (ret) {
-			dev_err(mmc_dev(host->mmc),
-				"failed to get dma channel\n");
-			goto out_mmc_free;
-		}
-	} else {
-		ssp->devid = pdev->id_entry->driver_data;
-		ssp->dma_channel = dmares->start;
-	}
+	ssp->devid = (enum mxs_ssp_id) of_id->data;
 
 	host->mmc = mmc;
 	host->sdio_irq_en = 0;
@@ -666,10 +631,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 
 	mxs_mmc_reset(host);
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	ssp->dma_data.chan_irq = irq_dma;
-	ssp->dmach = dma_request_channel(mask, mxs_mmc_dma_filter, host);
+	ssp->dmach = dma_request_slave_channel(&pdev->dev, "ssp");
 	if (!ssp->dmach) {
 		dev_err(mmc_dev(host->mmc),
 			"%s: failed to request dma\n", __func__);
-- 
1.7.9.5


