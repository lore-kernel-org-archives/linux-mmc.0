From: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Subject: [PATCH] sdhci: Only handle CARD_INT for SDIO cards
Date: Wed, 21 Dec 2016 19:13:18 -0200
Message-ID: <20161221211318.17660-1-krisman@collabora.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60142 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756552AbcLUVNs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Dec 2016 16:13:48 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.co.uk>

One of our kernelCI boxes hanged at boot because a faulty eSDHC device
was triggering spurious CARD_INT interrupts for SD cards, causing CMD52
reads, which are not allowed for SD devices.  This adds a sanity check
to the interruption path, preventing that illegal command from getting
sent to SD devices.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
---
 drivers/mmc/host/sdhci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 111991e5b9a0..4975b5db74bf 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2662,6 +2662,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 {
 	irqreturn_t result = IRQ_NONE;
 	struct sdhci_host *host = dev_id;
+	struct mmc_host *mmc = host->mmc;
 	u32 intmask, mask, unexpected = 0;
 	int max_loops = 16;
 
@@ -2730,7 +2731,9 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 		if (intmask & SDHCI_INT_RETUNE)
 			mmc_retune_needed(host->mmc);
 
-		if (intmask & SDHCI_INT_CARD_INT) {
+		if (intmask & SDHCI_INT_CARD_INT && mmc->card &&
+		    (mmc->card->type == MMC_TYPE_SDIO ||
+		     mmc->card->type == MMC_TYPE_SD_COMBO)) {
 			sdhci_enable_sdio_irq_nolock(host, false);
 			host->thread_isr |= SDHCI_INT_CARD_INT;
 			result = IRQ_WAKE_THREAD;
-- 
2.11.0

