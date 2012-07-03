From: Philip Rakity <prakity@marvell.com>
Subject: RE: [PATCH v2] mmc: sdhci: fix incorrect command used in tuning
Date: Tue, 3 Jul 2012 07:03:28 -0700
Message-ID: <43E4817426ED174AA81263BCECB4351D138E8ACE8D@sc-vexch3.marvell.com>
References: <1341307669-20834-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:39688 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750818Ab2GCOFk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 3 Jul 2012 10:05:40 -0400
In-Reply-To: <1341307669-20834-1-git-send-email-aaron.lu@amd.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>, Girish K S <girish.shivananjappa@linaro.org>, Subhash Jadavani <subhashj@codeaurora.org>, Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Aaron Lu <aaron.lwe@gmail.com>, stable <stable@vger.kernel.org>, "\"[3.3+]\"@domain.invalid" <"[3.3+]"@domain.invalid>

Reviewed-by philip Rakity prakity@marvell.com
________________________________________
From: Aaron Lu [aaron.lu@amd.com]
Sent: Tuesday, July 03, 2012 2:27 AM
To: Girish K S; Subhash Jadavani; Philip Rakity; Chris Ball
Cc: linux-mmc@vger.kernel.org; Aaron Lu; Aaron Lu; stable; "[3.3+]"@domain.invalid
Subject: [PATCH v2] mmc: sdhci: fix incorrect command used in tuning

V2:
Fix for SDIO case: both SD and SDIO cards use cmd19 while eMMC use cmd21.

V1:
For SD hosts using retuning mode 1, when retuning timer expired, it will
need to do retuning in sdhci_request before processing the actual
request. But the retuning command is fixed: cmd19 for SD card and cmd21
for eMMC card, so we can't use the original request's command to do the
tuning.

And since the tuning command depends on the card type atteched to the
host, we will need to know the card type to use the correct tuning
command.

Cc: stable <stable@vger.kernel.org> [3.3+]
Signed-off-by: Aaron Lu <aaron.lu@amd.com>
---
 drivers/mmc/host/sdhci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f76736b..4e53e6b 100644
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
+       u32 tuning_opcode;

        host = mmc_priv(mmc);

@@ -1292,8 +1294,12 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
                 */
                if ((host->flags & SDHCI_NEEDS_RETUNING) &&
                    !(present_state & (SDHCI_DOING_WRITE | SDHCI_DOING_READ))) {
+                       /* eMMC uses cmd21 while sd and sdio use cmd19 */
+                       tuning_opcode = mmc->card->type == MMC_TYPE_MMC ?
+                               MMC_SEND_TUNING_BLOCK_HS200 :
+                               MMC_SEND_TUNING_BLOCK;
                        spin_unlock_irqrestore(&host->lock, flags);
-                       sdhci_execute_tuning(mmc, mrq->cmd->opcode);
+                       sdhci_execute_tuning(mmc, tuning_opcode);
                        spin_lock_irqsave(&host->lock, flags);

                        /* Restore original mmc_request structure */
--
1.7.11.1.3.g4c8a9db


