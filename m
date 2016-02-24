From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH] mmc: sdhci-tegra: Set DMA mask
Date: Wed, 24 Feb 2016 18:11:19 +0900
Message-ID: <1456305079-27779-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3154 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755628AbcBXJLX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Feb 2016 04:11:23 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, gnurou@gmail.com, Alexandre Courbot <acourbot@nvidia.com>

On T210, the sdhci controller can address more than 32 bits of address
space. Failing to express this fact results in the use of bounce
buffers and affects performance.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
I am pretty sure this one is wrong in some way, but just to get the ball
rolling as the use of bounce buffers is currently quite heavy on Jetson TX1.

Thierry, Stephen, could you confirm that I got the DMA masks correctly? I
am not sure about the actual addressable size on TX1, and also suspect TK1 can
also address more than 32 bits.

Also, I noticed that sdhci_host has a dma_mask member which I thought would do
the trick but actually doesn't seem to be used for anything useful. Could the
MMC maintainers comment on this and let me know if the DMA mask setting should
be moved at the core level instead of being done per-driver?

 drivers/mmc/host/sdhci-tegra.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 83c4bf7bc16c..50a97c5845e8 100644
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
@@ -380,6 +386,9 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 		return -EINVAL;
 	soc_data = match->data;
 
+	if (soc_data->dma_mask)
+		dma_set_mask(&pdev->dev, soc_data->dma_mask);
+
 	host = sdhci_pltfm_init(pdev, soc_data->pdata, 0);
 	if (IS_ERR(host))
 		return PTR_ERR(host);
-- 
2.7.1

