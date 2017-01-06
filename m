From: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Subject: [PATCH v2] sdhci: Ignore unexpected CARD_INT interrupts
Date: Fri,  6 Jan 2017 13:49:16 -0200
Message-ID: <20170106154916.3472-1-krisman@collabora.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40397 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936219AbdAFPtb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Jan 2017 10:49:31 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.co.uk>

One of our kernelCI boxes hanged at boot because a faulty eSDHC device
was triggering spurious CARD_INT interrupts for SD cards, causing CMD52
reads, which are not allowed for SD devices.  This adds a sanity check
to the interruption path, preventing that illegal command from getting
sent if the CARD_INT interruption should be disabled.

This quirk allows that particular machine to resume boot despite the
faulty hardware, instead of getting hung dealing with thousands of
mishandled interrupts.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: linux-mmc@vger.kernel.org
---
 drivers/mmc/host/sdhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 23909804ffb8..0def99590d16 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2733,7 +2733,8 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 		if (intmask & SDHCI_INT_RETUNE)
 			mmc_retune_needed(host->mmc);
 
-		if (intmask & SDHCI_INT_CARD_INT) {
+		if ((intmask & SDHCI_INT_CARD_INT) &&
+		    (host->ier & SDHCI_INT_CARD_INT)) {
 			sdhci_enable_sdio_irq_nolock(host, false);
 			host->thread_isr |= SDHCI_INT_CARD_INT;
 			result = IRQ_WAKE_THREAD;
-- 
2.11.0

