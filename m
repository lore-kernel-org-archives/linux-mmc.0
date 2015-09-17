From: Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH] mmc: sdhci-pltfm: Use of_property_read_u32 instead of open-coding it
Date: Thu, 17 Sep 2015 14:07:26 +0200
Message-ID: <1442491646-9421-1-git-send-email-tklauser@distanz.ch>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.zhinst.com ([212.126.164.98]:58610 "EHLO mail.zhinst.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600AbbIQMMb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 Sep 2015 08:12:31 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

Use of_property_read_u32 instead of of_get_property with return value
checks and endianness conversion.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/mmc/host/sdhci-pltfm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index a207f5a..58721fb 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -71,9 +71,8 @@ void sdhci_get_of_property(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	const __be32 *clk;
+	u32 clk;
 	u32 bus_width;
-	int size;
 
 	if (of_get_property(np, "sdhci,auto-cmd12", NULL))
 		host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
@@ -101,9 +100,8 @@ void sdhci_get_of_property(struct platform_device *pdev)
 	    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
-	clk = of_get_property(np, "clock-frequency", &size);
-	if (clk && size == sizeof(*clk) && *clk)
-		pltfm_host->clock = be32_to_cpup(clk);
+	if (of_property_read_u32(np, "clock-frequency", &clk) == 0)
+		pltfm_host->clock = clk;
 
 	if (of_find_property(np, "keep-power-in-suspend", NULL))
 		host->mmc->pm_caps |= MMC_PM_KEEP_POWER;
-- 
2.5.0


