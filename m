From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 28/35] mmc: host: use dev_get_platdata()
Date: Tue, 30 Jul 2013 17:17:20 +0900
Message-ID: <005701ce8cfd$3618c2d0$a24a4870$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:55339 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757976Ab3G3IRW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Jul 2013 04:17:22 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQQ00F0BPOPFOT0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 30 Jul 2013 17:17:20 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

Use the wrapper function for retrieving the platform data instead of
accessing dev->platform_data directly.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/atmel-mci.c       |    4 ++--
 drivers/mmc/host/au1xmmc.c         |    2 +-
 drivers/mmc/host/bfin_sdh.c        |    2 +-
 drivers/mmc/host/davinci_mmc.c     |    8 ++++----
 drivers/mmc/host/dw_mmc-pltfm.c    |    2 +-
 drivers/mmc/host/jz4740_mmc.c      |    6 +++---
 drivers/mmc/host/mmci.c            |    2 +-
 drivers/mmc/host/msm_sdcc.c        |    2 +-
 drivers/mmc/host/mvsdio.c          |    2 +-
 drivers/mmc/host/mxcmmc.c          |    2 +-
 drivers/mmc/host/of_mmc_spi.c      |   10 +++++-----
 drivers/mmc/host/omap.c            |    2 +-
 drivers/mmc/host/omap_hsmmc.c      |    2 +-
 drivers/mmc/host/pxamci.c          |    2 +-
 drivers/mmc/host/rtsx_pci_sdmmc.c  |    2 +-
 drivers/mmc/host/s3cmci.c          |    2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c |    4 ++--
 drivers/mmc/host/sdhci-pxav2.c     |    4 ++--
 drivers/mmc/host/sdhci-pxav3.c     |    4 ++--
 drivers/mmc/host/sdhci-s3c.c       |    4 ++--
 drivers/mmc/host/sh_mmcif.c        |   13 +++++++------
 drivers/mmc/host/sh_mobile_sdhi.c  |    8 ++++----
 drivers/mmc/host/tmio_mmc.c        |    2 +-
 23 files changed, 46 insertions(+), 45 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index bdb84da..338aa25 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2253,7 +2253,7 @@ static bool atmci_configure_dma(struct atmel_mci *host)
 	if (host == NULL)
 		return false;
 
-	pdata = host->pdev->dev.platform_data;
+	pdata = dev_get_platdata(&host->pdev->dev);
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
@@ -2344,7 +2344,7 @@ static int __init atmci_probe(struct platform_device *pdev)
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!regs)
 		return -ENXIO;
