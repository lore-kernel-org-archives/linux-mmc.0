From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 2/9] mmc: sdhci: Fix recovery from tuning timeout
Date: Fri,  2 Dec 2016 15:14:20 +0200
Message-ID: <1480684467-26833-3-git-send-email-adrian.hunter@intel.com>
References: <1480684467-26833-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:19835 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757941AbcLBNTo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 2 Dec 2016 08:19:44 -0500
In-Reply-To: <1480684467-26833-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Clearing the tuning bits should reset the tuning circuit. However there is
more to do. Reset the command and data lines for good measure, and then
for eMMC ensure the card is not still trying to process a tuning command by
sending a stop command.

Note the JEDEC eMMC specification says the stop command (CMD12) can be used
to stop a tuning command (CMD21) whereas the SD specification is silent on
the subject with respect to the SD tuning command (CMD19). Considering that
CMD12 is not a valid SDIO command, the stop command is sent only when the
tuning command is CMD21 i.e. for eMMC. That addresses cases seen so far
which have been on eMMC.

Note that this replaces the commit fe5fb2e3b58f ("mmc: sdhci: Reset cmd and
data circuits after tuning failure") which is being reverted for v4.9+.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Dan O'Donovan <dan@emutex.com>
Cc: stable@vger.kernel.org
---
 drivers/mmc/host/sdhci.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e761fe2aa99e..1d72a51287d4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2095,7 +2095,27 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 			ctrl &= ~SDHCI_CTRL_EXEC_TUNING;
 			sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
+			sdhci_do_reset(host, SDHCI_RESET_CMD);
+			sdhci_do_reset(host, SDHCI_RESET_DATA);
+
 			err = -EIO;
+
+			if (cmd.opcode != MMC_SEND_TUNING_BLOCK_HS200)
+				goto out;
+
+			sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+			sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+
+			spin_unlock_irqrestore(&host->lock, flags);
+
+			memset(&cmd, 0, sizeof(cmd));
+			cmd.opcode = MMC_STOP_TRANSMISSION;
+			cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+			cmd.busy_timeout = 50;
+			mmc_wait_for_cmd(mmc, &cmd, 0);
+
+			spin_lock_irqsave(&host->lock, flags);
+
 			goto out;
 		}
 
-- 
1.9.1

