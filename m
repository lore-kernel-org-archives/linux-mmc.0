From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: [PATCH 1/6] mmc: sdhci-esdhc-imx: fix cd regression for dt platform
Date: Thu, 18 Jun 2015 02:05:32 +0800
Message-ID: <1434564337-24720-2-git-send-email-aisheng.dong@freescale.com>
References: <1434564337-24720-1-git-send-email-aisheng.dong@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0105.outbound.protection.outlook.com ([207.46.100.105]:53384
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757831AbbFQSIE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Jun 2015 14:08:04 -0400
In-Reply-To: <1434564337-24720-1-git-send-email-aisheng.dong@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawn.guo@linaro.org, b29396@freescale.com, fabio.estevam@freescale.com, gwenhael.goavec-merou@armadeus.com, marex@denx.de, s.trumtrar@pengutronix.de, s.hauer@pengutronix.de, lisovy@gmail.com, ipaton0@gmail.com, smoch@web.de, hs@denx.de, rmk+kernel@arm.linux.org.uk, tharvey@gateworks.com, rabeeh@solid-run.com, troy.kisky@boundarydevices.com, p.zabel@pengutronix.de, robertcnelson@gmail.com, LW@KARO-electronics.de, linux-arm-kernel@lists.infradead.org

Current card detect probe process is that when driver finds a valid
ESDHC_CD_GPIO, it will clear the quirk SDHCI_QUIRK_BROKEN_CARD_DETECTION
which is set by default for all esdhc/usdhc controllers.
Then host driver will know there's a valid card detect function.

Commit 8d86e4fcccf6 ("mmc: sdhci-esdhc-imx: Call mmc_of_parse()")
breaks GPIO CD function for dt platform that it will return directly
when find ESDHC_CD_GPIO for dt platform which result in the later wrongly
to keep SDHCI_QUIRK_BROKEN_CARD_DETECTION for all dt platforms.
Then MMC_CAP_NEEDS_POLL will be used instead even there's a valid
GPIO card detect.

This patch adds back this function and follows the original approach to
clear the quirk if find an valid CD GPIO for dt platforms.

Fixes: 8d86e4fcccf6 ("mmc: sdhci-esdhc-imx: Call mmc_of_parse()")
Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index faf0cb9..4815391 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -881,6 +881,7 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 			 struct esdhc_platform_data *boarddata)
 {
 	struct device_node *np = pdev->dev.of_node;
+	int ret;
 
 	if (!np)
 		return -ENODEV;
@@ -917,7 +918,14 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	mmc_of_parse_voltage(np, &host->ocr_mask);
 
 	/* call to generic mmc_of_parse to support additional capabilities */
-	return mmc_of_parse(host->mmc);
+	ret = mmc_of_parse(host->mmc);
+	if (ret)
+		return ret;
+
+	if (!IS_ERR_VALUE(mmc_gpio_get_cd(host->mmc)))
+		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+
+	return 0;
 }
 #else
 static inline int
-- 
1.9.1

