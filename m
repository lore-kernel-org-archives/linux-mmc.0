From: Simon Horman <horms@verge.net.au>
Subject: [PATCH 2/4] mmc: tmio, sdhi: Split card interrupts based on source
Date: Mon, 15 Aug 2011 14:51:26 +0900
Message-ID: <1313387488-28175-3-git-send-email-horms@verge.net.au>
References: <1313387488-28175-1-git-send-email-horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1313387488-28175-1-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

SDHI hardware allows for two different card interrupt sources;
one for access and one for detect.

As preparation for wiring the sources up to separate interrupt handlers
this patch splits the card interrupt handler in two.

Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 drivers/mmc/host/tmio_mmc_pio.c |   34 ++++++++++++++++++++++++++--------
 1 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index e658cb4..3880750 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -543,17 +543,21 @@ out:
 	spin_unlock(&host->lock);
 }
 
-static void __tmio_mmc_card_irq(struct tmio_mmc_host *host)
+static void tmio_mmc_card_irq_status(struct tmio_mmc_host *host,
+				     int *ireg, int *irq_mask, int *status)
 {
-	struct mmc_host *mmc = host->mmc;
-	unsigned int ireg, irq_mask, status;
+	*status = sd_ctrl_read32(host, CTL_STATUS);
+	*irq_mask = sd_ctrl_read32(host, CTL_IRQ_MASK);
+	*ireg = *status & TMIO_MASK_IRQ & ~*irq_mask;
 
-	status = sd_ctrl_read32(host, CTL_STATUS);
-	irq_mask = sd_ctrl_read32(host, CTL_IRQ_MASK);
-	ireg = status & TMIO_MASK_IRQ & ~irq_mask;
+	pr_debug_status(*status);
+	pr_debug_status(*ireg);
+}
 
-	pr_debug_status(status);
-	pr_debug_status(ireg);
+static void __tmio_mmc_card_detect_irq(struct tmio_mmc_host *host,
+				       int ireg, int irq_mask, int status)
+{
+	struct mmc_host *mmc = host->mmc;
 
 	/* Card insert / remove attempts */
 	if (ireg & (TMIO_STAT_CARD_INSERT | TMIO_STAT_CARD_REMOVE)) {
@@ -564,7 +568,11 @@ static void __tmio_mmc_card_irq(struct tmio_mmc_host *host)
 		    !work_pending(&mmc->detect.work))
 			mmc_detect_change(host->mmc, msecs_to_jiffies(100));
 	}
+}
 
+void __tmio_mmc_card_access_irq(struct tmio_mmc_host *host,
+				int ireg, int irq_mask, int status)
+{
 	/* Command completion */
 	if (ireg & (TMIO_STAT_CMDRESPEND | TMIO_STAT_CMDTIMEOUT)) {
 		tmio_mmc_ack_mmc_irqs(host,
@@ -586,6 +594,16 @@ static void __tmio_mmc_card_irq(struct tmio_mmc_host *host)
 	}
 }
 
+static void __tmio_mmc_card_irq(struct tmio_mmc_host *host)
+{
+	unsigned int ireg, irq_mask, status;
+
+	tmio_mmc_card_irq_status(host, &ireg, &irq_mask, &status);
+
+	__tmio_mmc_card_detect_irq(host, ireg, irq_mask, status);
+	__tmio_mmc_card_access_irq(host, ireg, irq_mask, status);
+}
+
 static void __tmio_mmc_sdio_irq(struct tmio_mmc_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
-- 
1.7.5.4

