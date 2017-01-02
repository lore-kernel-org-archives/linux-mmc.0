From: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Subject: [PATCH RESEND] sdhci: Only handle CARD_INT for SDIO cards
Date: Mon,  2 Jan 2017 16:23:50 -0200
Message-ID: <20170102182350.14326-1-krisman@collabora.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52684 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbdABSYP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jan 2017 13:24:15 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: Gabriel Krisman Bertazi <krisman@collabora.co.uk>, linux-mmc@vger.kernel.org

One of our kernelCI boxes hanged at boot because a faulty eSDHC device
was triggering spurious CARD_INT interrupts for SD cards, causing CMD52
reads, which are not allowed for SD devices.  This adds a sanity check
to the interruption path, preventing that illegal command from getting
sent to SD devices.

This quirk allows that particular machine to resume boot despite the
faulty hardware, instead of getting hung dealing with thousands of
mishandled interrupts.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
CC: Adrian Hunter <adrian.hunter@intel.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: linux-mmc@vger.kernel.org
---
 drivers/mmc/host/sdhci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 23909804ffb8..43913876581e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2665,6 +2665,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 {
 	irqreturn_t result = IRQ_NONE;
 	struct sdhci_host *host = dev_id;
+	struct mmc_host *mmc = host->mmc;
 	u32 intmask, mask, unexpected = 0;
 	int max_loops = 16;
 
@@ -2733,7 +2734,9 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
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

