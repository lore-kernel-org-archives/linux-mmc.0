From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] mmc: sdhci-esdhc-imx: Move mmc_of_parse() to the dt probe
Date: Fri,  8 May 2015 02:56:08 -0300
Message-ID: <1431064569-5947-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35517 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbbEHF7X (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2015 01:59:23 -0400
Received: by ykec202 with SMTP id c202so17667074yke.2
        for <linux-mmc@vger.kernel.org>; Thu, 07 May 2015 22:59:22 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: shawn.guo@linaro.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

mmc_of_parse() should be placed inside sdhci_esdhc_imx_probe_dt() as it
suits only for the dt case.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
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

