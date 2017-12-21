From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH] mmc: sdhci-esdhc-imx: Enable/Disable mmc clock during runtime suspend
Date: Thu, 21 Dec 2017 14:22:26 +0100
Message-ID: <1513862546-20221-1-git-send-email-michael@amarulasolutions.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42833 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbdLUNWb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Dec 2017 08:22:31 -0500
Received: by mail-wr0-f195.google.com with SMTP id s66so25149823wrc.9
        for <linux-mmc@vger.kernel.org>; Thu, 21 Dec 2017 05:22:30 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

mmc clock can be stopped during runtime suspend and restart during runtime
resume. This let us know to not have any clock running and this reduce
the EMI of the device when the bus is not in use

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 7123ef9..9a5e96f 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -196,6 +196,7 @@ struct pltfm_imx_data {
 	struct clk *clk_ipg;
 	struct clk *clk_ahb;
 	struct clk *clk_per;
+	unsigned int actual_clock;
 	enum {
 		NO_CMD_PENDING,      /* no multiblock command pending*/
 		MULTIBLK_IN_PROCESS, /* exact multiblock cmd in process */
@@ -1346,6 +1347,9 @@ static int sdhci_esdhc_runtime_suspend(struct device *dev)
 
 	ret = sdhci_runtime_suspend_host(host);
 
+	imx_data->actual_clock = host->mmc->actual_clock;
+	esdhc_pltfm_set_clock(host, 0);
+
 	if (!sdhci_sdio_irq_enabled(host)) {
 		clk_disable_unprepare(imx_data->clk_per);
 		clk_disable_unprepare(imx_data->clk_ipg);
@@ -1366,6 +1370,7 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
 		clk_prepare_enable(imx_data->clk_ipg);
 	}
 	clk_prepare_enable(imx_data->clk_ahb);
+	esdhc_pltfm_set_clock(host, imx_data->actual_clock);
 
 	return sdhci_runtime_resume_host(host);
 }
-- 
2.7.4

