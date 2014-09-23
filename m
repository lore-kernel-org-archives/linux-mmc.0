From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 6/6] mmc: sdhci: Transfer Complete has higher priority than Data Timeout Error
Date: Tue, 23 Sep 2014 23:00:30 +0300
Message-ID: <1411502430-25535-7-git-send-email-adrian.hunter@intel.com>
References: <1411502430-25535-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:41324 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756259AbaIWUCC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Sep 2014 16:02:02 -0400
In-Reply-To: <1411502430-25535-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

According to the SD Host Controller Standard Specification:

"...Transfer Complete has higher priority than Data Timeout
Error. If both bits are set to 1, execution of a command
can be considered to be completed."

Adjust the checking of SDHCI_INT_DATA_TIMEOUT and
SDHCI_INT_DATA_END (Transfer Complete) accordingly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7481bd8..7a8586f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2329,11 +2329,6 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		 * above in sdhci_cmd_irq().
 		 */
 		if (host->cmd && (host->cmd->flags & MMC_RSP_BUSY)) {
-			if (intmask & SDHCI_INT_DATA_TIMEOUT) {
-				host->cmd->error = -ETIMEDOUT;
-				tasklet_schedule(&host->finish_tasklet);
-				return;
-			}
 			if (intmask & SDHCI_INT_DATA_END) {
 				/*
 				 * Some cards handle busy-end interrupt
@@ -2346,6 +2341,11 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 					host->busy_handle = 1;
 				return;
 			}
+			if (intmask & SDHCI_INT_DATA_TIMEOUT) {
+				host->cmd->error = -ETIMEDOUT;
+				tasklet_schedule(&host->finish_tasklet);
+				return;
+			}
 		}
 
 		pr_err("%s: Got data interrupt 0x%08x even "
@@ -2356,7 +2356,8 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		return;
 	}
 
-	if (intmask & SDHCI_INT_DATA_TIMEOUT)
+	if ((intmask & SDHCI_INT_DATA_TIMEOUT) &&
+	    !(intmask & SDHCI_INT_DATA_END))
 		host->data->error = -ETIMEDOUT;
 	else if (intmask & SDHCI_INT_DATA_END_BIT)
 		host->data->error = -EILSEQ;
-- 
1.8.3.2

