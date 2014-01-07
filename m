From: Franky Lin <frankyl@broadcom.com>
Subject: [PATCH] mmc: sdhci: only invoke clock re-tuning for adtc type commands
Date: Tue, 7 Jan 2014 10:37:39 -0800
Message-ID: <1389119859-28955-1-git-send-email-frankyl@broadcom.com>
References: <1389119511-26228-1-git-send-email-frankyl@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:24949 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbaAGShl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jan 2014 13:37:41 -0500
In-Reply-To: <1389119511-26228-1-git-send-email-frankyl@broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net
Cc: linux-mmc@vger.kernel.org

For high clock frequency modes, ie. SDR104 and possibly SDR50, the data
window on the CMD and DAT lines needs to be tuned. Once tuned to a
sample clock rate, a re-tuning might required because of drifted signal
on different lines. This re-tuning is needed and only necessary for
commands using the DAT lines, ie. adtc type commands. This patch is an
optimization by adding the condition of the requested command being adtc
type in order to execute the re-tuning procedure.

Signed-off-by: Franky Lin <frankyl@broadcom.com>
---
 drivers/mmc/host/sdhci.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cc00bed..f301cd6 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1389,7 +1389,8 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		 * tuning procedure before sending command.
 		 */
 		if ((host->flags & SDHCI_NEEDS_RETUNING) &&
-		    !(present_state & (SDHCI_DOING_WRITE | SDHCI_DOING_READ))) {
+		    !(present_state & (SDHCI_DOING_WRITE | SDHCI_DOING_READ)) &&
+		    mmc_cmd_type(mrq->cmd) == MMC_CMD_ADTC) {
 			if (mmc->card) {
 				/* eMMC uses cmd21 but sd and sdio use cmd19 */
 				tuning_opcode =
-- 
1.7.9.5

