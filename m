From: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Subject: [PATCH 1/2] mmc: host: arasan: Add addition of-arasan quirks and add IOMMU support.
Date: Mon, 15 Dec 2014 22:31:06 +0530
Message-ID: <1418662867-9210-2-git-send-email-stripathi@apm.com>
References: <1418662867-9210-1-git-send-email-stripathi@apm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418662867-9210-1-git-send-email-stripathi-qTEPVZfXA3Y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Due to the fact that the existing of-arasan driver works with 32-bit platforms.
This patch tweaks existing of-arasan driver to work with 64-bit platform using
IOMMU translation.

In addition it adds support for more quirks and quirks2 obtained from device tree
inside the generic sdhci-platform(sdhci-pltfm.c) driver.

Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
---
 drivers/mmc/host/Kconfig           |  1 +
 drivers/mmc/host/sdhci-of-arasan.c | 54 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pltfm.c     | 12 +++++++++
 3 files changed, 67 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 4511358..0c6dc47 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -108,6 +108,7 @@ config MMC_SDHCI_OF_ARASAN
 	tristate "SDHCI OF support for the Arasan SDHCI controllers"
 	depends on MMC_SDHCI_PLTFM
 	depends on OF
+	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Arasan Secure Digital Host Controller Interface
 	  (SDHCI). This hardware is found e.g. in Xilinx' Zynq SoC.
diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 5bd1092..c0e0c9b 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -20,6 +20,10 @@
  */

 #include <linux/module.h>
+#if defined(CONFIG_IOMMU_SUPPORT)
+#include <linux/amba/bus.h>
+#include <linux/iommu.h>
+#endif
 #include "sdhci-pltfm.h"

 #define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
@@ -34,8 +38,46 @@
  */
 struct sdhci_arasan_data {
 	struct clk	*clk_ahb;
+#if defined(CONFIG_IOMMU_SUPPORT)
+	struct iommu_domain *domain;
+#endif
 };

+static void sdhci_arasan_write_l(struct sdhci_host *host, u32 val, int reg)
+{
+#if defined(CONFIG_IOMMU_SUPPORT)
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
+	/*
+	 * This allows the arasan IP to integrate with 64-bit platform.
+	 * As the AHB dma masters generates 32-bit address so it needs
+	 * IO translation of 32-bit to 42-bit AXI address with help of IOMMU.
+	 */
+	if (reg == SDHCI_DMA_ADDRESS) {
+	        phys_addr_t dma_addr = sg_dma_address(host->data->sg);
+		sdhci_arasan->domain->ops->map(sdhci_arasan->domain, 0,
+					       dma_addr, 0, 0);
+	}
+#endif
+	writel(val, host->ioaddr + reg);
+}
+
+static  u32 xgene_sdhci_readl(struct sdhci_host *host, int reg)
+{
+#if defined(CONFIG_IOMMU_SUPPORT)
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
+
+	if (reg == SDHCI_INT_STATUS ) {
+		if ((readl(host->ioaddr + reg) & SDHCI_INT_DATA_MASK) ==
+		     SDHCI_INT_DMA_END)
+			sdhci_arasan->domain->ops->unmap(sdhci_arasan->domain,
+							 0, 0);
+	}
+#endif
+	return readl(host->ioaddr + reg);
+}
+
 static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host *host)
 {
 	u32 div;
@@ -58,6 +100,8 @@ static struct sdhci_ops sdhci_arasan_ops = {
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.write_l = sdhci_arasan_write_l,
+	.read_l = xgene_sdhci_readl,
 };

 static struct sdhci_pltfm_data sdhci_arasan_pdata = {
@@ -162,6 +206,16 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		goto clk_dis_ahb;
 	}

+#if defined(CONFIG_IOMMU_SUPPORT)
+	sdhci_arasan->domain = iommu_domain_alloc(&amba_bustype);
+	if (!sdhci_arasan->domain) {
+		dev_err(&pdev->dev, "Unable to allocate iommu domain\n");
+		return PTR_ERR(sdhci_arasan->domain);
+	}
+
+	iommu_attach_device(sdhci_arasan->domain, &pdev->dev);
+#endif
+
 	host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata, 0);
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 7e834fb..08a97dc 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -90,6 +90,18 @@ void sdhci_get_of_property(struct platform_device *pdev)
 		if (of_get_property(np, "broken-cd", NULL))
 			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;

+		if (of_get_property(np, "delay-after-power", NULL))
+			host->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;
+
+		if (of_get_property(np, "no-hispd", NULL))
+			host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
+
+		if (of_get_property(np, "broken-adma", NULL))
+			host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
+
+		if (of_get_property(np, "no-cmd23", NULL))
+			host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
+
 		if (of_get_property(np, "no-1-8-v", NULL))
 			host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;

--
1.8.2.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
