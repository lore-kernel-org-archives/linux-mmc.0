From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/4] mmc: sdhci: Fix unexpected data interrupt handling
Date: Wed,  2 Nov 2016 15:49:09 +0200
Message-ID: <1478094551-24819-3-git-send-email-adrian.hunter@intel.com>
References: <1478094551-24819-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:57330 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752839AbcKBNyJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Nov 2016 09:54:09 -0400
In-Reply-To: <1478094551-24819-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Harjani Ritesh <riteshh@codeaurora.org>

In the busy response case (i.e. !host->data), an unexpected data interrupt
would result in clearing the data command as though it had completed but
without informing the upper layers and thus resulting in a hang.  Fix by
only clearing the data command for data interrupts that are expected.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # v4.8+
---
 drivers/mmc/host/sdhci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ad135d4449e6..e7e1a70645e3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2518,9 +2518,6 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 	if (!host->data) {
 		struct mmc_command *data_cmd = host->data_cmd;
 
-		if (data_cmd)
-			host->data_cmd = NULL;
-
 		/*
 		 * The "data complete" interrupt is also used to
 		 * indicate that a busy state has ended. See comment
@@ -2528,11 +2525,13 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		 */
 		if (data_cmd && (data_cmd->flags & MMC_RSP_BUSY)) {
 			if (intmask & SDHCI_INT_DATA_TIMEOUT) {
+				host->data_cmd = NULL;
 				data_cmd->error = -ETIMEDOUT;
 				sdhci_finish_mrq(host, data_cmd->mrq);
 				return;
 			}
 			if (intmask & SDHCI_INT_DATA_END) {
+				host->data_cmd = NULL;
 				/*
 				 * Some cards handle busy-end interrupt
 				 * before the command completed, so make
-- 
1.9.1

