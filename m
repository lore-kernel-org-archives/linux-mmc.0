From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v4, 4/6] mmc: sdhci: apply little-endian mode support to sdhci-of-esdhc
Date: Fri, 31 Jul 2015 11:54:50 +0800
Message-ID: <1438314890-47713-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0135.outbound.protection.outlook.com ([65.55.169.135]:47561
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751158AbbGaD77 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Jul 2015 23:59:59 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 105 +++++++++++++++++++++++++-------------
 1 file changed, 69 insertions(+), 36 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 797be75..f1021d8 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -28,7 +28,7 @@ static u32 esdhc_readl(struct sdhci_host *host, int reg)
 {
 	u32 ret;
 
-	ret = in_be32(host->ioaddr + reg);
+	ret = sdhci_32bs_readl(host, reg);
 	/*
 	 * The bit of ADMA flag in eSDHC is not compatible with standard
 	 * SDHC register, so set fake flag SDHCI_CAN_DO_ADMA2 when ADMA is
@@ -40,7 +40,7 @@ static u32 esdhc_readl(struct sdhci_host *host, int reg)
 	 * the verdor version number, oxFE is SDHCI_HOST_VERSION.
 	 */
 	if ((reg == SDHCI_CAPABILITIES) && (ret & SDHCI_CAN_DO_ADMA1)) {
-		u32 tmp = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
+		u32 tmp = sdhci_32bs_readl(host, SDHCI_SLOT_INT_STATUS);
 		tmp = (tmp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
 		if (tmp > VENDOR_V_22)
 			ret |= SDHCI_CAN_DO_ADMA2;
@@ -56,9 +56,9 @@ static u16 esdhc_readw(struct sdhci_host *host, int reg)
 	int shift = (reg & 0x2) * 8;
 
 	if (unlikely(reg == SDHCI_HOST_VERSION))
-		ret = in_be32(host->ioaddr + base) & 0xffff;
+		ret = sdhci_32bs_readl(host, base) & 0xffff;
 	else
-		ret = (in_be32(host->ioaddr + base) >> shift) & 0xffff;
+		ret = (sdhci_32bs_readl(host, base) >> shift) & 0xffff;
 	return ret;
 }
 
@@ -66,7 +66,10 @@ static u8 esdhc_readb(struct sdhci_host *host, int reg)
 {
 	int base = reg & ~0x3;
 	int shift = (reg & 0x3) * 8;
-	u8 ret = (in_be32(host->ioaddr + base) >> shift) & 0xff;
+	u32 ret;
+	u8 val;
+
+	ret = sdhci_32bs_readl(host, base);
 
 	/*
 	 * "DMA select" locates at offset 0x28 in SD specification, but on
@@ -75,16 +78,18 @@ static u8 esdhc_readb(struct sdhci_host *host, int reg)
 	if (reg == SDHCI_HOST_CONTROL) {
 		u32 dma_bits;
 
-		dma_bits = in_be32(host->ioaddr + reg);
 		/* DMA select is 22,23 bits in Protocol Control Register */
-		dma_bits = (dma_bits >> 5) & SDHCI_CTRL_DMA_MASK;
+		dma_bits = (ret >> 5) & SDHCI_CTRL_DMA_MASK;
 
 		/* fixup the result */
 		ret &= ~SDHCI_CTRL_DMA_MASK;
 		ret |= dma_bits;
+		val = (ret & 0xff);
 	}
 
-	return ret;
+	val = (ret >> shift) & 0xff;
+
+	return val;
 }
 
 static void esdhc_writel(struct sdhci_host *host, u32 val, int reg)
@@ -96,11 +101,28 @@ static void esdhc_writel(struct sdhci_host *host, u32 val, int reg)
 	 */
 	if (reg == SDHCI_INT_ENABLE)
 		val |= SDHCI_INT_BLK_GAP;
-	sdhci_be32bs_writel(host, val, reg);
+	sdhci_32bs_writel(host, val, reg);
 }
 
 static void esdhc_writew(struct sdhci_host *host, u16 val, int reg)
 {
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	switch (reg) {
+	case SDHCI_TRANSFER_MODE:
+		/*
+		 * Postpone this write, we must do it together with a
+		 * command write that is down below.
+		 */
+		pltfm_host->xfer_mode_shadow = val;
+		return;
+	case SDHCI_COMMAND:
+		sdhci_32bs_writel(host, val << 16 |
+				  pltfm_host->xfer_mode_shadow,
+				  SDHCI_TRANSFER_MODE);
+		return;
+	}
+
 	if (reg == SDHCI_BLOCK_SIZE) {
 		/*
 		 * Two last DMA bits are reserved, and first one is used for
@@ -109,7 +131,7 @@ static void esdhc_writew(struct sdhci_host *host, u16 val, int reg)
 		 */
 		val &= ~SDHCI_MAKE_BLKSZ(0x7, 0);
 	}
-	sdhci_be32bs_writew(host, val, reg);
+	sdhci_clrsetbits(host, 0xffff, val, reg);
 }
 
 static void esdhc_writeb(struct sdhci_host *host, u8 val, int reg)
@@ -130,16 +152,16 @@ static void esdhc_writeb(struct sdhci_host *host, u8 val, int reg)
 
 		/* DMA select is 22,23 bits in Protocol Control Register */
 		dma_bits = (val & SDHCI_CTRL_DMA_MASK) << 5;
-		clrsetbits_be32(host->ioaddr + reg , SDHCI_CTRL_DMA_MASK << 5,
-			dma_bits);
+		sdhci_clrsetbits(host, SDHCI_CTRL_DMA_MASK << 5, dma_bits,
+				 SDHCI_HOST_CONTROL);
 		val &= ~SDHCI_CTRL_DMA_MASK;
-		val |= in_be32(host->ioaddr + reg) & SDHCI_CTRL_DMA_MASK;
+		val |= sdhci_32bs_readl(host, reg) & SDHCI_CTRL_DMA_MASK;
 	}
 
 	/* Prevent SDHCI core from writing reserved bits (e.g. HISPD). */
 	if (reg == SDHCI_HOST_CONTROL)
 		val &= ~ESDHC_HOST_CONTROL_RES;
