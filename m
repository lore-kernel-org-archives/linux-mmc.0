From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: Do not hold spin_lock while waiting in set_ios
Date: Thu, 27 Jan 2011 12:56:41 -0800
Message-ID: <DACE2F62-BB3F-410D-82E5-295FB0890217@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:58331 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752564Ab1A0U61 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jan 2011 15:58:27 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


holding the spin_lock with all interrupts disabled
is not good form when doing mdelay.
set_ios calls routines need to delay for power to
stabalize or for chip issues when quirks are defined.

disable only our interupt and spin_lock on the chip
instead of spin_lock with all interrupts disabled.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Mark F. Brown <markb@marvell.com>
---
 drivers/mmc/host/sdhci.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 627c8cf..49394a2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1205,12 +1205,12 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host;
-	unsigned long flags;
 	u8 ctrl;
 
 	host = mmc_priv(mmc);
 
-	spin_lock_irqsave(&host->lock, flags);
+	disable_irq(host->irq);
+	spin_lock(&host->lock);
 
 	if (host->flags & SDHCI_DEVICE_DEAD)
 		goto out;
@@ -1286,7 +1286,8 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 out:
 	mmiowb();
-	spin_unlock_irqrestore(&host->lock, flags);
+	spin_unlock(&host->lock);
+	enable_irq(host->irq);
 }
 
 static int sdhci_get_ro(struct mmc_host *mmc)
-- 
1.7.0.4


