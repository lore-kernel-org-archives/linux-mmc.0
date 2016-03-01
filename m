From: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 2/2] mmc: sdhci-tegra: Specify valid DMA mask
Date: Tue, 1 Mar 2016 13:32:44 +0900
Message-ID: <1456806764-16467-3-git-send-email-acourbot@nvidia.com>
References: <1456806764-16467-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456806764-16467-1-git-send-email-acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On T210, the sdhci controller can address more than 32 bits of address
space. Failing to express this fact results in the use of bounce
buffers and affects performance.

Signed-off-by: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/mmc/host/sdhci-tegra.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 83c4bf7bc16c..66808ac64db5 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -25,6 +25,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/gpio/consumer.h>
+#include <linux/dma-mapping.h>
 
 #include "sdhci-pltfm.h"
 
@@ -52,6 +53,7 @@
 struct sdhci_tegra_soc_data {
 	const struct sdhci_pltfm_data *pdata;
 	u32 nvquirks;
+	u64 dma_mask;
 };
 
 struct sdhci_tegra {
@@ -289,6 +291,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra20 = {
 	.pdata = &sdhci_tegra20_pdata,
 	.nvquirks = NVQUIRK_FORCE_SDHCI_SPEC_200 |
 		    NVQUIRK_ENABLE_BLOCK_GAP_DET,
+	.dma_mask = DMA_BIT_MASK(32),
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra30_pdata = {
@@ -307,6 +310,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra30 = {
 	.nvquirks = NVQUIRK_ENABLE_SDHCI_SPEC_300 |
 		    NVQUIRK_ENABLE_SDR50 |
 		    NVQUIRK_ENABLE_SDR104,
+	.dma_mask = DMA_BIT_MASK(32),
 };
 
 static const struct sdhci_ops tegra114_sdhci_ops = {
@@ -338,6 +342,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra114 = {
 	.nvquirks = NVQUIRK_ENABLE_SDR50 |
 		    NVQUIRK_ENABLE_DDR50 |
 		    NVQUIRK_ENABLE_SDR104,
+	.dma_mask = DMA_BIT_MASK(32),
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
@@ -353,6 +358,7 @@ static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
 
 static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
 	.pdata = &sdhci_tegra210_pdata,
+	.dma_mask = DMA_BIT_MASK(34),
 };
 
 static const struct of_device_id sdhci_tegra_dt_match[] = {
@@ -385,6 +391,8 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 		return PTR_ERR(host);
 	pltfm_host = sdhci_priv(host);
 
+	host->dma_mask = soc_data->dma_mask;
+
 	tegra_host = devm_kzalloc(&pdev->dev, sizeof(*tegra_host), GFP_KERNEL);
 	if (!tegra_host) {
 		dev_err(mmc_dev(host->mmc), "failed to allocate tegra_host\n");
-- 
2.7.2
