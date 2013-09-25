From: Peter Guo <peter.guo@bayhubtech.com>
Subject: [PATCH 2/2] mmc: sdhci: Fix CMD12 and Tuning issues
Date: Wed, 25 Sep 2013 03:22:31 +0000
Message-ID: <c0d297a1143e4aab895d809b52838712@BN1PR04MB091.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2lp0210.outbound.protection.outlook.com ([207.46.163.210]:30802
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754095Ab3IYDiI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Sep 2013 23:38:08 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Samuel Guan <samuel.guan@bayhubtech.com>

From: "peter.guo" <peter.guo@bayhubtech.com>

- Change tuning_loop_counter check from not zero to less than zero
  in function sdhci_execute_tuning; Becasue some host may need 40 times tuning,
  but orginal code only think tuning times <= 39 is successfull.

- When Host Capability Reg (0x40) bit[43:40] is zero, retuning timer should be disabled.
  But Original code still start the timer.

Signed-off-by: peter.guo <peter.guo@bayhubtech.com>
---
 drivers/mmc/host/sdhci.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7a7fb4f..69413e4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1050,6 +1050,13 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	if (cmd->data || cmd->opcode == MMC_SEND_TUNING_BLOCK ||
 	    cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)
 		flags |= SDHCI_CMD_DATA;
+	/*
+	 * According to SD Host Spec
+	 * Command Register offset 0xE bit[7:6] is command type
+	 * And Cmd12 should use Abort Type
+	 */
+	if (cmd->opcode == MMC_STOP_TRANSMISSION)
+		flags |= SDHCI_CMD_ABORTCMD;
 
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
 }
@@ -1978,7 +1985,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	 * The Host Driver has exhausted the maximum number of loops allowed,
 	 * so use fixed sampling frequency.
 	 */
-	if (!tuning_loop_counter || !timeout) {
+	if ((tuning_loop_counter < 0) || (!timeout)) {
 		ctrl &= ~SDHCI_CTRL_TUNED_CLK;
 		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 	} else {
@@ -2007,7 +2014,8 @@ out:
 	} else {
 		host->flags &= ~SDHCI_NEEDS_RETUNING;
 		/* Reload the new initial value for timer */
-		if (host->tuning_mode == SDHCI_TUNING_MODE_1)
+		if ((host->tuning_mode == SDHCI_TUNING_MODE_1) &&
+				(host->tuning_count))
 			mod_timer(&host->tuning_timer, jiffies +
 				host->tuning_count * HZ);
 	}
-- 
1.7.9.5

