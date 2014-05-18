From: Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH 2/3] mmc: Add APM X-Gene SoC SDHC controller support to Arasan SDHCI driver
Date: Sun, 18 May 2014 01:41:57 -0600
Message-ID: <1400398918-1502-3-git-send-email-lho@apm.com>
References: <1400398918-1502-1-git-send-email-lho@apm.com>
 <1400398918-1502-2-git-send-email-lho@apm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1400398918-1502-2-git-send-email-lho-qTEPVZfXA3Y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This patch adds support for the APM X-Gene SoC SDHC controller
to Arasan SDHCI driver.

Signed-off-by: Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>
---
 drivers/mmc/host/Kconfig           |    4 +-
 drivers/mmc/host/sdhci-of-arasan.c |  126 +++++++++++++++++++++++++++++++++---
 2 files changed, 120 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 8aaf8c1..7ec5414 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -108,9 +108,11 @@ config MMC_SDHCI_OF_ARASAN
 	tristate "SDHCI OF support for the Arasan SDHCI controllers"
 	depends on MMC_SDHCI_PLTFM
 	depends on OF
+	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Arasan Secure Digital Host Controller Interface
-	  (SDHCI). This hardware is found e.g. in Xilinx' Zynq SoC.
+	  (SDHCI). This hardware is found e.g. in Xilinx' Zynq and X-Gene
+	  SoC.
 
 	  If you have a controller with this interface, say Y or M here.
 
diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index f7c7cf6..2ef527f 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -20,6 +20,8 @@
  */
 
 #include <linux/module.h>
+#include <linux/dma-mapping.h>
+#include <linux/of_device.h>
 #include "sdhci-pltfm.h"
 
 #define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
@@ -34,6 +36,19 @@
  */
 struct sdhci_arasan_data {
 	struct clk	*clk_ahb;
+	struct platform_device *pdev;
+	void __iomem	*ahb_aim_csr;
+	const struct sdhci_arasan_ahb_ops *ahb_ops;
+};
+
+/**
+ * struct sdhci_arasan_ahb_ops
+ * @init_ahb	Initialize translation bus
+ * @xlat_addr	Set up an 64-bit addressing translation
+ */
+struct sdhci_arasan_ahb_ops {
+	int (*init_ahb)(struct sdhci_arasan_data *data);
+	void (*xlat_addr)(struct sdhci_arasan_data *data, u64 dma_addr);
 };
 
 static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
@@ -51,7 +66,21 @@ static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
 	return freq;
 }
 
+static void sdhci_arasan_writel(struct sdhci_host *host, u32 val, int reg)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
+
+	if (reg == SDHCI_DMA_ADDRESS) {
+		if (sdhci_arasan->ahb_ops && sdhci_arasan->ahb_ops->xlat_addr)
+			sdhci_arasan->ahb_ops->xlat_addr(sdhci_arasan,
+				sg_dma_address(host->data->sg));
+	}
+	writel(val, host->ioaddr + reg);
+}
+
 static struct sdhci_ops sdhci_arasan_ops = {
+	.write_l = sdhci_arasan_writel,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_arasan_get_timeout_clock,
 };
@@ -121,13 +150,83 @@ static int sdhci_arasan_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
 			 sdhci_arasan_resume);
 
