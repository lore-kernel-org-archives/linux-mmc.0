From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH 2/4] mmc: sdhci-pltfm: avoid indentation in sdhci_get_of_property
Date: Tue, 12 Mar 2013 12:35:51 +0800
Message-ID: <CADz5_gLQGkjrAbW+HsLxxJBefzPD-EarJ+5Eavkc14SbuRFvRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:40444 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006Ab3CLEfw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Mar 2013 00:35:52 -0400
Received: by mail-oa0-f47.google.com with SMTP id o17so5284107oag.6
        for <linux-mmc@vger.kernel.org>; Mon, 11 Mar 2013 21:35:52 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Chunhe Lan <Chunhe.Lan@freescale.com>, Stephen Warren <swarren@wwwdotorg.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <kliu5@marvell.com>

Return directly in case device node is unavailable to avoid indentation.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-pltfm.c |   55 ++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c
b/drivers/mmc/host/sdhci-pltfm.c index a536e55..0c5eb6a 100644
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
--
1.7.9.5
