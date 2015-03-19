From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] Revert "mmc: sdhci-esdhc-imx: Call mmc_of_parse()"
Date: Thu, 19 Mar 2015 18:59:14 -0300
Message-ID: <1426802354-3272-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:34795 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbbCSV71 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Mar 2015 17:59:27 -0400
Received: by qcaz10 with SMTP id z10so79257110qca.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2015 14:59:26 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, olof@lixom.net, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Commit 46a3b345d38518 ("mmc: sdhci-esdhc-imx: Call mmc_of_parse()") caused 
regression on some mx6q platforms:

[    1.478666] sdhci: Secure Digital Host Controller Interface driver
[    1.484912] sdhci: Copyright(c) Pierre Ossman
[    1.489333] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.496441] sdhci-esdhc-imx 2194000.usdhc: could not get ultra high speed state, work on normal mode
[    1.505878] sdhci-esdhc-imx: probe of 2194000.usdhc failed with error -16

Reported-by: Olof's autobooter <build@lixom.net>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
I don't have hardware access at the moment to debug this issue, so reverting it
for now.

 drivers/mmc/host/sdhci-esdhc-imx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 631e136..9cce5cf 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1075,11 +1075,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
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

