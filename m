From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: sdhci: fix incorrect command used in tuning
Date: Mon, 05 Nov 2012 14:45:16 -0500
Message-ID: <87wqxzal6b.fsf@octavius.laptop.org>
References: <1341307669-20834-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:56855 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752677Ab2KETpX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 5 Nov 2012 14:45:23 -0500
In-Reply-To: <1341307669-20834-1-git-send-email-aaron.lu@amd.com> (Aaron Lu's
	message of "Tue, 3 Jul 2012 17:27:49 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: Girish K S <girish.shivananjappa@linaro.org>, Subhash Jadavani <subhashj@codeaurora.org>, Philip Rakity <prakity@marvell.com>, linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

Hi Aaron,

On Tue, Jul 03 2012, Aaron Lu wrote:
>  		 */
>  		if ((host->flags & SDHCI_NEEDS_RETUNING) &&
>  		    !(present_state & (SDHCI_DOING_WRITE | SDHCI_DOING_READ))) {
> +			/* eMMC uses cmd21 while sd and sdio use cmd19 */
> +			tuning_opcode = mmc->card->type == MMC_TYPE_MMC ?
> +				MMC_SEND_TUNING_BLOCK_HS200 :
> +				MMC_SEND_TUNING_BLOCK;

This is causing a NULL deref crash here when run on host controllers
with no card inserted -- mmc->card is NULL, as you'd expect, yet it's
dereferenced anyway.  Maybe the system you tested it on only has an
eMMC, so you never noticed that it crashes if there's no card present?
Or maybe it's abnormal for host controllers to set SDHCI_NEEDS_RETUNING
when there's no card present?

In any case, this has hit 3.[345]-stable now, so we're causing crashes
for people who weren't seeing a crash before they pulled -stable.  :(
The patch below just checks mmc->card before dereferencing it -- does
this look like the correct fix to you?


Subject: [PATCH] mmc: sdhci: Fix NULL dereference in sdhci_request() tuning code

Commit 473b095a72a9 ("mmc: sdhci: fix incorrect command used in tuning")
introduced a NULL dereference if an SD 3.0 host controller raises the
SDHCI_NEEDS_TUNING flag while no card is inserted.

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/sdhci.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 07a5346..2e1175d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1294,16 +1294,19 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		 */
 		if ((host->flags & SDHCI_NEEDS_RETUNING) &&
 		    !(present_state & (SDHCI_DOING_WRITE | SDHCI_DOING_READ))) {
-			/* eMMC uses cmd21 while sd and sdio use cmd19 */
-			tuning_opcode = mmc->card->type == MMC_TYPE_MMC ?
-				MMC_SEND_TUNING_BLOCK_HS200 :
-				MMC_SEND_TUNING_BLOCK;
-			spin_unlock_irqrestore(&host->lock, flags);
-			sdhci_execute_tuning(mmc, tuning_opcode);
-			spin_lock_irqsave(&host->lock, flags);
-
-			/* Restore original mmc_request structure */
-			host->mrq = mrq;
+			if (mmc->card) {
+				/* eMMC uses cmd21 but sd and sdio use cmd19 */
+				tuning_opcode =
+					mmc->card->type == MMC_TYPE_MMC ?
+					MMC_SEND_TUNING_BLOCK_HS200 :
+					MMC_SEND_TUNING_BLOCK;
+				spin_unlock_irqrestore(&host->lock, flags);
+				sdhci_execute_tuning(mmc, tuning_opcode);
+				spin_lock_irqsave(&host->lock, flags);
+
+				/* Restore original mmc_request structure */
+				host->mrq = mrq;
+			}
 		}
 
 		if (mrq->sbc && !(host->flags & SDHCI_AUTO_CMD23))
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
