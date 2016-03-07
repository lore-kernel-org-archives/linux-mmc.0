From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] mmc: sdhci: Fix override of timeout clk wrt max_busy_timeout
Date: Mon,  7 Mar 2016 13:33:55 +0200
Message-ID: <1457350435-25025-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:50532 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435AbcCGLhu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 7 Mar 2016 06:37:50 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Normally the timeout clock frequency is read from the capabilities
register.  It is also possible to set the value prior to calling
sdhci_add_host() in which case that value will override the
capabilities register value.  However that was being done after
calculating max_busy_timeout so that max_busy_timeout was being
calculated using the wrong value of timeout_clk.

Fix that by moving the override before max_busy_timeout is
calculated.

The result is that the max_busy_timeout and max_discard
increase for BSW devices so that, for example, the time for
mkfs.ext4 on a 64GB eMMC drops from about 1 minute 40 seconds
to about 20 seconds.

Note, in the future, the capabilities setting will be tidied up
and this override won't be used anymore.  However this fix is
needed for stable.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # v3.18+
---
 drivers/mmc/host/sdhci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 03fbb36580f7..4ae394e9e560 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3016,14 +3016,14 @@ int sdhci_add_host(struct sdhci_host *host)
 		if (caps[0] & SDHCI_TIMEOUT_CLK_UNIT)
 			host->timeout_clk *= 1000;
 
+		if (override_timeout_clk)
+			host->timeout_clk = override_timeout_clk;
+
 		mmc->max_busy_timeout = host->ops->get_max_timeout_count ?
 			host->ops->get_max_timeout_count(host) : 1 << 27;
 		mmc->max_busy_timeout /= host->timeout_clk;
 	}
 
-	if (override_timeout_clk)
-		host->timeout_clk = override_timeout_clk;
-
 	mmc->caps |= MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE | MMC_CAP_CMD23;
 	mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
 
-- 
1.9.1

