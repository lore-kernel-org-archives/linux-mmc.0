From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V2 2/2] mmc: sdhci-esdhc-imx: Enable/Disable mmc clock during runtime suspend
Date: Thu,  4 Jan 2018 14:58:44 +0100
Message-ID: <1515074324-12933-2-git-send-email-michael@amarulasolutions.com>
References: <1515074324-12933-1-git-send-email-michael@amarulasolutions.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35885 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753013AbeADN6t (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Jan 2018 08:58:49 -0500
Received: by mail-wm0-f67.google.com with SMTP id b76so3630202wmg.1
        for <linux-mmc@vger.kernel.org>; Thu, 04 Jan 2018 05:58:48 -0800 (PST)
In-Reply-To: <1515074324-12933-1-git-send-email-michael@amarulasolutions.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

mmc clock can be stopped during runtime suspend and restart during runtime
resume if the sdio irq is not enabled. Stop sdio clock reduce EMI of
the device when the bus is not in use.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
Changes V1->V2:
	- rebase to latest linux
	- address sdio irq wakeup
	- move the clock enable clk_ahb up to be balance
	  with the runtime suspend function and to make
	  function more clean by the end without two if
	  condition
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index d08c21e..53cc1b6 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -193,6 +193,7 @@ struct pltfm_imx_data {
 	struct clk *clk_ipg;
 	struct clk *clk_ahb;
 	struct clk *clk_per;
+	unsigned int actual_clock;
 	enum {
 		NO_CMD_PENDING,      /* no multiblock command pending */
 		MULTIBLK_IN_PROCESS, /* exact multiblock cmd in process */
@@ -1396,6 +1397,8 @@ static int sdhci_esdhc_runtime_suspend(struct device *dev)
 		mmc_retune_needed(host->mmc);
 
 	if (!sdhci_sdio_irq_enabled(host)) {
+		imx_data->actual_clock = host->mmc->actual_clock;
+		esdhc_pltfm_set_clock(host, 0);
 		clk_disable_unprepare(imx_data->clk_per);
 		clk_disable_unprepare(imx_data->clk_ipg);
 	}
@@ -1411,31 +1414,34 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
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
+		esdhc_pltfm_set_clock(host, imx_data->actual_clock);
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

