From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 8/8] mmc: sdhci-esdhc-imx: add quirk SDHCI_QUIRK2_BROKEN_HS200 for imx6qdl
Date: Mon, 22 Sep 2014 17:12:11 +0800
Message-ID: <1411377131-19741-9-git-send-email-b29396@freescale.com>
References: <1411377131-19741-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0145.outbound.protection.outlook.com ([65.55.169.145]:54944
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752372AbaIVJkY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 22 Sep 2014 05:40:24 -0400
In-Reply-To: <1411377131-19741-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawn.guo@linaro.org, b29396@freescale.com, linux-arm-kernel@lists.infradead.org

The iMX6Q/DL can not support HS200 mode while iMX6SL and iMX6SX can,
so introduce a new flag to distinguish them.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 87179c4..16eff00 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -120,6 +120,8 @@
  * when reading data from the card
  */
 #define ESDHC_FLAG_ERR004536		BIT(7)
+/* The IP supports HS200 mode */
+#define ESDHC_FLAG_HS200		BIT(8)
 
 struct esdhc_soc_data {
 	u32 flags;
@@ -147,12 +149,13 @@ static struct esdhc_soc_data usdhc_imx6q_data = {
 
 static struct esdhc_soc_data usdhc_imx6sl_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
-			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_ERR004536,
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_ERR004536
+			| ESDHC_FLAG_HS200,
 };
 
 static struct esdhc_soc_data usdhc_imx6sx_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
-			| ESDHC_FLAG_HAVE_CAP1,
+			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200,
 };
 
 struct pltfm_imx_data {
@@ -1063,6 +1066,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
 		host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
+		if (!(imx_data->socdata->flags & ESDHC_FLAG_HS200))
+			host->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
+
 		/*
 		 * errata ESDHC_FLAG_ERR004536 fix for MX6Q TO1.2 and MX6DL
 		 * TO1.1, it's harmless for MX6SL
-- 
1.7.8

