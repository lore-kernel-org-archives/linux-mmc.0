From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 4/4] mmc: sdhci: Always allow tuning to fall back to fixed sampling
Date: Wed, 30 Nov 2016 11:20:14 +0200
Message-ID: <1480497614-3501-5-git-send-email-adrian.hunter@intel.com>
References: <1480497614-3501-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18535 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756470AbcK3JZX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 30 Nov 2016 04:25:23 -0500
In-Reply-To: <1480497614-3501-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Dan O'Donovan <dan@emutex.com>

SDHCI falls back to fixed sampling if there is an error during tuning.
However it also reports an error unless there is periodic re-tuning.
That is not the best option because:
a) there is a reasonable chance that fixed sampling will work, especially
at room temperature.
b) re-tuning will be done again anyway if there are CRC errors.
Change to return no error always when falling back to fixed sampling.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ad2f2c6113e4..a23887799f43 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2098,8 +2098,6 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 			sdhci_do_reset(host, SDHCI_RESET_CMD);
 			sdhci_do_reset(host, SDHCI_RESET_DATA);
 
-			err = -EIO;
-
 			if (cmd.opcode != MMC_SEND_TUNING_BLOCK_HS200)
 				goto out;
 
@@ -2137,24 +2135,10 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		ctrl &= ~SDHCI_CTRL_EXEC_TUNING;
 		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 	}
-	if (!(ctrl & SDHCI_CTRL_TUNED_CLK)) {
+	if (!(ctrl & SDHCI_CTRL_TUNED_CLK))
 		pr_info(DRIVER_NAME ": Tuning procedure failed, falling back to fixed sampling clock\n");
-		err = -EIO;
-	}
-
 out:
-	if (tuning_count) {
-		/*
-		 * In case tuning fails, host controllers which support
-		 * re-tuning can try tuning again at a later time, when the
-		 * re-tuning timer expires.  So for these controllers, we
-		 * return 0. Since there might be other controllers who do not
-		 * have this capability, we return error for them.
-		 */
-		err = 0;
-	}
-
-	host->mmc->retune_period = err ? 0 : tuning_count;
+	host->mmc->retune_period = tuning_count;
 
 	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
-- 
1.9.1

