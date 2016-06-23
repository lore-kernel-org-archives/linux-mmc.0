From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] mmc: sdhci: Fix sdhci_card_busy()
Date: Thu, 23 Jun 2016 14:00:58 +0300
Message-ID: <1466679658-18604-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:5646 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589AbcFWLFH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Jun 2016 07:05:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

host->card_busy() was introduced for SD voltage switching which checks all
4 data lines.

Increasingly, host->card_busy is being used to poll the the busy signal
which is only data line 0 (DAT[0]).

The current logic in sdhci_card_busy() does not work in that case because
it returns false if any of the data lines is high.  It also ignores
possibilities:
	- data lines 1-3 are not connected and could show at any level
	- data lines 1-2 can be used by SDIO for other purposes

According to the SD specification, it is OK to check any of the data lines
for voltage switching, so change to use DAT[0] only.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


 It would probably be better for this patch to go before
 "mmc: mmc: Use ->card_busy() to detect busy cards in __mmc_switch()"


 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ec14b5d61fc6..15bdbcb99170 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1811,10 +1811,10 @@ static int sdhci_card_busy(struct mmc_host *mmc)
 	struct sdhci_host *host = mmc_priv(mmc);
 	u32 present_state;
 
-	/* Check whether DAT[3:0] is 0000 */
+	/* Check whether DAT[0] is 0 */
 	present_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
 
-	return !(present_state & SDHCI_DATA_LVL_MASK);
+	return !(present_state & SDHCI_DATA_0_LVL_MASK);
 }
 
 static int sdhci_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
-- 
1.9.1

