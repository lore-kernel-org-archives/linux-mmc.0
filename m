From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 2/7] mmc: sdhci-omap: Add using external dma
Date: Fri, 11 Jan 2019 16:38:46 +0530
Message-ID: <20190111110851.6805-3-faiz_abbas@ti.com>
References: <20190111110851.6805-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190111110851.6805-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: zhang.chunyan@linaro.org, kishon@ti.com, adrian.hunter@intel.com, mark.rutland@arm.com, robh+dt@kernel.org, ulf.hansson@linaro.org, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

From: Chunyan Zhang <zhang.chunyan@linaro.org>

sdhci-omap can support both external dma controller via dmaengine framework
as well as ADMA which standard SD host controller provides.

Fixes by Faiz Abbas <fazi_abbas@ti.com>:
1. Switch to DMA slave mode when using external DMA
2. Add offset to mapbase

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/Kconfig      |  1 +
 drivers/mmc/host/sdhci-omap.c | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 333292e8ecdd..70e90b00cb37 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -979,6 +979,7 @@ config MMC_SDHCI_OMAP
 	depends on MMC_SDHCI_PLTFM && OF
 	select THERMAL
 	select TI_SOC_THERMAL
+	select MMC_SDHCI_EXTERNAL_DMA if DMA_ENGINE
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  support present in TI's DRA7 SOCs. The controller supports
diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index c11c18a9aacb..8a05e94fe612 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -696,7 +696,11 @@ static int sdhci_omap_enable_dma(struct sdhci_host *host)
 	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
 
 	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_CON);
-	reg |= CON_DMA_MASTER;
+	reg &= ~CON_DMA_MASTER;
+	/* Switch to DMA slave mode when using external DMA */
+	if (!host->use_external_dma)
+		reg |= CON_DMA_MASTER;
+
 	sdhci_omap_writel(omap_host, SDHCI_OMAP_CON, reg);
 
 	return 0;
@@ -1010,6 +1014,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	struct sdhci_omap_data *data;
 	const struct soc_device_attribute *soc;
+	struct resource *regs;
 
 	match = of_match_device(omap_sdhci_match, dev);
 	if (!match)
@@ -1022,6 +1027,10 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	}
 	offset = data->offset;
 
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs)
+		return -ENXIO;
+
 	host = sdhci_pltfm_init(pdev, &sdhci_omap_pdata,
 				sizeof(*omap_host));
 	if (IS_ERR(host)) {
@@ -1038,6 +1047,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	omap_host->timing = MMC_TIMING_LEGACY;
 	omap_host->flags = data->flags;
 	host->ioaddr += offset;
+	host->mapbase = regs->start + offset;
 
 	mmc = host->mmc;
 	sdhci_get_of_property(pdev);
@@ -1105,6 +1115,10 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	host->mmc_host_ops.execute_tuning = sdhci_omap_execute_tuning;
 	host->mmc_host_ops.enable_sdio_irq = sdhci_omap_enable_sdio_irq;
 
+	/* Switch to external DMA only if there is the "dmas" property */
+	if (of_find_property(dev->of_node, "dmas", NULL))
+		sdhci_switch_external_dma(host, true);
+
 	ret = sdhci_setup_host(host);
 	if (ret)
 		goto err_put_sync;
-- 
2.19.2
