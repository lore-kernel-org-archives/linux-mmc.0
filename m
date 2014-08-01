From: yisun1 <yi.y.sun@intel.com>
Subject: [PATCH] mmc: execute tuning when device is not busy.
Date: Fri,  1 Aug 2014 14:49:16 +0800
Message-ID: <1406875757-379-1-git-send-email-yi.y.sun@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55280 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703AbaHAGza (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 1 Aug 2014 02:55:30 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: yi.y.sun@intel.com

We find tuning timeout because of the secure erase operation lasts too long
so not to do tuning when device is busy.

Signed-off-by: yisun1 <yi.y.sun@intel.com>
---
 drivers/mmc/host/sdhci.c |    3 ++-
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 47055f3..55491ae 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1359,7 +1359,8 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		 * tuning procedure before sending command.
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

