From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: [PATCH V2 06/11] mmc: sdhci-esdhc-imx: fix cd regression for dt platform
Date: Wed, 22 Jul 2015 20:53:05 +0800
Message-ID: <1437569590-5228-7-git-send-email-aisheng.dong@freescale.com>
References: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0145.outbound.protection.outlook.com ([65.55.169.145]:23049
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965133AbbGVODn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Jul 2015 10:03:43 -0400
In-Reply-To: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: fabio.estevam@freescale.com, marex@denx.de, ulf.hansson@linaro.org, s.trumtrar@pengutronix.de, smoch@web.de, linux-arm-kernel@lists.infradead.org, robertcnelson@gmail.com, s.hauer@pengutronix.de, chris@printf.net, rabeeh@solid-run.com, troy.kisky@boundarydevices.com, lisovy@gmail.com, hs@denx.de, gwenhael.goavec-merou@armadeus.com, p.zabel@pengutronix.de, rmk+kernel@arm.linux.org.uk, shawn.guo@linaro.org, b29396@freescale.com, tharvey@gateworks.com, LW@KARO-electronics.de, ipaton0@gmail.com

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