-	pdata = pdev->dev.platform_data;
+	pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata) {
 		pdata = atmci_of_init(pdev);
 		if (IS_ERR(pdata)) {
diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index df9becd..3b6111d 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -959,7 +959,7 @@ static int au1xmmc_probe(struct platform_device *pdev)
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
-	host->platdata = pdev->dev.platform_data;
+	host->platdata = dev_get_platdata(&pdev->dev);
 	host->pdev = pdev;
 
 	ret = -ENODEV;
diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
index 94fae2f..5b8244d 100644
--- a/drivers/mmc/host/bfin_sdh.c
+++ b/drivers/mmc/host/bfin_sdh.c
@@ -80,7 +80,7 @@ struct sdh_host {
 
 static struct bfin_sd_host *get_sdh_data(struct platform_device *pdev)
 {
-	return pdev->dev.platform_data;
+	return dev_get_platdata(&pdev->dev);
 }
 
 static void sdh_stop_clock(struct sdh_host *host)
diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index e9fa87d..fb09748 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -731,7 +731,7 @@ static void mmc_davinci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct mmc_davinci_host *host = mmc_priv(mmc);
 	struct platform_device *pdev = to_platform_device(mmc->parent);
-	struct davinci_mmc_config *config = pdev->dev.platform_data;
+	struct davinci_mmc_config *config = dev_get_platdata(&pdev->dev);
 
 	dev_dbg(mmc_dev(host->mmc),
 		"clock %dHz busmode %d powermode %d Vdd %04x\n",
@@ -1055,7 +1055,7 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id)
 static int mmc_davinci_get_cd(struct mmc_host *mmc)
 {
 	struct platform_device *pdev = to_platform_device(mmc->parent);
-	struct davinci_mmc_config *config = pdev->dev.platform_data;
+	struct davinci_mmc_config *config = dev_get_platdata(&pdev->dev);
 
 	if (!config || !config->get_cd)
 		return -ENOSYS;
@@ -1065,7 +1065,7 @@ static int mmc_davinci_get_cd(struct mmc_host *mmc)
 static int mmc_davinci_get_ro(struct mmc_host *mmc)
 {
 	struct platform_device *pdev = to_platform_device(mmc->parent);
-	struct davinci_mmc_config *config = pdev->dev.platform_data;
+	struct davinci_mmc_config *config = dev_get_platdata(&pdev->dev);
 
 	if (!config || !config->get_ro)
 		return -ENOSYS;
@@ -1191,7 +1191,7 @@ static struct davinci_mmc_config
 	*mmc_parse_pdata(struct platform_device *pdev)
 {
 	struct device_node *np;
-	struct davinci_mmc_config *pdata = pdev->dev.platform_data;
+	struct davinci_mmc_config *pdata = dev_get_platdata(&pdev->dev);
 	const struct of_device_id *match =
 		of_match_device(of_match_ptr(davinci_mmc_dt_ids), &pdev->dev);
 	u32 data;
diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index ee52556..d295c69 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -51,7 +51,7 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
 	host->drv_data = drv_data;
 	host->dev = &pdev->dev;
 	host->irq_flags = 0;
-	host->pdata = pdev->dev.platform_data;
+	host->pdata = dev_get_platdata(&pdev->dev);
 
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->regs = devm_ioremap_resource(&pdev->dev, regs);
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 0308c9f..e1bb62f 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -701,7 +701,7 @@ static int jz4740_mmc_request_gpio(struct device *dev, int gpio,
 static int jz4740_mmc_request_gpios(struct mmc_host *mmc,
 	struct platform_device *pdev)
 {
-	struct jz4740_mmc_platform_data *pdata = pdev->dev.platform_data;
+	struct jz4740_mmc_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	int ret = 0;
 
 	if (!pdata)
@@ -730,7 +730,7 @@ static int jz4740_mmc_request_gpios(struct mmc_host *mmc,
 
 static void jz4740_mmc_free_gpios(struct platform_device *pdev)
 {
-	struct jz4740_mmc_platform_data *pdata = pdev->dev.platform_data;
+	struct jz4740_mmc_platform_data *pdata = dev_get_platdata(&pdev->dev);
 
 	if (!pdata)
 		return;
@@ -756,7 +756,7 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	struct jz4740_mmc_platform_data *pdata;
 	struct resource *res;
 
-	pdata = pdev->dev.platform_data;
+	pdata = dev_get_platdata(&pdev->dev);
 
 	mmc = mmc_alloc_host(sizeof(struct jz4740_mmc_host), &pdev->dev);
 	if (!mmc) {
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index c3785ed..b748a11 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1404,7 +1404,7 @@ static void mmci_dt_populate_generic_pdata(struct device_node *np,
 static int mmci_probe(struct amba_device *dev,
 	const struct amba_id *id)
 {
-	struct mmci_platform_data *plat = dev->dev.platform_data;
+	struct mmci_platform_data *plat = dev_get_platdata(&dev->dev);
 	struct device_node *np = dev->dev.of_node;
 	struct variant_data *variant = id->data;
 	struct mmci_host *host;
diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
index b900de4..6adf520 100644
--- a/drivers/mmc/host/msm_sdcc.c
+++ b/drivers/mmc/host/msm_sdcc.c
@@ -1166,7 +1166,7 @@ msmsdcc_init_dma(struct msmsdcc_host *host)
 static int
 msmsdcc_probe(struct platform_device *pdev)
 {
-	struct msm_mmc_platform_data *plat = pdev->dev.platform_data;
+	struct msm_mmc_platform_data *plat = dev_get_platdata(&pdev->dev);
 	struct msmsdcc_host *host;
 	struct mmc_host *mmc;
 	struct resource *cmd_irqres = NULL;
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 4ddd83f..bb8176a 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -745,7 +745,7 @@ static int __init mvsd_probe(struct platform_device *pdev)
 	} else {
 		const struct mvsdio_platform_data *mvsd_data;
 
-		mvsd_data = pdev->dev.platform_data;
+		mvsd_data = dev_get_platdata(&pdev->dev);
 		if (!mvsd_data) {
 			ret = -ENXIO;
 			goto out;
diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index c174c6a..648b571 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1046,7 +1046,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 	bool dat3_card_detect = false;
 	dma_cap_mask_t mask;
 	const struct of_device_id *of_id;
-	struct imxmmc_platform_data *pdata = pdev->dev.platform_data;
+	struct imxmmc_platform_data *pdata = dev_get_platdata(&pdev->dev);
 
 	pr_info("i.MX/MPC512x SDHC driver\n");
 
diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
index d720b5e..4fbe446 100644
--- a/drivers/mmc/host/of_mmc_spi.c
+++ b/drivers/mmc/host/of_mmc_spi.c
@@ -47,7 +47,7 @@ struct of_mmc_spi {
 
 static struct of_mmc_spi *to_of_mmc_spi(struct device *dev)
 {
-	return container_of(dev->platform_data, struct of_mmc_spi, pdata);
+	return container_of(dev_get_platdata(dev), struct of_mmc_spi, pdata);
 }
 
 static int of_mmc_spi_read_gpio(struct device *dev, int gpio_num)
@@ -95,8 +95,8 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
 	int i;
 	int ret = -EINVAL;
 
-	if (dev->platform_data || !np)
-		return dev->platform_data;
+	if (dev_get_platdata(dev) || !np)
+		return dev_get_platdata(dev);
 
 	oms = kzalloc(sizeof(*oms), GFP_KERNEL);
 	if (!oms)
@@ -154,7 +154,7 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
 	}
 
 	dev->platform_data = &oms->pdata;
-	return dev->platform_data;
+	return dev_get_platdata(dev);
 err_ocr:
 	kfree(oms);
 	return NULL;
@@ -168,7 +168,7 @@ void mmc_spi_put_pdata(struct spi_device *spi)
 	struct of_mmc_spi *oms = to_of_mmc_spi(dev);
 	int i;
 
-	if (!dev->platform_data || !np)
+	if (!dev_get_platdata(dev) || !np)
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(oms->gpios); i++) {
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index b94f38e..d63bb2e 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1327,7 +1327,7 @@ static void mmc_omap_remove_slot(struct mmc_omap_slot *slot)
 
 static int mmc_omap_probe(struct platform_device *pdev)
 {
-	struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
+	struct omap_mmc_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct mmc_omap_host *host = NULL;
 	struct resource *res;
 	dma_cap_mask_t mask;
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 1865321..dcffa8b 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1768,7 +1768,7 @@ static inline struct omap_mmc_platform_data
 
 static int omap_hsmmc_probe(struct platform_device *pdev)
 {
-	struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
+	struct omap_mmc_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct mmc_host *mmc;
 	struct omap_hsmmc_host *host = NULL;
 	struct resource *res;
diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 2c5a91b..8679079 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -672,7 +672,7 @@ static int pxamci_probe(struct platform_device *pdev)
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
 	host->dma = -1;
-	host->pdata = pdev->dev.platform_data;
+	host->pdata = dev_get_platdata(&pdev->dev);
 	host->clkrt = CLKRT_OFF;
 
 	host->clk = clk_get(&pdev->dev, NULL);
diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 82a35b9..49e2687 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1250,7 +1250,7 @@ static int rtsx_pci_sdmmc_drv_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	struct realtek_pci_sdmmc *host;
 	struct rtsx_pcr *pcr;
-	struct pcr_handle *handle = pdev->dev.platform_data;
+	struct pcr_handle *handle = dev_get_platdata(&pdev->dev);
 
 	if (!handle)
 		return -ENXIO;
diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 8d6794c..da1c626 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1652,7 +1652,7 @@ static int s3cmci_probe(struct platform_device *pdev)
 	host->pdev	= pdev;
 	host->is2440	= is2440;
 
-	host->pdata = pdev->dev.platform_data;
+	host->pdata = dev_get_platdata(&pdev->dev);
 	if (!host->pdata) {
 		pdev->dev.platform_data = &s3cmci_def_pdata;
 		host->pdata = &s3cmci_def_pdata;
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 1dd5ba8..3a07ee5 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -593,13 +593,13 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 
 	boarddata = &imx_data->boarddata;
 	if (sdhci_esdhc_imx_probe_dt(pdev, boarddata) < 0) {
-		if (!host->mmc->parent->platform_data) {
+		if (!dev_get_platdata(host->mmc->parent)) {
 			dev_err(mmc_dev(host->mmc), "no board data!\n");
 			err = -EINVAL;
 			goto disable_clk;
 		}
 		imx_data->boarddata = *((struct esdhc_platform_data *)
-					host->mmc->parent->platform_data);
+					dev_get_platdata(host->mmc->parent));
 	}
 
 	/* write_protect */
diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index d51e061..a3eafbc 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -54,7 +54,7 @@
 static void pxav2_set_private_registers(struct sdhci_host *host, u8 mask)
 {
 	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
-	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
+	struct sdhci_pxa_platdata *pdata = dev_get_platdata(&pdev->dev);
 
 	if (mask == SDHCI_RESET_ALL) {
 		u16 tmp = 0;
@@ -162,7 +162,7 @@ static inline struct sdhci_pxa_platdata *pxav2_get_mmc_pdata(struct device *dev)
 static int sdhci_pxav2_probe(struct platform_device *pdev)
 {
 	struct sdhci_pltfm_host *pltfm_host;
-	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
+	struct sdhci_pxa_platdata *pdata = dev_get_platdata(&pdev->dev);
 	struct device *dev = &pdev->dev;
 	struct sdhci_host *host = NULL;
 	struct sdhci_pxa *pxa = NULL;
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index bf99359..c8182e3 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -60,7 +60,7 @@
 static void pxav3_set_private_registers(struct sdhci_host *host, u8 mask)
 {
 	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
-	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
+	struct sdhci_pxa_platdata *pdata = dev_get_platdata(&pdev->dev);
 
 	if (mask == SDHCI_RESET_ALL) {
 		/*
@@ -217,7 +217,7 @@ static inline struct sdhci_pxa_platdata *pxav3_get_mmc_pdata(struct device *dev)
 static int sdhci_pxav3_probe(struct platform_device *pdev)
 {
 	struct sdhci_pltfm_host *pltfm_host;
-	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
+	struct sdhci_pxa_platdata *pdata = dev_get_platdata(&pdev->dev);
 	struct device *dev = &pdev->dev;
 	struct sdhci_host *host = NULL;
 	struct sdhci_pxa *pxa = NULL;
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 926aaf6..fbca5e4 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -511,7 +511,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	struct resource *res;
 	int ret, irq, ptr, clks;
 
-	if (!pdev->dev.platform_data && !pdev->dev.of_node) {
+	if (!dev_get_platdata(&pdev->dev) && !pdev->dev.of_node) {
 		dev_err(dev, "no device data specified\n");
 		return -ENOENT;
 	}
@@ -540,7 +540,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 		if (ret)
 			goto err_pdata_io_clk;
 	} else {
-		memcpy(pdata, pdev->dev.platform_data, sizeof(*pdata));
+		memcpy(pdata, dev_get_platdata(&pdev->dev), sizeof(*pdata));
 		sc->ext_cd_gpio = -1; /* invalid gpio number */
 	}
 
diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 6706b5e..a9215e3 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -459,7 +459,7 @@ static void sh_mmcif_release_dma(struct sh_mmcif_host *host)
 
 static void sh_mmcif_clock_control(struct sh_mmcif_host *host, unsigned int clk)
 {
-	struct sh_mmcif_plat_data *p = host->pd->dev.platform_data;
+	struct sh_mmcif_plat_data *p = dev_get_platdata(&host->pd->dev);
 	bool sup_pclk = p ? p->sup_pclk : false;
 
 	sh_mmcif_bitclr(host, MMCIF_CE_CLK_CTRL, CLK_ENABLE);
@@ -956,7 +956,7 @@ static int sh_mmcif_clk_update(struct sh_mmcif_host *host)
 
 static void sh_mmcif_set_power(struct sh_mmcif_host *host, struct mmc_ios *ios)
 {
-	struct sh_mmcif_plat_data *pd = host->pd->dev.platform_data;
+	struct sh_mmcif_plat_data *pd = dev_get_platdata(&host->pd->dev);
 	struct mmc_host *mmc = host->mmc;
 
 	if (pd && pd->set_pwr)
@@ -985,7 +985,8 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (ios->power_mode == MMC_POWER_UP) {
 		if (!host->card_present) {
 			/* See if we also get DMA */
-			sh_mmcif_request_dma(host, host->pd->dev.platform_data);
+			sh_mmcif_request_dma(host,
+				dev_get_platdata(&host->pd->dev));
 			host->card_present = true;
 		}
 		sh_mmcif_set_power(host, ios);
@@ -1027,7 +1028,7 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 static int sh_mmcif_get_cd(struct mmc_host *mmc)
 {
 	struct sh_mmcif_host *host = mmc_priv(mmc);
-	struct sh_mmcif_plat_data *p = host->pd->dev.platform_data;
+	struct sh_mmcif_plat_data *p = dev_get_platdata(&host->pd->dev);
 	int ret = mmc_gpio_get_cd(mmc);
 
 	if (ret >= 0)
@@ -1324,7 +1325,7 @@ static void mmcif_timeout_work(struct work_struct *work)
 
 static void sh_mmcif_init_ocr(struct sh_mmcif_host *host)
 {
-	struct sh_mmcif_plat_data *pd = host->pd->dev.platform_data;
+	struct sh_mmcif_plat_data *pd = dev_get_platdata(&host->pd->dev);
 	struct mmc_host *mmc = host->mmc;
 
 	mmc_regulator_get_supply(mmc);
@@ -1343,7 +1344,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	int ret = 0, irq[2];
 	struct mmc_host *mmc;
 	struct sh_mmcif_host *host;
-	struct sh_mmcif_plat_data *pd = pdev->dev.platform_data;
+	struct sh_mmcif_plat_data *pd = dev_get_platdata(&pdev->dev);
 	struct resource *res;
 	void __iomem *reg;
 	const char *name;
diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index ebea749..9187569 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -72,14 +72,14 @@ static void sh_mobile_sdhi_clk_disable(struct platform_device *pdev)
 
 static void sh_mobile_sdhi_set_pwr(struct platform_device *pdev, int state)
 {
-	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
+	struct sh_mobile_sdhi_info *p = dev_get_platdata(&pdev->dev);
 
 	p->set_pwr(pdev, state);
 }
 
 static int sh_mobile_sdhi_get_cd(struct platform_device *pdev)
 {
-	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
+	struct sh_mobile_sdhi_info *p = dev_get_platdata(&pdev->dev);
 
 	return p->get_cd(pdev);
 }
@@ -140,7 +140,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		of_match_device(sh_mobile_sdhi_of_match, &pdev->dev);
 	struct sh_mobile_sdhi *priv;
 	struct tmio_mmc_data *mmc_data;
-	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
+	struct sh_mobile_sdhi_info *p = dev_get_platdata(&pdev->dev);
 	struct tmio_mmc_host *host;
 	int irq, ret, i = 0;
 	bool multiplexed_isr = true;
@@ -299,7 +299,7 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 {
 	struct mmc_host *mmc = platform_get_drvdata(pdev);
 	struct tmio_mmc_host *host = mmc_priv(mmc);
-	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
+	struct sh_mobile_sdhi_info *p = dev_get_platdata(&pdev->dev);
 
 	tmio_mmc_host_remove(host);
 
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index 8860d4d..479824d 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -67,7 +67,7 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 	if (pdev->num_resources != 2)
 		goto out;
 
-	pdata = pdev->dev.platform_data;
+	pdata = dev_get_platdata(&pdev->dev);
 	if (!pdata || !pdata->hclk)
 		goto out;
 
-- 
1.7.10.4


