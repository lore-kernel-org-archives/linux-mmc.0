From: Al Cooper <alcooperx@gmail.com>
Subject: [PATCH V2 1/3] mmc: sdhci-pltfm: Add DT properties to set various QUIRKS
Date: Fri, 6 Nov 2015 13:56:02 -0500
Message-ID: <1446836164-16259-2-git-send-email-alcooperx@gmail.com>
References: <1446836164-16259-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:58394 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354AbbKFS4p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Nov 2015 13:56:45 -0500
In-Reply-To: <1446836164-16259-1-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc: Al Cooper <alcooperx@gmail.com>

Add support for "broken-ddr50", "broken-64-bit-dma"
and "broken-timeout-value" device tree properties.
The properties will cause the corresponding quirks bits to be set.
This allows some of the platform specific QUIRKS setting to be
moved out of the driver and into the Device Tree node.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/host/sdhci-pltfm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 87fb5ea..cc0730c 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -90,10 +90,14 @@ void sdhci_get_of_property(struct platform_device *pdev)
 	if (of_get_property(np, "no-1-8-v", NULL))
 		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 
+	if (of_get_property(np, "broken-64-bit-dma", NULL))
+		host->quirks2 |= SDHCI_QUIRK2_BROKEN_64_BIT_DMA;
+
 	if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
 		host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
 
-	if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
+	if (of_get_property(np, "broken-timeout-value", NULL) ||
+	    of_device_is_compatible(np, "fsl,p2020-esdhc") ||
 	    of_device_is_compatible(np, "fsl,p1010-esdhc") ||
 	    of_device_is_compatible(np, "fsl,t4240-esdhc") ||
 	    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
@@ -106,6 +110,8 @@ void sdhci_get_of_property(struct platform_device *pdev)
 
 	if (of_find_property(np, "enable-sdio-wakeup", NULL))
 		host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
+	if (of_find_property(np, "broken-ddr50", NULL))
+		host->quirks2 |= SDHCI_QUIRK2_BROKEN_DDR50;
 }
 #else
 void sdhci_get_of_property(struct platform_device *pdev) {}
-- 
1.9.0.138.g2de3478

