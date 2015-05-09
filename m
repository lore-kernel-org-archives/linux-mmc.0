From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 1/2] mmc: sdhci-esdhc-imx: Move mmc_of_parse() to the dt probe
Date: Sat,  9 May 2015 09:57:08 -0300
Message-ID: <1431176229-32708-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33393 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbbEIM5d (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 9 May 2015 08:57:33 -0400
Received: by ykeo186 with SMTP id o186so26944848yke.0
        for <linux-mmc@vger.kernel.org>; Sat, 09 May 2015 05:57:33 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: shawn.guo@linaro.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

mmc_of_parse() should be placed inside sdhci_esdhc_imx_probe_dt() as it
suits only for the dt case.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- None

 drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index d7b0a39..a9980d7 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -896,7 +896,8 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 
 	mmc_of_parse_voltage(np, &host->ocr_mask);
 
-	return 0;
+	/* call to generic mmc_of_parse to support additional capabilities */
+	return mmc_of_parse(host->mmc);
 }
 #else
 static inline int
@@ -1041,11 +1042,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 	}
 
-	/* call to generic mmc_of_parse to support additional capabilities */
-	err = mmc_of_parse(host->mmc);
-	if (err)
-		goto disable_clk;
-
 	err = sdhci_add_host(host);
 	if (err)
 		goto disable_clk;
-- 
1.9.1

