From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] mmc: sdhci-esdhc-imx: Call mmc_of_parse()
Date: Thu, 12 Mar 2015 19:15:35 -0300
Message-ID: <1426198535-21312-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:43162 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467AbbCLWPx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Mar 2015 18:15:53 -0400
Received: by qcyl6 with SMTP id l6so22362349qcy.10
        for <linux-mmc@vger.kernel.org>; Thu, 12 Mar 2015 15:15:52 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: shawn.guo@linaro.org, linux@arm.linux.org.uk, kernel@pengutronix.de, otavio@ossystems.com.br, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Currently it is not possible to use 'mmc-pwrseq-simple' property with this
driver because mmc_of_parse() is never called.

mmc_of_parse() calls mmc_pwrseq_alloc() that manages MMC power sequence.

Call the generic mmc_of_parse() so that we can use 'mmc-pwrseq-simple' to 
provide reset GPIO to the Wifi/BT chip.

Tested on a imx6sl-warp board.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 9cce5cf..d714d8f 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1075,6 +1075,11 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
 	}
 
+	/* call to generic mmc_of_parse to support additional capabilities */
+	err = mmc_of_parse(host->mmc);
+	if (err)
+		goto disable_clk;
+
 	err = sdhci_add_host(host);
 	if (err)
 		goto disable_clk;
-- 
1.9.1

