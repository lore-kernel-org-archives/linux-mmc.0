From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V2 1/3] mmc: sdhci-esdhc-imx: Manage sdhci_runtime_suspend_host error code
Date: Thu,  4 Jan 2018 16:30:57 +0100
Message-ID: <1515079859-18401-1-git-send-email-michael@amarulasolutions.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36655 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753251AbeADPbD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Jan 2018 10:31:03 -0500
Received: by mail-wm0-f65.google.com with SMTP id b76so4149502wmg.1
        for <linux-mmc@vger.kernel.org>; Thu, 04 Jan 2018 07:31:03 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>

We need to return in case of error even if the actual implementation
of sdhci_runtime_suspend_host always return 0. We don't want to
power down the clock and the assuption is that the sdhci_runtime_suspend_host
always let the system consistent in case of failure

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
Changes None

---
 drivers/mmc/host/sdhci-esdhc-imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 85140c9..d08c21e 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1389,6 +1389,8 @@ static int sdhci_esdhc_runtime_suspend(struct device *dev)
 	int ret;
 
 	ret = sdhci_runtime_suspend_host(host);
+	if (ret)
+		return ret;
 
 	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
-- 
2.7.4

