From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 2/5] mmc: sdhci: Use mmc_abort_tuning()
Date: Thu,  1 Dec 2016 16:04:28 +0200
Message-ID: <1480601071-8881-3-git-send-email-adrian.hunter@intel.com>
References: <1480601071-8881-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:19066 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbcLAOJh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Dec 2016 09:09:37 -0500
In-Reply-To: <1480601071-8881-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Use mmc_abort_tuning() instead of open-coding the stop command.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a23887799f43..b841d0a57af1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2098,20 +2098,11 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 			sdhci_do_reset(host, SDHCI_RESET_CMD);
 			sdhci_do_reset(host, SDHCI_RESET_DATA);
 
-			if (cmd.opcode != MMC_SEND_TUNING_BLOCK_HS200)
-				goto out;
-
 			sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
 			sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 
 			spin_unlock_irqrestore(&host->lock, flags);
-
-			memset(&cmd, 0, sizeof(cmd));
-			cmd.opcode = MMC_STOP_TRANSMISSION;
-			cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
-			cmd.busy_timeout = 50;
-			mmc_wait_for_cmd(mmc, &cmd, 0);
-
+			mmc_abort_tuning(mmc, opcode);
 			spin_lock_irqsave(&host->lock, flags);
 
 			goto out;
-- 
1.9.1

