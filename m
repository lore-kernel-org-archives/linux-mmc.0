From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 3/3] mmc: sdhci-esdhc-imx: Enable/Disable mmc clock during runtime suspend
Date: Thu,  4 Jan 2018 16:30:59 +0100
Message-ID: <1515079859-18401-3-git-send-email-michael@amarulasolutions.com>
References: <1515079859-18401-1-git-send-email-michael@amarulasolutions.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33525 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753120AbeADPbG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Jan 2018 10:31:06 -0500
Received: by mail-wr0-f195.google.com with SMTP id p6so1810468wrd.0
        for <linux-mmc@vger.kernel.org>; Thu, 04 Jan 2018 07:31:05 -0800 (PST)
In-Reply-To: <1515079859-18401-1-git-send-email-michael@amarulasolutions.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

mmc clock can be stopped during runtime suspend and restart during runtime
resume if the sdio irq is not enabled. Stop sdio clock reduce EMI of
the device when the bus is not in use.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
Changes V2->V3:
	- move clock re-order on a separated patch

Changes V1->V2:
	- rebase to latest linux
	- address sdio irq wakeup
	- move the clock enable clk_ahb up to be balance
	  with the runtime suspend function and to make
	  function more clean by the end without two if
	  condition
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 6d4e323..53cc1b6 100644
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
@@ -1422,6 +1425,7 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
 		err = clk_prepare_enable(imx_data->clk_ipg);
 		if (err)
 			goto disable_per_clk;
+		esdhc_pltfm_set_clock(host, imx_data->actual_clock);
 	}
 
 	err = sdhci_runtime_resume_host(host);
-- 
2.7.4

