From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V3 25/30] omap_hsmmc: prevent races with irq handler
Date: Wed, 09 Sep 2009 14:59:41 +0300
Message-ID: <20090909115941.12833.73871.sendpatchset@ahunter-laptop>
References: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20090909115633.12833.39619.sendpatchset@ahunter-laptop>
Sender: linux-omap-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Pierre Ossman <pierre@ossman.eu>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Matt Fleming <matt@console-pimps.org>
List-Id: linux-mmc@vger.kernel.org

>From 8dc8e911b67f5c77e95c203908ff2ad7ce728b13 Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Sat, 16 May 2009 10:32:34 +0300
Subject: [PATCH] omap_hsmmc: prevent races with irq handler

If an unexpected interrupt occurs while preparing the
next request, an oops can occur.

For example, a new request is setting up DMA for data
transfer so host->data is not NULL.  An unexpected
transfer complete (TC) interrupt comes along and
the interrupt handler sets host->data to NULL.  Oops!

Prevent that by adding a spinlock.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 205cc3a..50c7f94 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -146,6 +146,8 @@ struct mmc_omap_host {
 	struct	work_struct	mmc_carddetect_work;
 	void	__iomem		*base;
 	resource_size_t		mapbase;
+	spinlock_t		irq_lock; /* Prevent races with irq handler */
+	unsigned long		flags;
 	unsigned int		id;
 	unsigned int		dma_len;
 	unsigned int		dma_sg_idx;
@@ -452,6 +454,14 @@ mmc_omap_start_command(struct mmc_omap_host *host, struct mmc_command *cmd,
 	if (host->use_dma)
 		cmdreg |= DMA_EN;
 
+	/*
+	 * In an interrupt context (i.e. STOP command), the spinlock is unlocked
+	 * by the interrupt handler, otherwise (i.e. for a new request) it is
+	 * unlocked here.
+	 */
+	if (!in_interrupt())
+		spin_unlock_irqrestore(&host->irq_lock, host->flags);
+
 	OMAP_HSMMC_WRITE(host->base, ARG, cmd->arg);
 	OMAP_HSMMC_WRITE(host->base, CMD, cmdreg);
 }
@@ -614,11 +624,14 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
 	struct mmc_data *data;
 	int end_cmd = 0, end_trans = 0, status;
 
+	spin_lock(&host->irq_lock);
+
 	if (host->mrq == NULL) {
 		OMAP_HSMMC_WRITE(host->base, STAT,
 			OMAP_HSMMC_READ(host->base, STAT));
 		/* Flush posted write */
 		OMAP_HSMMC_READ(host->base, STAT);
+		spin_unlock(&host->irq_lock);
 		return IRQ_HANDLED;
 	}
 
@@ -683,6 +696,8 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
 	if ((end_trans || (status & TC)) && host->mrq)
 		mmc_omap_xfer_done(host, data);
 
+	spin_unlock(&host->irq_lock);
+
 	return IRQ_HANDLED;
 }
 
@@ -1011,6 +1026,13 @@ static void omap_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
 	struct mmc_omap_host *host = mmc_priv(mmc);
 	int err;
 
+	/*
+	 * Prevent races with the interrupt handler because of unexpected
+	 * interrupts, but not if we are already in interrupt context i.e.
+	 * retries.
+	 */
+	if (!in_interrupt())
+		spin_lock_irqsave(&host->irq_lock, host->flags);
 	WARN_ON(host->mrq != NULL);
 	host->mrq = req;
 	err = mmc_omap_prepare_data(host, req);
@@ -1019,6 +1041,8 @@ static void omap_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
 		if (req->data)
 			req->data->error = err;
 		host->mrq = NULL;
+		if (!in_interrupt())
+			spin_unlock_irqrestore(&host->irq_lock, host->flags);
 		mmc_request_done(mmc, req);
 		return;
 	}
@@ -1573,6 +1597,7 @@ static int __init omap_mmc_probe(struct platform_device *pdev)
 	mmc->f_max	= 52000000;
 
 	sema_init(&host->sem, 1);
+	spin_lock_init(&host->irq_lock);
 
 	host->iclk = clk_get(&pdev->dev, "ick");
 	if (IS_ERR(host->iclk)) {
-- 
1.5.6.3

