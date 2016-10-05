From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/4] mmc: sdhci: Fix SDHCI_QUIRK2_STOP_WITH_TC
Date: Wed,  5 Oct 2016 12:11:21 +0300
Message-ID: <1475658684-32312-2-git-send-email-adrian.hunter@intel.com>
References: <1475658684-32312-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:13461 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751097AbcJEJRD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 5 Oct 2016 05:17:03 -0400
In-Reply-To: <1475658684-32312-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>

Multi-block data transfers can specify the number of blocks either using a
Set Block Count command (CMD23) or by sending a STOP command (CMD12) after
the required number of blocks has transferred. CMD23 is preferred, but some
cards don't support it. CMD12 with R1b response is used for writes, and
R1 response for reads.

Some SDHCI host controllers give a Transfer Complete (TC) interrupt for the
STOP command (CMD12) whether or not a R1b response has been specified. The
quirk SDHCI_QUIRK2_STOP_WITH_TC identifies those host controllers, but the
implementation only considers the case where the TC interrupt arrives at
the same time as the Command Complete (CC) interrupt. However,
occasionally TC arrives before CC. That is harmless, but does generate an
error message "Got data interrupt 0x00000002 even though no data operation
was in progress".

A simpler approach is to force R1b response onto all STOP commands, because
SDHCI will handle TC before CC in the general case, so do that.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 drivers/mmc/host/sdhci.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 48055666c655..3711813f5654 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1077,6 +1077,10 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	/* Initially, a command has no error */
 	cmd->error = 0;
 
+	if ((host->quirks2 & SDHCI_QUIRK2_STOP_WITH_TC) &&
+	    cmd->opcode == MMC_STOP_TRANSMISSION)
+		cmd->flags |= MMC_RSP_BUSY;
+
 	/* Wait max 10 ms */
 	timeout = 10;
 
@@ -2409,7 +2413,7 @@ static void sdhci_timeout_data_timer(unsigned long data)
  *                                                                           *
 \*****************************************************************************/
 
-static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
+static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask)
 {
 	if (!host->cmd) {
 		/*
@@ -2453,11 +2457,6 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *mask)
 		return;
 	}
 
-	if ((host->quirks2 & SDHCI_QUIRK2_STOP_WITH_TC) &&
-	    !(host->cmd->flags & MMC_RSP_BUSY) && !host->data &&
-	    host->cmd->opcode == MMC_STOP_TRANSMISSION)
-		*mask &= ~SDHCI_INT_DATA_END;
-
 	if (intmask & SDHCI_INT_RESPONSE)
 		sdhci_finish_command(host);
 }
@@ -2680,8 +2679,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 		}
 
 		if (intmask & SDHCI_INT_CMD_MASK)
-			sdhci_cmd_irq(host, intmask & SDHCI_INT_CMD_MASK,
-				      &intmask);
+			sdhci_cmd_irq(host, intmask & SDHCI_INT_CMD_MASK);
 
 		if (intmask & SDHCI_INT_DATA_MASK)
 			sdhci_data_irq(host, intmask & SDHCI_INT_DATA_MASK);
-- 
1.9.1

