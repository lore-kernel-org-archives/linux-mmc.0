From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH V2 4/6] mmc: tmio: simplify irq handler
Date: Tue, 26 Apr 2016 17:55:25 +0200
Message-ID: <1461686127-3217-5-git-send-email-wsa@the-dreams.de>
References: <1461686127-3217-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:51184 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752235AbcDZPzp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Apr 2016 11:55:45 -0400
In-Reply-To: <1461686127-3217-1-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Ulf Hansson <ulf.hansson@linaro.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Having just one irq handler again, let's include the 'card_status'
function in the main handler which is way more readable. Drop a useless
debug output while here. It should be a dev_dbg in case we ever need it
again.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index a7250a5fa670c5..879e0f5455ef44 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -632,19 +632,6 @@ out:
 	spin_unlock(&host->lock);
 }
 
-static void tmio_mmc_card_irq_status(struct tmio_mmc_host *host,
-				       int *ireg, int *status)
-{
-	*status = sd_ctrl_read32(host, CTL_STATUS);
-	*ireg = *status & TMIO_MASK_IRQ & ~host->sdcard_irq_mask;
-
-	pr_debug_status(*status);
-	pr_debug_status(*ireg);
-
-	/* Clear the status except the interrupt status */
-	sd_ctrl_write32(host, CTL_STATUS, TMIO_MASK_IRQ);
-}
-
 static bool __tmio_mmc_card_detect_irq(struct tmio_mmc_host *host,
 				      int ireg, int status)
 {
@@ -722,9 +709,15 @@ irqreturn_t tmio_mmc_irq(int irq, void *devid)
 	struct tmio_mmc_host *host = devid;
 	unsigned int ireg, status;
 
-	pr_debug("MMC IRQ begin\n");
+	status = sd_ctrl_read32(host, CTL_STATUS);
+	ireg = status & TMIO_MASK_IRQ & ~host->sdcard_irq_mask;
+
+	pr_debug_status(status);
+	pr_debug_status(ireg);
+
+	/* Clear the status except the interrupt status */
+	sd_ctrl_write32(host, CTL_STATUS, TMIO_MASK_IRQ);
 
-	tmio_mmc_card_irq_status(host, &ireg, &status);
 	if (__tmio_mmc_card_detect_irq(host, ireg, status))
 		return IRQ_HANDLED;
 	if (__tmio_mmc_sdcard_irq(host, ireg, status))
-- 
2.7.0

