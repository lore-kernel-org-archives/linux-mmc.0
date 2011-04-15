From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/3] MMC: protect the sh_mmcif driver against a theoretical
 race
Date: Fri, 15 Apr 2011 20:30:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1104152025500.18593@axis700.grange>
References: <Pine.LNX.4.64.1104152021510.18593@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1104152021510.18593@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

The MMC subsystem does not guarantee, that host driver .request() and
.set_ios() callbacks are serialised. Such concurrent calls, however,
do not have to be meaningfully supported, drivers just have to make
sure to avoid any severe problems.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <damm@opensource.se>
---
 drivers/mmc/host/sh_mmcif.c |   50 ++++++++++++++++++++++++++++++++++++-------
 1 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index af97015..d3871b6 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -29,6 +29,7 @@
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/pagemap.h>
 #include <linux/platform_device.h>
+#include <linux/spinlock.h>
 
 #define DRIVER_NAME	"sh_mmcif"
 #define DRIVER_VERSION	"2010-04-28"
@@ -153,6 +154,12 @@
 #define CLKDEV_MMC_DATA		20000000 /* 20MHz */
 #define CLKDEV_INIT		400000   /* 400 KHz */
 
+enum mmcif_state {
+	STATE_IDLE,
+	STATE_REQUEST,
+	STATE_IOS,
+};
+
 struct sh_mmcif_host {
 	struct mmc_host *mmc;
 	struct mmc_data *data;
@@ -164,6 +171,8 @@ struct sh_mmcif_host {
 	long timeout;
 	void __iomem *addr;
 	struct completion intr_wait;
+	enum mmcif_state state;
+	spinlock_t lock;
 
 	/* DMA support */
 	struct dma_chan		*chan_rx;
@@ -798,17 +807,31 @@ static void sh_mmcif_stop_cmd(struct sh_mmcif_host *host,
 static void sh_mmcif_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct sh_mmcif_host *host = mmc_priv(mmc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+	if (host->state != STATE_IDLE) {
+		spin_unlock_irqrestore(&host->lock, flags);
+		mrq->cmd->error = -EAGAIN;
+		mmc_request_done(mmc, mrq);
+		return;
+	}
+
+	host->state = STATE_REQUEST;
+	spin_unlock_irqrestore(&host->lock, flags);
 
 	switch (mrq->cmd->opcode) {
 	/* MMCIF does not support SD/SDIO command */
 	case SD_IO_SEND_OP_COND:
 	case MMC_APP_CMD:
+		host->state = STATE_IDLE;
 		mrq->cmd->error = -ETIMEDOUT;
 		mmc_request_done(mmc, mrq);
 		return;
 	case MMC_SEND_EXT_CSD: /* = SD_SEND_IF_COND (8) */
 		if (!mrq->data) {
 			/* send_if_cond cmd (not support) */
+			host->state = STATE_IDLE;
 			mrq->cmd->error = -ETIMEDOUT;
 			mmc_request_done(mmc, mrq);
 			return;
@@ -830,12 +853,9 @@ static void sh_mmcif_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	sh_mmcif_start_cmd(host, mrq, mrq->cmd);
 	host->data = NULL;
 
-	if (mrq->cmd->error != 0) {
-		mmc_request_done(mmc, mrq);
-		return;
-	}
-	if (mrq->stop)
+	if (!mrq->cmd->error && mrq->stop)
 		sh_mmcif_stop_cmd(host, mrq, mrq->stop);
+	host->state = STATE_IDLE;
 	mmc_request_done(mmc, mrq);
 }
 
@@ -843,6 +863,16 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sh_mmcif_host *host = mmc_priv(mmc);
 	struct sh_mmcif_plat_data *p = host->pd->dev.platform_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+	if (host->state != STATE_IDLE) {
+		spin_unlock_irqrestore(&host->lock, flags);
+		return;
+	}
+
+	host->state = STATE_IOS;
+	spin_unlock_irqrestore(&host->lock, flags);
 
 	if (ios->power_mode == MMC_POWER_UP) {
 		if (p->set_pwr)
@@ -852,6 +882,7 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		sh_mmcif_clock_control(host, 0);
 		if (ios->power_mode == MMC_POWER_OFF && p->down_pwr)
 			p->down_pwr(host->pd);
+		host->state = STATE_IDLE;
 		return;
 	}
 
@@ -859,6 +890,7 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		sh_mmcif_clock_control(host, ios->clock);
 
 	host->bus_width = ios->bus_width;
+	host->state = STATE_IDLE;
 }
 
 static int sh_mmcif_get_cd(struct mmc_host *mmc)
@@ -996,6 +1028,7 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	host->pd = pdev;
 
 	init_completion(&host->intr_wait);
+	spin_lock_init(&host->lock);
 
 	mmc->ops = &sh_mmcif_ops;
 	mmc->f_max = host->clk;
@@ -1025,6 +1058,8 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 
 	mmc_add_host(mmc);
 
+	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
+
 	ret = request_irq(irq[0], sh_mmcif_intr, 0, "sh_mmc:error", host);
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq error (sh_mmc:error)\n");
@@ -1037,7 +1072,6 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 		goto clean_up2;
 	}
 
-	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
 	sh_mmcif_detect(host->mmc);
 
 	dev_info(&pdev->dev, "driver version %s\n", DRIVER_VERSION);
@@ -1063,11 +1097,11 @@ static int __devexit sh_mmcif_remove(struct platform_device *pdev)
 	mmc_remove_host(host->mmc);
 	sh_mmcif_release_dma(host);
 
+	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
+
 	if (host->addr)
 		iounmap(host->addr);
 
-	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
-
 	irq[0] = platform_get_irq(pdev, 0);
 	irq[1] = platform_get_irq(pdev, 1);
 
-- 
1.7.2.5

