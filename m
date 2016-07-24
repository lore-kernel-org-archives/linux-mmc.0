From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] mmc: moxart: fix wait_for_completion_interruptible_timeout return variable type
Date: Sun, 24 Jul 2016 18:32:17 +0200
Message-ID: <1469377937-14360-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Luis de Bethencourt <luis@debethencourt.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: linux-mmc@vger.kernel.org

wait_for_completion_timeout_interruptible returns long not unsigned long
so dma_time, which is used exclusively here, is changed to long.

Fixes: 1b66e94e6b99 ("mmc: moxart: Add MOXA ART SD/MMC driver")

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

API non-compliance was located by coccinelle

This is mostly cosmetic since dma_time is not actually used for anything
at present, however if it ever were, then a signal received would be 
interpreted as a large remaining jiffies left, which would be wrong.

Compile tested with: moxart_defconfig + ARCH_MULTI_V4=y, 
CONFIG_ARCH_MOXART=y, CONFIG_MMC_MOXART=y

Patch is against 4.7.0-rc7 (localversion-next -next-20160724)

 drivers/mmc/host/moxart-mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 79905ce..2e5c25f 100644
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
 
@@ -397,7 +397,7 @@ static void moxart_prepare_data(struct moxart_host *host)
 static void moxart_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct moxart_host *host = mmc_priv(mmc);
-	unsigned long pio_time, flags;
+	long pio_time, flags;
 	u32 status;
 
 	spin_lock_irqsave(&host->lock, flags);
-- 
2.1.4
