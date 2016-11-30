From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 3/4] mmc: sdhci: Fix tuning reset after exhausting the maximum number of loops
Date: Wed, 30 Nov 2016 11:20:13 +0200
Message-ID: <1480497614-3501-4-git-send-email-adrian.hunter@intel.com>
References: <1480497614-3501-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18535 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756156AbcK3JZW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 30 Nov 2016 04:25:22 -0500
In-Reply-To: <1480497614-3501-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Dan O'Donovan <dan@emutex.com>

If the driver has exhausted the maximum number of tuning loops, then fixed
sampling is used. To do that both SDHCI_CTRL_TUNED_CLK and
SDHCI_CTRL_EXEC_TUNING must be reset to 0, but only SDHCI_CTRL_TUNED_CLK
was being reset. Reset SDHCI_CTRL_EXEC_TUNING to 0 also.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1d72a51287d4..ad2f2c6113e4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2134,6 +2134,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 */
 	if (tuning_loop_counter < 0) {
 		ctrl &= ~SDHCI_CTRL_TUNED_CLK;
+		ctrl &= ~SDHCI_CTRL_EXEC_TUNING;
 		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 	}
 	if (!(ctrl & SDHCI_CTRL_TUNED_CLK)) {
-- 
1.9.1

