From: Aaron Lu <aaron.lu@amd.com>
Subject: [PATCH] mmc: sdhci: fix incorrect command used in tuning
Date: Wed, 27 Jun 2012 16:13:54 +0800
Message-ID: <1340784834-7429-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]:19284
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756138Ab2F0IPH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jun 2012 04:15:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>, Subhash Jadavani <subhashj@codeaurora.org>, Chris Ball <cjb@laptop.org>, Philip Rakity <prakity@marvell.com>
Cc: linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Aaron Lu <aaron.lu@amd.com>, stable <stable@vger.kernel.org>, "[3.3+]"@domain.invalid

For SD hosts using retuning mode 1, when retuning timer expired, it will
need to do retuning in sdhci_request before processing the actual
request. But the retuning command is fixed: cmd19 for SD card and cmd21
for eMMC card, so we can't use the original request's command to do the
tuning.

And since the tuning command depends on the card type atteched to the
host, we will need to know the card type to use the correct tuning
command.

Signed-off-by: Aaron Lu <aaron.lu@amd.com>
Cc: stable <stable@vger.kernel.org> [3.3+]
---
 drivers/mmc/host/sdhci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f4b8b4d..ff522ec 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -27,6 +27,7 @@
 
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/card.h>
 
 #include "sdhci.h"
 
@@ -1245,6 +1246,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	struct sdhci_host *host;
 	bool present;
 	unsigned long flags;
+	u32 tuning_opcode;
 
 	host = mmc_priv(mmc);
 
@@ -1292,8 +1294,11 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		 */
 		if ((host->flags & SDHCI_NEEDS_RETUNING) &&
 		    !(present_state & (SDHCI_DOING_WRITE | SDHCI_DOING_READ))) {
+			tuning_opcode = mmc->card->type == MMC_TYPE_SD ?
+				MMC_SEND_TUNING_BLOCK :
+				MMC_SEND_TUNING_BLOCK_HS200;
 			spin_unlock_irqrestore(&host->lock, flags);
-			sdhci_execute_tuning(mmc, mrq->cmd->opcode);
+			sdhci_execute_tuning(mmc, tuning_opcode);
 			spin_lock_irqsave(&host->lock, flags);
 
 			/* Restore original mmc_request structure */
-- 
1.7.11.2.gd284367


