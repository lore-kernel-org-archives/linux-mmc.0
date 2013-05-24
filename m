From: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
Subject: [PATCH 8/8] sdhci: Use jiffies instead of a timeout counter
Date: Fri, 24 May 2013 18:00:42 +0200
Message-ID: <1369411242-20515-9-git-send-email-jeremie.samuel.ext@parrot.com>
References: <1369411242-20515-1-git-send-email-jeremie.samuel.ext@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:35687 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755337Ab3EXQBg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 24 May 2013 12:01:36 -0400
In-Reply-To: <1369411242-20515-1-git-send-email-jeremie.samuel.ext@parrot.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: matthieu.castet@parrot.com, gregor.boirie@parrot.com, Jeremie Samuel <jeremie.samuel.ext@parrot.com>, Anton Vorontsov <avorontsov@mvista.com>

Just a cosmetic change, should not affect functionality.

Patch based on: http://thread.gmane.org/gmane.linux.kernel.mmc/2579.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
Signed-off-by: Jeremie Samuel <jeremie.samuel.ext@parrot.com>
---
 drivers/mmc/host/sdhci.c |   22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4a6b716..f121822 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -198,17 +198,16 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 		host->clock = 0;
 
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
 
@@ -984,7 +983,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	WARN_ON(host->cmd);
 
 	/* Wait max 10 ms */
-	timeout = 10;
+	timeout = jiffies + msecs_to_jiffies(10);
 
 	mask = SDHCI_CMD_INHIBIT;
 	if ((cmd->data != NULL) || (cmd->flags & MMC_RSP_BUSY))
@@ -996,7 +995,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		mask &= ~SDHCI_DATA_INHIBIT;
 
 	while (sdhci_readl(host, SDHCI_PRESENT_STATE) & mask) {
-		if (timeout == 0) {
+		if (time_after(jiffies, timeout)) {
 			pr_err("%s: Controller never released "
 				"inhibit bit(s).\n", mmc_hostname(host->mmc));
 			sdhci_dumpregs(host);
@@ -1004,7 +1003,6 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 			schedule_work(&host->finish_work);
 			return;
 		}
-		timeout--;
 		mdelay(1);
 	}
 
@@ -1216,16 +1214,15 @@ clock_set:
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
 
@@ -1878,12 +1875,12 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
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
@@ -1954,7 +1951,6 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 		tuning_loop_counter--;
-		timeout--;
 		msleep(1);
 	} while (ctrl & SDHCI_CTRL_EXEC_TUNING);
 
@@ -1962,7 +1958,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
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

