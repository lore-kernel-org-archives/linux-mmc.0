From: Jjian Zhou <jjian.zhou@mediatek.com>
Subject: [PATCH V2 1/2] mmc: mediatek: fix SDIO IRQ interrupt handle flow
Date: Mon, 17 Jun 2019 19:04:07 +0800
Message-ID: <1560769448-23070-1-git-send-email-jjian.zhou@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, chaotian.jing@mediatek.com, matthias.bgg@gmail.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: yong.mao@mediatek.com, srv_heupstream@mediatek.com, jjian zhou <jjian.zhou@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

From: jjian zhou <jjian.zhou@mediatek.com>

SDIO IRQ is triggered by low level. It need disable SDIO IRQ
detected function. Otherwise the interrupt register can't be cleared.
It will process the interrupt more.

Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
Signed-off-by: Yong Mao <yong.mao@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index c518cc2..fa7d420 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1383,24 +1383,25 @@ static void msdc_request_timeout(struct work_struct *work)
 	}
 }

-static void __msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
+static void __msdc_enable_sdio_irq(struct msdc_host *host, int enb)
 {
-	unsigned long flags;
-	struct msdc_host *host = mmc_priv(mmc);
-
-	spin_lock_irqsave(&host->lock, flags);
-	if (enb)
+	if (enb) {
 		sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
-	else
+		sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
+	} else {
 		sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
-	spin_unlock_irqrestore(&host->lock, flags);
+		sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
+	}
 }

 static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
 {
+	unsigned long flags;
 	struct msdc_host *host = mmc_priv(mmc);

-	__msdc_enable_sdio_irq(mmc, enb);
+	spin_lock_irqsave(&host->lock, flags);
+	__msdc_enable_sdio_irq(host, enb);
+	spin_unlock_irqrestore(&host->lock, flags);

 	if (enb)
 		pm_runtime_get_noresume(host->dev);
@@ -1422,6 +1423,8 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 		spin_lock_irqsave(&host->lock, flags);
 		events = readl(host->base + MSDC_INT);
 		event_mask = readl(host->base + MSDC_INTEN);
+		if ((events & event_mask) & MSDC_INT_SDIOIRQ)
+			__msdc_enable_sdio_irq(host, 0);
 		/* clear interrupts */
 		writel(events & event_mask, host->base + MSDC_INT);

@@ -1430,10 +1433,8 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 		data = host->data;
 		spin_unlock_irqrestore(&host->lock, flags);

-		if ((events & event_mask) & MSDC_INT_SDIOIRQ) {
-			__msdc_enable_sdio_irq(host->mmc, 0);
+		if ((events & event_mask) & MSDC_INT_SDIOIRQ)
 			sdio_signal_irq(host->mmc);
-		}

 		if ((events & event_mask) & MSDC_INT_CDSC) {
 			if (host->internal_cd)
@@ -1572,10 +1573,7 @@ static void msdc_init_hw(struct msdc_host *host)
 	sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIO);

 	/* Config SDIO device detect interrupt function */
-	if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
-		sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
-	else
-		sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
+	sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);

 	/* Configure to default data timeout */
 	sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
@@ -2103,7 +2101,12 @@ static void msdc_hw_reset(struct mmc_host *mmc)

 static void msdc_ack_sdio_irq(struct mmc_host *mmc)
 {
-	__msdc_enable_sdio_irq(mmc, 1);
+	unsigned long flags;
+	struct msdc_host *host = mmc_priv(mmc);
+
+	spin_lock_irqsave(&host->lock, flags);
+	__msdc_enable_sdio_irq(host, 1);
+	spin_unlock_irqrestore(&host->lock, flags);
 }

 static int msdc_get_cd(struct mmc_host *mmc)
--
1.9.1
