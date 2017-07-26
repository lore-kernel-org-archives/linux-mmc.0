From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH] mmc: sdhci-of-at91: force card detect value for non removable devices
Date: Wed, 26 Jul 2017 16:02:46 +0200
Message-ID: <20170726140246.4775-1-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:36675 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751421AbdGZODk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Jul 2017 10:03:40 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, nicolas.ferre@microchip.com, Ludovic Desroches <ludovic.desroches@microchip.com>

When the device is non removable, the card detect signal is often use
for another purpose i.e. muxed to another SoC peripheral or used as a
GPIO. It could lead to wrong behaviors depending the defaut value of
this signal if not muxed to the SDHCI controller.

Fixes: bb5f8ea4d514 ("mmc: sdhci-of-at91: introduce driver for the Atmel SDMMC")
Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/mmc/host/sdhci-of-at91.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 88e9b5f35a62..6a389f35396e 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -31,6 +31,7 @@
 
 #define SDMMC_MC1R	0x204
 #define		SDMMC_MC1R_DDR		BIT(3)
+#define		SDMMC_MC1R_FCD		BIT(7)
 #define SDMMC_CACR	0x230
 #define		SDMMC_CACR_CAPWREN	BIT(0)
 #define		SDMMC_CACR_KEY		(0x46 << 8)
@@ -44,6 +45,15 @@ struct sdhci_at91_priv {
 	bool restore_needed;
 };
 
+static void sdhci_at91_set_force_card_detect(struct sdhci_host *host)
+{
+	u8 mc1r;
+
+	mc1r = readb(host->ioaddr + SDMMC_MC1R);
+	mc1r |= SDMMC_MC1R_FCD;
+	writeb(mc1r, host->ioaddr + SDMMC_MC1R);
+}
+
 static void sdhci_at91_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	u16 clk;
@@ -111,10 +121,18 @@ void sdhci_at91_set_uhs_signaling(struct sdhci_host *host, unsigned int timing)
 	sdhci_set_uhs_signaling(host, timing);
 }
 
+static void sdhci_at91_reset(struct sdhci_host *host, u8 mask)
+{
+	sdhci_reset(host, mask);
+
+	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
+		sdhci_at91_set_force_card_detect(host);
+}
+
 static const struct sdhci_ops sdhci_at91_sama5d2_ops = {
 	.set_clock		= sdhci_at91_set_clock,
 	.set_bus_width		= sdhci_set_bus_width,
-	.reset			= sdhci_reset,
+	.reset			= sdhci_at91_reset,
 	.set_uhs_signaling	= sdhci_at91_set_uhs_signaling,
 	.set_power		= sdhci_at91_set_power,
 };
@@ -369,6 +387,22 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 	}
 
+	/*
+	 * If the device attached to the MMC bus is not removable, it is safer
+	 * to set the Force Card Detect bit. People often don't connect the
+	 * card detect signal and use this pin for another purpose. If the card
+	 * detect pin is not muxed to SDHCI controller, a default value is
+	 * used. This value can be different from a SoC revision to another
+	 * one. Problems come when this default value is not card present. To
+	 * avoid this case, if the device is non removable then the card
+	 * detection procedure using the SDMCC_CD signal is bypassed.
+	 * This bit is resetted when a software reset for all command is
+	 * performed so we need to implement our own reset function to set back
+	 * this bit.
+	 */
+	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
+		sdhci_at91_set_force_card_detect(host);
+
 	pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
-- 
2.12.2

