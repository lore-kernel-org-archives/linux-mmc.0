From: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Subject: [PATCH 8/8] sdhci: Use jiffies instead of a timeout counter
Date: Tue, 9 Jul 2013 17:44:12 +0200
Message-ID: <1373384652-21958-9-git-send-email-jeremie.samuel.ext@parrot.com>
References: <1373384652-21958-1-git-send-email-jeremie.samuel.ext@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:45932 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752030Ab3GIPor (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 9 Jul 2013 11:44:47 -0400
In-Reply-To: <1373384652-21958-1-git-send-email-jeremie.samuel.ext@parrot.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, matthieu.castet@parrot.com, gregor.boirie@parrot.com, Jeremie Samuel <jeremie.samuel.ext@parrot.com>, Anton Vorontsov <avorontsov@mvista.com>

Just a cosmetic change, should not affect functionality.

Patch based on: http://thread.gmane.org/gmane.linux.kernel.mmc/2579.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
Signed-off-by: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
---
 drivers/mmc/host/sdhci.c |   22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cabbe29..b261555 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -210,17 +210,16 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 	}
 
 	/* Wait max 100 ms */
-	timeout = 100;
+	timeout = jiffies + msecs_to_jiffies(100);
 
 	/* hw clears the bit when it's done */
 	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
-		if (timeout == 0) {
+		if (time_after(jiffies, timeout)) {
 			pr_err("%s: Reset 0x%x never completed.\n",
 				mmc_hostname(host->mmc), (int)mask);
 			sdhci_dumpregs(host);
 			return;
 		}
-		timeout--;
 		msleep(1);
 	}
 
@@ -996,7 +995,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	WARN_ON(host->cmd);
 
 	/* Wait max 10 ms */
-	timeout = 10;
+	timeout = jiffies + msecs_to_jiffies(10);
 
 	mask = SDHCI_CMD_INHIBIT;
 	if ((cmd->data != NULL) || (cmd->flags & MMC_RSP_BUSY))
@@ -1008,7 +1007,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		mask &= ~SDHCI_DATA_INHIBIT;
 
 	while (sdhci_readl(host, SDHCI_PRESENT_STATE) & mask) {
-		if (timeout == 0) {
+		if (time_after(jiffies, timeout)) {
 			pr_err("%s: Controller never released "
 				"inhibit bit(s).\n", mmc_hostname(host->mmc));
 			sdhci_dumpregs(host);
@@ -1016,7 +1015,6 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 			schedule_work(&host->finish_work);
 			return;
 		}
-		timeout--;
 		mdelay(1);
 	}
 
@@ -1228,16 +1226,15 @@ clock_set:
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
 	/* Wait max 20 ms */
-	timeout = 20;
+	timeout = jiffies + msecs_to_jiffies(20);
 	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
 		& SDHCI_CLOCK_INT_STABLE)) {
-		if (timeout == 0) {
+		if (time_after(jiffies, timeout)) {
 			pr_err("%s: Internal clock never "
 				"stabilised.\n", mmc_hostname(host->mmc));
 			sdhci_dumpregs(host);
 			return;
 		}
-		timeout--;
 		msleep(1);
 	}
 
@@ -1894,12 +1891,12 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 * Issue CMD19 repeatedly till Execute Tuning is set to 0 or the number
 	 * of loops reaches 40 times or a timeout of 150ms occurs.
 	 */
-	timeout = 150;
+	timeout = jiffies + msecs_to_jiffies(150);
 	do {
 		struct mmc_command cmd = {0};
 		struct mmc_request mrq = {NULL};
 
-		if (!tuning_loop_counter && !timeout)
+		if (!tuning_loop_counter && time_after(jiffies, timeout))
 			break;
 
 		cmd.opcode = opcode;
@@ -1970,7 +1967,6 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 		tuning_loop_counter--;
-		timeout--;
 		msleep(1);
 	} while (ctrl & SDHCI_CTRL_EXEC_TUNING);
 
@@ -1978,7 +1974,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 * The Host Driver has exhausted the maximum number of loops allowed,
 	 * so use fixed sampling frequency.
 	 */
-	if (!tuning_loop_counter || !timeout) {
+	if (!tuning_loop_counter || time_after(jiffies, timeout)) {
 		ctrl &= ~SDHCI_CTRL_TUNED_CLK;
 		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 	} else {
-- 
1.7.10.4

