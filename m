From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 1/9] Revert "mmc: sdhci: Reset cmd and data circuits after tuning failure"
Date: Fri,  2 Dec 2016 15:14:19 +0200
Message-ID: <1480684467-26833-2-git-send-email-adrian.hunter@intel.com>
References: <1480684467-26833-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:19569 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756967AbcLBNTo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 2 Dec 2016 08:19:44 -0500
In-Reply-To: <1480684467-26833-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

This reverts commit fe5fb2e3b58f ("mmc: sdhci: Reset cmd and data circuits
after tuning failure").

A better fix is available, and it will be applied to older stable releases,
so get this out of the way by reverting it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # v4.9+
---
 drivers/mmc/host/sdhci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7f2526c9572f..e761fe2aa99e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2090,10 +2090,6 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 		if (!host->tuning_done) {
 			pr_info(DRIVER_NAME ": Timeout waiting for Buffer Read Ready interrupt during tuning procedure, falling back to fixed sampling clock\n");
-
-			sdhci_do_reset(host, SDHCI_RESET_CMD);
-			sdhci_do_reset(host, SDHCI_RESET_DATA);
-
 			ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 			ctrl &= ~SDHCI_CTRL_TUNED_CLK;
 			ctrl &= ~SDHCI_CTRL_EXEC_TUNING;
-- 
1.9.1