+static int sdhci_arasan_xgene_init_ahb(struct sdhci_arasan_data *data)
+{
+	#define AIM_SIZE_CTL_OFFSET	0x00000004
+	#define  AIM_EN_N_WR(src)	(((u32) (src) << 31) & 0x80000000)
+	#define  ARSB_WR(src)		(((u32) (src) << 24) & 0x0f000000)
+	#define  AWSB_WR(src)		(((u32) (src) << 20) & 0x00f00000)
+	#define  AIM_MASK_N_WR(src)	(((u32) (src)) & 0x000fffff)
+
+	struct sdhci_host *host = platform_get_drvdata(data->pdev);
+	int ret;
+
+	if (!data->ahb_aim_csr)
+		return 0;
+
+	/*
+	 * Setup AHB AIM windows ctrl register. The lower 32-bit is left
+	 * at 0 while the upper bit are programmed when the buffer address
+	 ( is set from function sdhci_arasn_writel.
+	 */
+	writel(AIM_EN_N_WR(1) | ARSB_WR(1) | AWSB_WR(1) | AIM_MASK_N_WR(0),
+	       data->ahb_aim_csr + AIM_SIZE_CTL_OFFSET);
+
+	/* Set DMA mask */
+	ret = dma_set_mask_and_coherent(&data->pdev->dev, DMA_BIT_MASK(64));
+	if (ret) {
+		dev_err(&data->pdev->dev, "Unable to set dma mask\n");
+		return ret;
+	}
+
+	/*
+	 * This shouldn't be necessary. Just in case the FW doesn't
+	 * configure disable ADMA support as we can't support multiple
+	 * DMA buffer whose address is 64-bit. The AHB translation bridge
+	 * only has 8 entry max and that is required to be shared and
+	 * upper layer can pass more than 8 buffer pointers.
+	 */
+	host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
+
+	return 0;
+}
+
+static void sdhci_arasn_xgene_xlat_addr(struct sdhci_arasan_data *data,
+				       u64 dma_addr)
+{
+	#define AIM_AXI_HI_OFFSET	0x0000000c
+	#define  AIM_AXI_ADDRESS_HI_N_WR(src) \
+					(((u32) (src) << 20) & 0xfff00000)
+
+	if (!data->ahb_aim_csr)
+		return;
+
+	writel(AIM_AXI_ADDRESS_HI_N_WR(dma_addr >> 32),
+		data->ahb_aim_csr + AIM_AXI_HI_OFFSET);
+}
+
+static const struct sdhci_arasan_ahb_ops xgene_ahb_ops = {
+	.init_ahb = sdhci_arasan_xgene_init_ahb,
+	.xlat_addr = sdhci_arasn_xgene_xlat_addr,
+};
+
+static const struct of_device_id sdhci_arasan_of_match[] = {
+	{ .compatible = "arasan,sdhci-8.9a" },
+	{ .compatible = "xgene,arasan,sdhci-8.9a", .data = &xgene_ahb_ops },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
+
 static int sdhci_arasan_probe(struct platform_device *pdev)
 {
 	int ret;
-	struct clk *clk_xin;
+	struct clk *clk_xin = NULL;
 	struct sdhci_host *host;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_arasan_data *sdhci_arasan;
+	const struct of_device_id *of_id =
+			of_match_device(sdhci_arasan_of_match, &pdev->dev);
+	struct resource *res;
 
 	sdhci_arasan = devm_kzalloc(&pdev->dev, sizeof(*sdhci_arasan),
 			GFP_KERNEL);
@@ -136,8 +235,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 	sdhci_arasan->clk_ahb = devm_clk_get(&pdev->dev, "clk_ahb");
 	if (IS_ERR(sdhci_arasan->clk_ahb)) {
-		dev_err(&pdev->dev, "clk_ahb clock not found.\n");
-		return PTR_ERR(sdhci_arasan->clk_ahb);
+		/* Clock is optional */
+		sdhci_arasan->clk_ahb = NULL;
+		goto skip_clk;
 	}
 
 	clk_xin = devm_clk_get(&pdev->dev, "clk_xin");
@@ -157,6 +257,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Unable to enable SD clock.\n");
 		goto clk_dis_ahb;
 	}
+skip_clk:
 
 	host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata, 0);
 	if (IS_ERR(host)) {
@@ -170,6 +271,19 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	pltfm_host->priv = sdhci_arasan;
 	pltfm_host->clk = clk_xin;
 
+	/* Retrieval optional AHB translation memory resource */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	sdhci_arasan->ahb_aim_csr = devm_ioremap(&pdev->dev, res->start,
+						 resource_size(res));
+
+	sdhci_arasan->pdev = pdev;
+	sdhci_arasan->ahb_ops = of_id->data;
+	if (sdhci_arasan->ahb_ops && sdhci_arasan->ahb_ops->init_ahb) {
+		ret = sdhci_arasan->ahb_ops->init_ahb(sdhci_arasan);
+		if (ret)
+			goto err_pltfm_free;
+	}
+
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_err(&pdev->dev, "platform register failed (%u)\n", ret);
@@ -200,12 +314,6 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
 	return sdhci_pltfm_unregister(pdev);
 }
 
-static const struct of_device_id sdhci_arasan_of_match[] = {
-	{ .compatible = "arasan,sdhci-8.9a" },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
-
 static struct platform_driver sdhci_arasan_driver = {
 	.driver = {
 		.name = "sdhci-arasan",
-- 
1.5.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
