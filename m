From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 5/5] mmc: sdhci: Tidy tuning loop
Date: Thu,  1 Dec 2016 16:04:31 +0200
Message-ID: <1480601071-8881-6-git-send-email-adrian.hunter@intel.com>
References: <1480601071-8881-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:47701 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757792AbcLAOJm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Dec 2016 09:09:42 -0500
In-Reply-To: <1480601071-8881-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 81 +++++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 38 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e9ff7d005851..1ac08e1a6211 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2055,11 +2055,47 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode,
 	spin_lock_irqsave(&host->lock, flags);
 }
 
+static void __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode,
+				   unsigned long flags)
+{
+	int i;
+
+	/*
+	 * Issue opcode repeatedly till Execute Tuning is set to 0 or the number
+	 * of loops reaches 40 times.
+	 */
+	for (i = 0; i < MAX_TUNING_LOOP; i++) {
+		u16 ctrl;
+
+		sdhci_send_tuning(host, opcode, flags);
+
+		if (!host->tuning_done) {
+			pr_info("%s: Tuning timeout, falling back to fixed sampling clock\n",
+				mmc_hostname(host->mmc));
+			sdhci_abort_tuning(host, opcode, flags);
+			return;
+		}
+
+		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
+			if (ctrl & SDHCI_CTRL_TUNED_CLK)
+				return; /* Success! */
+			break;
+		}
+
+		/* eMMC spec does not require a delay between tuning cycles */
+		if (opcode == MMC_SEND_TUNING_BLOCK)
+			mdelay(1);
+	}
+
+	pr_info("%s: Tuning failed, falling back to fixed sampling clock\n",
+		mmc_hostname(host->mmc));
+	sdhci_reset_tuning(host);
+}
+
 static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
-	u16 ctrl;
-	int tuning_loop_counter = MAX_TUNING_LOOP;
 	int err = 0;
 	unsigned long flags;
 	unsigned int tuning_count = 0;
@@ -2110,50 +2146,19 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	if (host->ops->platform_execute_tuning) {
 		spin_unlock_irqrestore(&host->lock, flags);
-		err = host->ops->platform_execute_tuning(host, opcode);
-		return err;
+		return host->ops->platform_execute_tuning(host, opcode);
 	}
 
-	sdhci_start_tuning(host);
-
-	/*
-	 * Issue CMD19 repeatedly till Execute Tuning is set to 0 or the number
-	 * of loops reaches 40 times.
-	 */
-	do {
-		if (tuning_loop_counter-- == 0)
-			break;
-
-		sdhci_send_tuning(host, opcode, flags);
-
-		if (!host->tuning_done) {
-			pr_info(DRIVER_NAME ": Timeout waiting for Buffer Read Ready interrupt during tuning procedure, falling back to fixed sampling clock\n");
-			sdhci_abort_tuning(host, opcode, flags);
-			goto out;
-		}
-
-		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
-
-		/* eMMC spec does not require a delay between tuning cycles */
-		if (opcode == MMC_SEND_TUNING_BLOCK)
-			mdelay(1);
-	} while (ctrl & SDHCI_CTRL_EXEC_TUNING);
+	host->mmc->retune_period = tuning_count;
 
-	/*
-	 * The Host Driver has exhausted the maximum number of loops allowed,
-	 * so use fixed sampling frequency.
-	 */
-	if (tuning_loop_counter < 0)
-		sdhci_reset_tuning(host);
+	sdhci_start_tuning(host);
 
-	if (tuning_loop_counter < 0 || !(ctrl & SDHCI_CTRL_TUNED_CLK))
-		pr_info(DRIVER_NAME ": Tuning procedure failed, falling back to fixed sampling clock\n");
-out:
-	host->mmc->retune_period = tuning_count;
+	__sdhci_execute_tuning(host, opcode, flags);
 
 	sdhci_end_tuning(host);
 out_unlock:
 	spin_unlock_irqrestore(&host->lock, flags);
+
 	return err;
 }
 
-- 
1.9.1

