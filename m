From: Yi Sun <yi.y.sun@intel.com>
Subject: [PATCH v2] mmc: execute tuning when device is not busy.
Date: Thu, 14 Aug 2014 13:51:38 +0800
Message-ID: <1407995498-17634-1-git-send-email-yi.y.sun@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:23258 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110AbaHNF6A (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 14 Aug 2014 01:58:00 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: yi.y.sun@intel.com

We find tuning timeout because of the secure erase operation lasts too long
so not to do tuning when device is busy.

Signed-off-by: Yi Sun <yi.y.sun@intel.com>
---
 drivers/mmc/host/sdhci.c |    7 ++++---
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 47055f3..6a584d7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1355,11 +1355,12 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		present_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
 		/*
 		 * Check if the re-tuning timer has already expired and there
-		 * is no on-going data transfer. If so, we need to execute
-		 * tuning procedure before sending command.
+		 * is no on-going data transfer and DAT0 is not busy. If so,
+		 * we need to execute tuning procedure before sending command.
 		 */
 		if ((host->flags & SDHCI_NEEDS_RETUNING) &&
-		    !(present_state & (SDHCI_DOING_WRITE | SDHCI_DOING_READ))) {
+		    !(present_state & (SDHCI_DOING_WRITE | SDHCI_DOING_READ)) &&
+		    (present_state & SDHCI_DATA_0_LVL_MASK)) {
 			if (mmc->card) {
 				/* eMMC uses cmd21 but sd and sdio use cmd19 */
 				tuning_opcode =
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 4a5cd5e..0ae6b99d 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -72,6 +72,7 @@
 #define  SDHCI_WRITE_PROTECT	0x00080000
 #define  SDHCI_DATA_LVL_MASK	0x00F00000
 #define   SDHCI_DATA_LVL_SHIFT	20
+#define   SDHCI_DATA_0_LVL_MASK	0x00100000
 
 #define SDHCI_HOST_CONTROL	0x28
 #define  SDHCI_CTRL_LED		0x01
-- 
1.7.9.5

