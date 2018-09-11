From: jun qian <hangdianqj@163.com>
Subject: [PATCH] mmc: mxcmmc: replace spin_lock_irqsave with spin_lock in ISR
Date: Tue, 11 Sep 2018 07:47:01 -0700
Message-ID: <20180911144701.53383-1-hangdianqj@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kees Cook <keescook@chromium.org>, Allen <allen.lkml@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, jun qian <hangdianqj@163.com>
List-Id: linux-mmc@vger.kernel.org

As you are already in ISR, it is unnecessary to call spin_lock_irqsave.

Signed-off-by: jun qian <hangdianqj@163.com>
---
 drivers/mmc/host/mxcmmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index de4e6e5bf304..4d17032d15ee 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -728,7 +728,6 @@ static void mxcmci_cmd_done(struct mxcmci_host *host, unsigned int stat)
 static irqreturn_t mxcmci_irq(int irq, void *devid)
 {
 	struct mxcmci_host *host = devid;
-	unsigned long flags;
 	bool sdio_irq;
 	u32 stat;
 
@@ -740,9 +739,9 @@ static irqreturn_t mxcmci_irq(int irq, void *devid)
 
 	dev_dbg(mmc_dev(host->mmc), "%s: 0x%08x\n", __func__, stat);
 
-	spin_lock_irqsave(&host->lock, flags);
+	spin_lock(&host->lock);
 	sdio_irq = (stat & STATUS_SDIO_INT_ACTIVE) && host->use_sdio;
-	spin_unlock_irqrestore(&host->lock, flags);
+	spin_unlock(&host->lock);
 
 	if (mxcmci_use_dma(host) && (stat & (STATUS_WRITE_OP_DONE)))
 		mxcmci_writel(host, STATUS_WRITE_OP_DONE, MMC_REG_STATUS);
-- 
2.17.1
