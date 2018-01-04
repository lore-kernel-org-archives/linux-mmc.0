From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 2/3] mmc: sdhci-esdhc-imx: Changes the order of how clocks are being re-enabled
Date: Thu,  4 Jan 2018 16:30:58 +0100
Message-ID: <1515079859-18401-2-git-send-email-michael@amarulasolutions.com>
References: <1515079859-18401-1-git-send-email-michael@amarulasolutions.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45877 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753251AbeADPbE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Jan 2018 10:31:04 -0500
Received: by mail-wr0-f195.google.com with SMTP id o15so1788023wrf.12
        for <linux-mmc@vger.kernel.org>; Thu, 04 Jan 2018 07:31:04 -0800 (PST)
In-Reply-To: <1515079859-18401-1-git-send-email-michael@amarulasolutions.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

runtime_resume() should re-enable the clocks in reverse order comparing with
runtime_suspend()

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index d08c21e..6d4e323 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1411,31 +1411,33 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
 	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	int err;
 
+	err = clk_prepare_enable(imx_data->clk_ahb);
+	if (err)
+		return err;
+
 	if (!sdhci_sdio_irq_enabled(host)) {
 		err = clk_prepare_enable(imx_data->clk_per);
 		if (err)
-			return err;
+			goto disable_ahb_clk;
 		err = clk_prepare_enable(imx_data->clk_ipg);
 		if (err)
 			goto disable_per_clk;
 	}
-	err = clk_prepare_enable(imx_data->clk_ahb);
-	if (err)
-		goto disable_ipg_clk;
+
 	err = sdhci_runtime_resume_host(host);
 	if (err)
-		goto disable_ahb_clk;
+		goto disable_ipg_clk;
 
 	return 0;
 
-disable_ahb_clk:
-	clk_disable_unprepare(imx_data->clk_ahb);
 disable_ipg_clk:
 	if (!sdhci_sdio_irq_enabled(host))
 		clk_disable_unprepare(imx_data->clk_ipg);
 disable_per_clk:
 	if (!sdhci_sdio_irq_enabled(host))
 		clk_disable_unprepare(imx_data->clk_per);
+disable_ahb_clk:
+	clk_disable_unprepare(imx_data->clk_ahb);
 	return err;
 }
 #endif
-- 
2.7.4

