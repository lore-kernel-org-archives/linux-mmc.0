From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v3 2/3] mmc: sdhci-acpi: Remove enable_dma() hook
Date: Fri, 4 Mar 2016 19:38:44 +0900
Message-ID: <1457087925-992-3-git-send-email-acourbot@nvidia.com>
References: <1457087925-992-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3639 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811AbcCDKjs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Mar 2016 05:39:48 -0500
In-Reply-To: <1457087925-992-1-git-send-email-acourbot@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, gnurou@gmail.com, Alexandre Courbot <acourbot@nvidia.com>

This hook was solely used to set the DMA mask, which is now done
by the newly-added sdhci_set_dma_mask() function.

The use of a flag to ensure the mask is only set once is a strong hint
that it should not have been done there anyway.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/mmc/host/sdhci-acpi.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 195ff0853dc8..416da6f3629c 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -75,7 +75,6 @@ struct sdhci_acpi_host {
 	const struct sdhci_acpi_slot	*slot;
 	struct platform_device		*pdev;
 	bool				use_runtime_pm;
-	bool				dma_setup;
 };
 
 static inline bool sdhci_acpi_flag(struct sdhci_acpi_host *c, unsigned int flag)
@@ -83,33 +82,6 @@ static inline bool sdhci_acpi_flag(struct sdhci_acpi_host *c, unsigned int flag)
 	return c->slot && (c->slot->flags & flag);
 }
 
-static int sdhci_acpi_enable_dma(struct sdhci_host *host)
-{
-	struct sdhci_acpi_host *c = sdhci_priv(host);
-	struct device *dev = &c->pdev->dev;
-	int err = -1;
-
-	if (c->dma_setup)
-		return 0;
-
-	if (host->flags & SDHCI_USE_64_BIT_DMA) {
-		if (host->quirks2 & SDHCI_QUIRK2_BROKEN_64_BIT_DMA) {
-			host->flags &= ~SDHCI_USE_64_BIT_DMA;
-		} else {
-			err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
-			if (err)
-				dev_warn(dev, "Failed to set 64-bit DMA mask\n");
-		}
-	}
-
-	if (err)
-		err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
-
-	c->dma_setup = !err;
-
-	return err;
-}
-
 static void sdhci_acpi_int_hw_reset(struct sdhci_host *host)
 {
 	u8 reg;
@@ -127,7 +99,6 @@ static void sdhci_acpi_int_hw_reset(struct sdhci_host *host)
 
 static const struct sdhci_ops sdhci_acpi_ops_dflt = {
 	.set_clock = sdhci_set_clock,
-	.enable_dma = sdhci_acpi_enable_dma,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
@@ -135,7 +106,6 @@ static const struct sdhci_ops sdhci_acpi_ops_dflt = {
 
 static const struct sdhci_ops sdhci_acpi_ops_int = {
 	.set_clock = sdhci_set_clock,
-	.enable_dma = sdhci_acpi_enable_dma,
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
-- 
2.7.2

