From: Marek Vasut <marex@denx.de>
Subject: [PATCH] mmc: sdhci: Fix strings broken across multiple lines
Date: Wed, 18 Nov 2015 10:47:02 +0100
Message-ID: <1447840022-8262-1-git-send-email-marex@denx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:53913 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755430AbbKRJrH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Nov 2015 04:47:07 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>

This is a trivial patch which fixes printed strings split across two
or more lines in the source. I tried to grep for some error output*,
but I couldn't find it easily because it was broken across multiple
lines. This patch makes my life easier.

* in particular "Timeout waiting for hardware interrupt."

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci.c | 57 +++++++++++++++++++-----------------------------
 1 file changed, 23 insertions(+), 34 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b48565e..2b17cc1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -768,8 +768,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 		if (unlikely(broken)) {
 			for_each_sg(data->sg, sg, data->sg_len, i) {
 				if (sg->length & 0x3) {
-					DBG("Reverting to PIO because of "
-						"transfer size (%d)\n",
+					DBG("Reverting to PIO because of transfer size (%d)\n",
 						sg->length);
 					host->flags &= ~SDHCI_REQ_USE_DMA;
 					break;
@@ -803,8 +802,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 		if (unlikely(broken)) {
 			for_each_sg(data->sg, sg, data->sg_len, i) {
 				if (sg->offset & 0x3) {
-					DBG("Reverting to PIO because of "
-						"bad alignment\n");
+					DBG("Reverting to PIO because of bad alignment\n");
 					host->flags &= ~SDHCI_REQ_USE_DMA;
 					break;
 				}
@@ -1016,8 +1014,8 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 
 	while (sdhci_readl(host, SDHCI_PRESENT_STATE) & mask) {
 		if (timeout == 0) {
-			pr_err("%s: Controller never released "
-				"inhibit bit(s).\n", mmc_hostname(host->mmc));
+			pr_err("%s: Controller never released inhibit bit(s).\n",
+			       mmc_hostname(host->mmc));
 			sdhci_dumpregs(host);
 			cmd->error = -EIO;
 			tasklet_schedule(&host->finish_tasklet);
@@ -1254,8 +1252,8 @@ clock_set:
 	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
 		& SDHCI_CLOCK_INT_STABLE)) {
 		if (timeout == 0) {
-			pr_err("%s: Internal clock never "
-				"stabilised.\n", mmc_hostname(host->mmc));
+			pr_err("%s: Internal clock never stabilised.\n",
+			       mmc_hostname(host->mmc));
 			sdhci_dumpregs(host);
 			return;
 		}
@@ -1540,8 +1538,8 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 			else if (ios->drv_type == MMC_SET_DRIVER_TYPE_D)
 				ctrl_2 |= SDHCI_CTRL_DRV_TYPE_D;
 			else {
-				pr_warn("%s: invalid driver type, default to "
-					"driver type B\n", mmc_hostname(mmc));
+				pr_warn("%s: invalid driver type, default to driver type B\n",
+					mmc_hostname(mmc));
 				ctrl_2 |= SDHCI_CTRL_DRV_TYPE_B;
 			}
 
@@ -2015,10 +2013,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		spin_lock_irqsave(&host->lock, flags);
 
 		if (!host->tuning_done) {
-			pr_info(DRIVER_NAME ": Timeout waiting for "
-				"Buffer Read Ready interrupt during tuning "
-				"procedure, falling back to fixed sampling "
-				"clock\n");
+			pr_info(DRIVER_NAME ": Timeout waiting for Buffer Read Ready interrupt during tuning procedure, falling back to fixed sampling clock\n");
 			ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 			ctrl &= ~SDHCI_CTRL_TUNED_CLK;
 			ctrl &= ~SDHCI_CTRL_EXEC_TUNING;
@@ -2046,9 +2041,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 	}
 	if (!(ctrl & SDHCI_CTRL_TUNED_CLK)) {
-		pr_info(DRIVER_NAME ": Tuning procedure"
-			" failed, falling back to fixed sampling"
-			" clock\n");
+		pr_info(DRIVER_NAME ": Tuning procedure failed, falling back to fixed sampling clock\n");
 		err = -EIO;
 	}
 
@@ -2293,8 +2286,8 @@ static void sdhci_timeout_timer(unsigned long data)
 	spin_lock_irqsave(&host->lock, flags);
 
 	if (host->mrq) {
-		pr_err("%s: Timeout waiting for hardware "
-			"interrupt.\n", mmc_hostname(host->mmc));
+		pr_err("%s: Timeout waiting for hardware interrupt.\n",
+		       mmc_hostname(host->mmc));
 		sdhci_dumpregs(host);
 
 		if (host->data) {
@@ -2325,9 +2318,8 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
 	BUG_ON(intmask == 0);
 
 	if (!host->cmd) {
-		pr_err("%s: Got command interrupt 0x%08x even "
-			"though no command operation was in progress.\n",
-			mmc_hostname(host->mmc), (unsigned)intmask);
+		pr_err("%s: Got command interrupt 0x%08x even though no command operation was in progress.\n",
+		       mmc_hostname(host->mmc), (unsigned)intmask);
 		sdhci_dumpregs(host);
 		return;
 	}
@@ -2356,8 +2348,7 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
 	 */
 	if (host->cmd->flags & MMC_RSP_BUSY) {
 		if (host->cmd->data)
-			DBG("Cannot wait for busy signal when also "
-				"doing a data transfer");
+			DBG("Cannot wait for busy signal when also doing a data transfer");
 		else if (!(host->quirks & SDHCI_QUIRK_NO_BUSY_IRQ)
 				&& !host->busy_handle) {
 			/* Mark that command complete before busy is ended */
@@ -2451,9 +2442,8 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 			}
 		}
 
-		pr_err("%s: Got data interrupt 0x%08x even "
-			"though no data operation was in progress.\n",
-			mmc_hostname(host->mmc), (unsigned)intmask);
+		pr_err("%s: Got data interrupt 0x%08x even though no data operation was in progress.\n",
+		       mmc_hostname(host->mmc), (unsigned)intmask);
 		sdhci_dumpregs(host);
 
 		return;
@@ -2896,9 +2886,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	host->version = (host->version & SDHCI_SPEC_VER_MASK)
 				>> SDHCI_SPEC_VER_SHIFT;
 	if (host->version > SDHCI_SPEC_300) {
-		pr_err("%s: Unknown controller version (%d). "
-			"You may experience problems.\n", mmc_hostname(mmc),
-			host->version);
+		pr_err("%s: Unknown controller version (%d). You may experience problems.\n",
+		       mmc_hostname(mmc), host->version);
 	}
 
 	caps[0] = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
@@ -3031,8 +3020,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (host->max_clk == 0 || host->quirks &
 			SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN) {
 		if (!host->ops->get_max_clock) {
-			pr_err("%s: Hardware doesn't specify base clock "
-			       "frequency.\n", mmc_hostname(mmc));
+			pr_err("%s: Hardware doesn't specify base clock frequency.\n",
+			       mmc_hostname(mmc));
 			return -ENODEV;
 		}
 		host->max_clk = host->ops->get_max_clock(host);
@@ -3294,8 +3283,8 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc->ocr_avail_mmc &= host->ocr_avail_mmc;
 
 	if (mmc->ocr_avail == 0) {
-		pr_err("%s: Hardware doesn't report any "
-			"support voltages.\n", mmc_hostname(mmc));
+		pr_err("%s: Hardware doesn't report any support voltages.\n",
+		       mmc_hostname(mmc));
 		return -ENODEV;
 	}
 
-- 
2.1.4

