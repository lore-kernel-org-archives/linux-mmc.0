From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 2/4] mmc: sdhci-esdhc-imx: Support of 1.8V is board specific
Date: Thu, 10 May 2012 11:33:17 +0200
Message-ID: <1336642399-4543-3-git-send-email-dirk.behme@de.bosch.com>
References: <1336642399-4543-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from imta21.fe.bosch.de ([139.15.243.226]:51587 "EHLO
	imta21.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757863Ab2EJJkW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 May 2012 05:40:22 -0400
Received: from smtp2-v.fe.bosch.de (imta24.fe.bosch.de [139.15.243.27])
	by imta21.fe.bosch.de (Postfix) with ESMTP id 168312805AF
	for <linux-mmc@vger.kernel.org>; Thu, 10 May 2012 11:30:54 +0200 (CEST)
Received: from vsmta14.fe.internet.bosch.com (unknown [10.4.98.30])
	by imta24.fe.bosch.de (Postfix) with ESMTP id F254BB0021A
	for <linux-mmc@vger.kernel.org>; Thu, 10 May 2012 11:30:07 +0200 (CEST)
Received: from localhost (vsgw2.fe.internet.bosch.com [10.4.98.13])
	by vsmta14.fe.internet.bosch.com (Postfix) with SMTP id BE3C41B40319
	for <linux-mmc@vger.kernel.org>; Thu, 10 May 2012 11:33:43 +0200 (CEST)
In-Reply-To: <1336642399-4543-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Eric Miao <eric.miao@linaro.org>, Philipp Ahmann <pahmann@de.adit-jv.com>

From: Eric Miao <eric.miao@linaro.org>

This fix is due to 1.8V not supported from board design, yet the SDHCI
controller capabilities do not reflect this, and the existing SD core driver
is assuming 1.8V by checking MMC_CAP_UHS_* bits only.

Signed-off-by: Eric Miao <eric.miao@linaro.org>
Signed-off-by: Philipp Ahmann <pahmann@de.adit-jv.com>
---
 arch/arm/plat-mxc/include/mach/esdhc.h |    2 ++
 drivers/mmc/core/sd.c                  |    8 ++++----
 drivers/mmc/host/sdhci-esdhc-imx.c     |   12 ++++++++++++
 include/linux/mmc/host.h               |    6 ++++++
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/esdhc.h b/arch/arm/plat-mxc/include/mach/esdhc.h
index aaf9748..4ab603e 100644
--- a/arch/arm/plat-mxc/include/mach/esdhc.h
+++ b/arch/arm/plat-mxc/include/mach/esdhc.h
@@ -32,6 +32,7 @@ enum cd_types {
  * @cd_gpio:	gpio for card_detect interrupt
  * @wp_type:	type of write_protect method (see wp_types enum above)
  * @cd_type:	type of card_detect method (see cd_types enum above)
+ * @vdd_180:	1.8V VDD supported
  */
 
 struct esdhc_platform_data {
@@ -39,5 +40,6 @@ struct esdhc_platform_data {
 	unsigned int cd_gpio;
 	enum wp_types wp_type;
 	enum cd_types cd_type;
+	int vdd_180;
 };
 #endif /* __ASM_ARCH_IMX_ESDHC_H */
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index c272c68..daf5f09 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -746,11 +746,11 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 		ocr |= SD_OCR_CCS;
 
 	/*
-	 * If the host supports one of UHS-I modes, request the card
-	 * to switch to 1.8V signaling level.
+	 * If the host supports one of UHS-I modes, and support 1.8V VDD,
+	 * request the card to switch to 1.8V signaling level.
 	 */
-	if (host->caps & (MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
-	    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 | MMC_CAP_UHS_DDR50))
+	if ((host->caps & (MMC_CAP_UHS)) &&
+	    (host->ocr_avail_sd & MMC_VDD_165_195))
 		ocr |= SD_OCR_S18R;
 
 	/* If the host can supply more than 150mA, XPC should be set to 1. */
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index bb89f5c..af2f581 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -450,6 +450,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	if (gpio_is_valid(boarddata->wp_gpio))
 		boarddata->wp_type = ESDHC_WP_GPIO;
 
+	if (of_get_property(np, "support-vdd-180", NULL))
+		boarddata->vdd_180 = 1;
 	return 0;
 }
 #else
@@ -538,6 +540,16 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		boarddata->wp_gpio = -EINVAL;
 	}
 
+	/* The imx6q uSDHC capabilities will always claim to support 1.8V
+	 * while this is board specific,  should be initialized properly
+	 */
+	if (is_imx6q_usdhc(imx_data)) {
+		host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
+		host->caps = readl(host->ioaddr + SDHCI_CAPABILITIES);
+		if (!boarddata->vdd_180)
+			host->caps &= ~SDHCI_CAN_VDD_180;
+	}
+
 	/* card_detect */
 	if (boarddata->cd_type != ESDHC_CD_GPIO)
 		boarddata->cd_gpio = -EINVAL;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index cbde4b7..6c5fc38 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -224,6 +224,12 @@ struct mmc_host {
 #define MMC_CAP_CMD23		(1 << 30)	/* CMD23 supported. */
 #define MMC_CAP_HW_RESET	(1 << 31)	/* Hardware reset */
 
+#define MMC_CAP_UHS		(MMC_CAP_UHS_SDR12 |\
+				 MMC_CAP_UHS_SDR25 |\
+				 MMC_CAP_UHS_SDR50 |\
+				 MMC_CAP_UHS_SDR104 |\
+				 MMC_CAP_UHS_DDR50)
+
 	unsigned int		caps2;		/* More host capabilities */
 
 #define MMC_CAP2_BOOTPART_NOACC	(1 << 0)	/* Boot partition no access */
-- 
1.7.0.4

