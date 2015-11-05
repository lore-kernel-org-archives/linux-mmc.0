From: Al Cooper <alcooperx@gmail.com>
Subject: [PATCH 2/4] mmc: sdhci-pltfm: Add DT properties to set various QUIRKS
Date: Thu, 5 Nov 2015 17:39:58 -0500
Message-ID: <1446763200-10234-2-git-send-email-alcooperx@gmail.com>
References: <1446763200-10234-1-git-send-email-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:15937 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756621AbbKEXFf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2015 18:05:35 -0500
In-Reply-To: <1446763200-10234-1-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc: Al Cooper <alcooperx@gmail.com>

Add support for "broken-sdr50", "broken-ddr50", "broken-64-bit-dma"
and "broken-timeout-value" device tree properties.
The properties will cause the corresponding quirks bits to be set.
This allows some of the platform specific QUIRKS setting to be
moved out of the driver and into the Device Tree node.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/host/sdhci-pltfm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 87fb5ea..81eb4d2 100644
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
@@ -106,6 +110,10 @@ void sdhci_get_of_property(struct platform_device *pdev)
 
 	if (of_find_property(np, "enable-sdio-wakeup", NULL))
 		host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
+	if (of_find_property(np, "broken-sdr50", NULL))
+		host->quirks2 |= SDHCI_QUIRK2_BROKEN_SDR50;
+	if (of_find_property(np, "broken-ddr50", NULL))
+		host->quirks2 |= SDHCI_QUIRK2_BROKEN_DDR50;
 }
 #else
 void sdhci_get_of_property(struct platform_device *pdev) {}
-- 
1.9.0.138.g2de3478