-	sdhci_be32bs_writeb(host, val, reg);
+	sdhci_clrsetbits(host, 0xff, val, reg);
 }
 
 /*
@@ -156,7 +178,7 @@ static void esdhci_of_adma_workaround(struct sdhci_host *host, u32 intmask)
 	dma_addr_t dmastart;
 	dma_addr_t dmanow;
 
-	tmp = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
+	tmp = esdhc_readl(host, SDHCI_SLOT_INT_STATUS);
 	tmp = (tmp & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
 
 	applicable = (intmask & SDHCI_INT_DATA_END) &&
@@ -174,12 +196,13 @@ static void esdhci_of_adma_workaround(struct sdhci_host *host, u32 intmask)
 	dmanow = (dmanow & ~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
 		SDHCI_DEFAULT_BOUNDARY_SIZE;
 	host->data->bytes_xfered = dmanow - dmastart;
-	sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
+	esdhc_writel(host, dmanow, SDHCI_DMA_ADDRESS);
 }
 
 static int esdhc_of_enable_dma(struct sdhci_host *host)
 {
-	setbits32(host->ioaddr + ESDHC_DMA_SYSCTL, ESDHC_DMA_SNOOP);
+	esdhc_writel(host, esdhc_readl(host, ESDHC_DMA_SYSCTL)
+			| ESDHC_DMA_SNOOP, ESDHC_DMA_SYSCTL);
 	return 0;
 }
 
@@ -245,7 +268,7 @@ static void esdhc_of_platform_init(struct sdhci_host *host)
 {
 	u32 vvn;
 
-	vvn = in_be32(host->ioaddr + SDHCI_SLOT_INT_STATUS);
+	vvn = esdhc_readl(host, SDHCI_SLOT_INT_STATUS);
 	vvn = (vvn & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
 	if (vvn == VENDOR_V_22)
 		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
@@ -272,8 +295,8 @@ static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
 		break;
 	}
 
-	clrsetbits_be32(host->ioaddr + SDHCI_HOST_CONTROL,
-			ESDHC_CTRL_BUSWIDTH_MASK, ctrl);
+	sdhci_clrsetbits(host, ESDHC_CTRL_BUSWIDTH_MASK, ctrl,
+			 SDHCI_HOST_CONTROL);
 }
 
 static void esdhc_reset(struct sdhci_host *host, u8 mask)
@@ -309,7 +332,7 @@ static int esdhc_of_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 
-	esdhc_proctl = sdhci_be32bs_readl(host, SDHCI_HOST_CONTROL);
+	esdhc_proctl = esdhc_readl(host, SDHCI_HOST_CONTROL);
 
 	return sdhci_suspend_host(host);
 }
@@ -322,7 +345,7 @@ static int esdhc_of_resume(struct device *dev)
 	if (ret == 0) {
 		/* Isn't this already done by sdhci_resume_host() ? --rmk */
 		esdhc_of_enable_dma(host);
-		sdhci_be32bs_writel(host, esdhc_proctl, SDHCI_HOST_CONTROL);
+		esdhc_writel(host, esdhc_proctl, SDHCI_HOST_CONTROL);
 	}
 
 	return ret;
@@ -348,19 +371,18 @@ static const struct sdhci_pltfm_data sdhci_esdhc_pdata = {
 	.ops = &sdhci_esdhc_ops,
 };
 
-static int sdhci_esdhc_probe(struct platform_device *pdev)
+static void esdhc_get_property(struct platform_device *pdev)
 {
-	struct sdhci_host *host;
-	struct device_node *np;
-	int ret;
-
-	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_pdata, 0);
-	if (IS_ERR(host))
-		return PTR_ERR(host);
+	struct device_node *np = pdev->dev.of_node;
+	struct sdhci_host *host = platform_get_drvdata(pdev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 
 	sdhci_get_of_property(pdev);
 
-	np = pdev->dev.of_node;
+	/* call to generic mmc_of_parse to support additional capabilities */
+	mmc_of_parse(host->mmc);
+	mmc_of_parse_voltage(np, &host->ocr_mask);
+
 	if (of_device_is_compatible(np, "fsl,p5040-esdhc") ||
 	    of_device_is_compatible(np, "fsl,p5020-esdhc") ||
 	    of_device_is_compatible(np, "fsl,p4080-esdhc") ||
@@ -376,13 +398,24 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 		host->quirks2 |= SDHCI_QUIRK2_BROKEN_HOST_CONTROL;
 	}
 
-	/* call to generic mmc_of_parse to support additional capabilities */
-	ret = mmc_of_parse(host->mmc);
-	if (ret)
-		goto err;
+	if (!pltfm_host->clock) {
+		pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
+		pltfm_host->clock = clk_get_rate(pltfm_host->clk);
+		clk_prepare_enable(pltfm_host->clk);
+	}
+}
 
-	mmc_of_parse_voltage(np, &host->ocr_mask);
+static int sdhci_esdhc_probe(struct platform_device *pdev)
+{
+	struct sdhci_host *host;
+	int ret;
+
+
+	host = sdhci_pltfm_init(pdev, &sdhci_esdhc_pdata, 0);
+	if (IS_ERR(host))
+		return PTR_ERR(host);
 
+	esdhc_get_property(pdev);
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto err;
-- 
2.1.0.27.g96db324

