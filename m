From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH V2] mmc: moxart: fix wait_for_completion_interruptible_timeout return variable type
Date: Mon, 25 Jul 2016 19:59:23 +0200
Message-ID: <1469469563-31949-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.osadl.org ([62.245.132.105]:60636 "EHLO www.osadl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752923AbcGYR4g (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 25 Jul 2016 13:56:36 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Luis de Bethencourt <luis@debethencourt.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>

wait_for_completion_timeout_interruptible returns long not unsigned long
so dma_time, which is used exclusively here, is changed to long.

Fixes: 1b66e94e6b99 ("mmc: moxart: Add MOXA ART SD/MMC driver")

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

API non-compliance was located by coccinelle

V2: changed types of both pio_time and flags while only the pio_time type 
    was incorrect - flaged by Ulf Hansson <ulf.hansson@linaro.org> - Thanks!

This is mostly cosmetic since dma_time is not actually used for anything
at present, however if it ever were, then a signal received would be 
interpreted as a large remaining jiffies left, which would be wrong.

Compile tested with: moxart_defconfig + ARCH_MULTI_V4=y, 
CONFIG_ARCH_MOXART=y, CONFIG_MMC_MOXART=y

Patch is against 4.7.0-rc7 (localversion-next -next-20160725)
 drivers/mmc/host/moxart-mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 79905ce..bbad309 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -257,7 +257,7 @@ static void moxart_dma_complete(void *param)
 static void moxart_transfer_dma(struct mmc_data *data, struct moxart_host *host)
 {
 	u32 len, dir_data, dir_slave;
-	unsigned long dma_time;
+	long dma_time;
 	struct dma_async_tx_descriptor *desc = NULL;
 	struct dma_chan *dma_chan;
 
@@ -397,7 +397,8 @@ static void moxart_prepare_data(struct moxart_host *host)
 static void moxart_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct moxart_host *host = mmc_priv(mmc);
-	unsigned long pio_time, flags;
+	long pio_time;
+	unsigned long flags;
 	u32 status;
 
 	spin_lock_irqsave(&host->lock, flags);
-- 
2.1.4

