From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH] mmc: sdhci-pltfm: add calling mmc_of_parse in sdhci_pltfm_register
Date: Fri,  8 Mar 2013 12:52:51 +0800
Message-ID: <1362718371-5074-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:40002 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759557Ab3CHEwv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Mar 2013 23:52:51 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>

commit 6c56e7a0 provide a function mmc_of_parse for standard MMC
device-tree binding parser centrally. So just call it with
sdhci_get_of_property together in sdhci_pltfm_register.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-pltfm.c |   56 +++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index e605509..0c5eb6a 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -71,42 +71,43 @@ void sdhci_get_of_property(struct platform_device *pdev)
 	u32 bus_width;
 	int size;
 
-	if (of_device_is_available(np)) {
-		if (of_get_property(np, "sdhci,auto-cmd12", NULL))
-			host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
+	if (!of_device_is_available(np))
+		return;
 
-		if (of_get_property(np, "sdhci,1-bit-only", NULL) ||
-		    (of_property_read_u32(np, "bus-width", &bus_width) == 0 &&
-		    bus_width == 1))
-			host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
+	if (of_get_property(np, "sdhci,auto-cmd12", NULL))
+		host->quirks |= SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
 
-		if (sdhci_of_wp_inverted(np))
-			host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
+	if (of_get_property(np, "sdhci,1-bit-only", NULL) ||
+		(of_property_read_u32(np, "bus-width", &bus_width) == 0 &&
+		bus_width == 1))
+		host->quirks |= SDHCI_QUIRK_FORCE_1_BIT_DATA;
 
-		if (of_get_property(np, "broken-cd", NULL))
-			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+	if (sdhci_of_wp_inverted(np))
+		host->quirks |= SDHCI_QUIRK_INVERTED_WRITE_PROTECT;
 
-		if (of_get_property(np, "no-1-8-v", NULL))
-			host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
+	if (of_get_property(np, "broken-cd", NULL))
+		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
-		if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
-			host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
+	if (of_get_property(np, "no-1-8-v", NULL))
+		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 
-		if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
-		    of_device_is_compatible(np, "fsl,p1010-esdhc") ||
-		    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
-			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
+	if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
+		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
 
-		clk = of_get_property(np, "clock-frequency", &size);
-		if (clk && size == sizeof(*clk) && *clk)
-			pltfm_host->clock = be32_to_cpup(clk);
+	if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
+			of_device_is_compatible(np, "fsl,p1010-esdhc") ||
+			of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
+		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
-		if (of_find_property(np, "keep-power-in-suspend", NULL))
-			host->mmc->pm_caps |= MMC_PM_KEEP_POWER;
+	clk = of_get_property(np, "clock-frequency", &size);
+	if (clk && size == sizeof(*clk) && *clk)
+		pltfm_host->clock = be32_to_cpup(clk);
 
-		if (of_find_property(np, "enable-sdio-wakeup", NULL))
-			host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
-	}
+	if (of_find_property(np, "keep-power-in-suspend", NULL))
+		host->mmc->pm_caps |= MMC_PM_KEEP_POWER;
+
+	if (of_find_property(np, "enable-sdio-wakeup", NULL))
+		host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
 }
 #else
 void sdhci_get_of_property(struct platform_device *pdev) {}
@@ -212,6 +213,7 @@ int sdhci_pltfm_register(struct platform_device *pdev,
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
+	mmc_of_parse(host->mmc);
 	sdhci_get_of_property(pdev);
 
 	ret = sdhci_add_host(host);
-- 
1.7.9.5

