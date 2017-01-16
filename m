From: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Subject: [PATCH v2 RESEND] sdhci: Ignore unexpected CARD_INT interrupts
Date: Mon, 16 Jan 2017 12:23:42 -0200
Message-ID: <20170116142342.21283-1-krisman@collabora.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34888 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbdAPOXz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2017 09:23:55 -0500
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
index 51cd4f0e973f..a2efa25c7f3b 100644
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

