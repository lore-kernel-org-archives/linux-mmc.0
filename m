From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 3/6] mmc: tmio: remove now unneeded seperate irq handlers
Date: Wed,  6 Apr 2016 11:25:31 +0200
Message-ID: <1459934734-3613-4-git-send-email-wsa@the-dreams.de>
References: <1459934734-3613-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58209 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754876AbcDFJZv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 6 Apr 2016 05:25:51 -0400
In-Reply-To: <1459934734-3613-1-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We removed installation of seperate handlers previously, so we can also
remove the seperate handlers.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc.h     |  3 ---
 drivers/mmc/host/tmio_mmc_pio.c | 31 ++-----------------------------
 2 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index b1819c74965b47..032188b766defd 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -115,9 +115,6 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host);
 void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 void tmio_mmc_disable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 irqreturn_t tmio_mmc_irq(int irq, void *devid);
-irqreturn_t tmio_mmc_sdcard_irq(int irq, void *devid);
-irqreturn_t tmio_mmc_card_detect_irq(int irq, void *devid);
-irqreturn_t tmio_mmc_sdio_irq(int irq, void *devid);
 
 static inline char *tmio_mmc_kmap_atomic(struct scatterlist *sg,
 					 unsigned long *flags)
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 8e2fef7c5e481c..a7250a5fa670c5 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -664,18 +664,6 @@ static bool __tmio_mmc_card_detect_irq(struct tmio_mmc_host *host,
 	return false;
 }
 
-irqreturn_t tmio_mmc_card_detect_irq(int irq, void *devid)
-{
-	unsigned int ireg, status;
-	struct tmio_mmc_host *host = devid;
-
-	tmio_mmc_card_irq_status(host, &ireg, &status);
-	__tmio_mmc_card_detect_irq(host, ireg, status);
-
-	return IRQ_HANDLED;
-}
-EXPORT_SYMBOL(tmio_mmc_card_detect_irq);
-
 static bool __tmio_mmc_sdcard_irq(struct tmio_mmc_host *host,
 				 int ireg, int status)
 {
@@ -705,19 +693,7 @@ static bool __tmio_mmc_sdcard_irq(struct tmio_mmc_host *host,
 	return false;
 }
 
-irqreturn_t tmio_mmc_sdcard_irq(int irq, void *devid)
-{
-	unsigned int ireg, status;
-	struct tmio_mmc_host *host = devid;
-
-	tmio_mmc_card_irq_status(host, &ireg, &status);
-	__tmio_mmc_sdcard_irq(host, ireg, status);
-
-	return IRQ_HANDLED;
-}
-EXPORT_SYMBOL(tmio_mmc_sdcard_irq);
-
-irqreturn_t tmio_mmc_sdio_irq(int irq, void *devid)
+static void tmio_mmc_sdio_irq(int irq, void *devid)
 {
 	struct tmio_mmc_host *host = devid;
 	struct mmc_host *mmc = host->mmc;
@@ -726,7 +702,7 @@ irqreturn_t tmio_mmc_sdio_irq(int irq, void *devid)
 	unsigned int sdio_status;
 
 	if (!(pdata->flags & TMIO_MMC_SDIO_IRQ))
-		return IRQ_HANDLED;
+		return;
 
 	status = sd_ctrl_read16(host, CTL_SDIO_STATUS);
 	ireg = status & TMIO_SDIO_MASK_ALL & ~host->sdcard_irq_mask;
@@ -739,10 +715,7 @@ irqreturn_t tmio_mmc_sdio_irq(int irq, void *devid)
 
 	if (mmc->caps & MMC_CAP_SDIO_IRQ && ireg & TMIO_SDIO_STAT_IOIRQ)
 		mmc_signal_sdio_irq(mmc);
-
-	return IRQ_HANDLED;
 }
-EXPORT_SYMBOL(tmio_mmc_sdio_irq);
 
 irqreturn_t tmio_mmc_irq(int irq, void *devid)
 {
-- 
2.7.0

