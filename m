From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH v2] omap_hsmmc: improve interrupt synchronisation
Date: Fri, 23 Apr 2010 16:08:11 +0300
Message-ID: <4BD19BBB.40701@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: Venkatraman S <svenkatr@ti.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

>From ad2e1cd024ccf9144b6620cfe808893719db738f Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Wed, 14 Apr 2010 16:26:45 +0300
Subject: [PATCH] omap_hsmmc: improve interrupt synchronisation

The following changes were needed:
	- do not use in_interrupt() because it will not work
	with threaded interrupts

In addition, the following improvements were made:
	- ensure DMA is unmapped only after the final DMA interrupt
	- ensure a request is completed only after the final DMA interrupt
	- disable controller interrupts when a request is not in progress
	- remove the spin-lock protecting the start of a new request from
	an unexpected interrupt because the locking was complicated and
	a 'req_in_progress' flag suffices (since the spin-lock only defers
	the unexpected interrupts anyway)
	- instead use the spin-lock to protect the MMC interrupt handler
	from the DMA interrupt handler
	- remove the semaphore preventing DMA from being started while
	the previous DMA is still in progress - the other changes make that
	impossible, so it is now a BUG_ON condition
	- ensure the controller interrupt status is clear before exiting
	the interrrupt handler

In general, these changes make the code safer but do not fix any specific
bugs so backporting is not necessary.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---


Changes from version 1:
	- use a spin-lock to protect the MMC interrupt handler
	from the DMA interrupt handler
	- use do {} while loop instead of goto in omap_hsmmc_irq

S Venkatraman's request to use omap_hsmmc_dma_cleanup(host, 0) in
omap_hsmmc_dma_cb() was not done because the code was not
sufficiently the same.


 drivers/mmc/host/omap_hsmmc.c |  262 +++++++++++++++++++++--------------------
 1 files changed, 134 insertions(+), 128 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index c0b5021..cc0272d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -157,12 +157,10 @@ struct omap_hsmmc_host {
 	 */
 	struct	regulator	*vcc;
 	struct	regulator	*vcc_aux;
-	struct	semaphore	sem;
 	struct	work_struct	mmc_carddetect_work;
 	void	__iomem		*base;
 	resource_size_t		mapbase;
 	spinlock_t		irq_lock; /* Prevent races with irq handler */
-	unsigned long		flags;
 	unsigned int		id;
 	unsigned int		dma_len;
 	unsigned int		dma_sg_idx;
@@ -183,6 +181,7 @@ struct omap_hsmmc_host {
 	int			protect_card;
 	int			reqs_blocked;
 	int			use_reg;
+	int			req_in_progress;
 
 	struct	omap_mmc_platform_data	*pdata;
 };
@@ -480,6 +479,27 @@ static void omap_hsmmc_stop_clock(struct omap_hsmmc_host *host)
 		dev_dbg(mmc_dev(host->mmc), "MMC Clock is not stoped\n");
 }
 
+static void omap_hsmmc_enable_irq(struct omap_hsmmc_host *host)
+{
+	unsigned int irq_mask;
+
+	if (host->use_dma)
+		irq_mask = INT_EN_MASK & ~(BRR_ENABLE | BWR_ENABLE);
+	else
+		irq_mask = INT_EN_MASK;
+
+	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
+	OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
+	OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
+}
+
+static void omap_hsmmc_disable_irq(struct omap_hsmmc_host *host)
+{
+	OMAP_HSMMC_WRITE(host->base, ISE, 0);
+	OMAP_HSMMC_WRITE(host->base, IE, 0);
+	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
+}
+
 #ifdef CONFIG_PM
 
 /*
@@ -548,9 +568,7 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 		&& time_before(jiffies, timeout))
 		;
 
-	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
-	OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
-	OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
+	omap_hsmmc_disable_irq(host);
 
 	/* Do not initialize card-specific things if the power is off */
 	if (host->power_mode == MMC_POWER_OFF)
@@ -653,6 +671,8 @@ static void send_init_stream(struct omap_hsmmc_host *host)
 		return;
 
 	disable_irq(host->irq);
+
+	OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
 	OMAP_HSMMC_WRITE(host->base, CON,
 		OMAP_HSMMC_READ(host->base, CON) | INIT_STREAM);
 	OMAP_HSMMC_WRITE(host->base, CMD, INIT_STREAM_CMD);
@@ -718,17 +738,7 @@ omap_hsmmc_start_command(struct omap_hsmmc_host *host, struct mmc_command *cmd,
 		mmc_hostname(host->mmc), cmd->opcode, cmd->arg);
 	host->cmd = cmd;
 
-	/*
-	 * Clear status bits and enable interrupts
-	 */
-	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
-	OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
-
-	if (host->use_dma)
-		OMAP_HSMMC_WRITE(host->base, IE,
-				 INT_EN_MASK & ~(BRR_ENABLE | BWR_ENABLE));
-	else
-		OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
+	omap_hsmmc_enable_irq(host);
 
 	host->response_busy = 0;
 	if (cmd->flags & MMC_RSP_PRESENT) {
@@ -762,13 +772,7 @@ omap_hsmmc_start_command(struct omap_hsmmc_host *host, struct mmc_command *cmd,
 	if (host->use_dma)
 		cmdreg |= DMA_EN;
 
-	/*
-	 * In an interrupt context (i.e. STOP command), the spinlock is unlocked
-	 * by the interrupt handler, otherwise (i.e. for a new request) it is
-	 * unlocked here.
-	 */
-	if (!in_interrupt())
-		spin_unlock_irqrestore(&host->irq_lock, host->flags);
+	host->req_in_progress = 1;
 
 	OMAP_HSMMC_WRITE(host->base, ARG, cmd->arg);
 	OMAP_HSMMC_WRITE(host->base, CMD, cmdreg);
@@ -783,6 +787,23 @@ omap_hsmmc_get_dma_dir(struct omap_hsmmc_host *host, struct mmc_data *data)
 		return DMA_FROM_DEVICE;
 }
 
+static void omap_hsmmc_request_done(struct omap_hsmmc_host *host, struct mmc_request *mrq)
+{
+	int dma_ch;
+
+	spin_lock(&host->irq_lock);
+	host->req_in_progress = 0;
+	dma_ch = host->dma_ch;
+	spin_unlock(&host->irq_lock);
+
+	omap_hsmmc_disable_irq(host);
+	/* Do not complete the request if DMA is still in progress */
+	if (mrq->data && host->use_dma && dma_ch != -1)
+		return;
+	host->mrq = NULL;
+	mmc_request_done(host->mmc, mrq);
+}
+
 /*
  * Notify the transfer complete to MMC core
  */
@@ -799,25 +820,19 @@ omap_hsmmc_xfer_done(struct omap_hsmmc_host *host, struct mmc_data *data)
 			return;
 		}
 
-		host->mrq = NULL;
-		mmc_request_done(host->mmc, mrq);
+		omap_hsmmc_request_done(host, mrq);
 		return;
 	}
 
 	host->data = NULL;
 
-	if (host->use_dma && host->dma_ch != -1)
-		dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->dma_len,
-			omap_hsmmc_get_dma_dir(host, data));
-
 	if (!data->error)
 		data->bytes_xfered += data->blocks * (data->blksz);
 	else
 		data->bytes_xfered = 0;
 
 	if (!data->stop) {
-		host->mrq = NULL;
-		mmc_request_done(host->mmc, data->mrq);
+		omap_hsmmc_request_done(host, data->mrq);
 		return;
 	}
 	omap_hsmmc_start_command(host, data->stop, NULL);
@@ -843,10 +858,8 @@ omap_hsmmc_cmd_done(struct omap_hsmmc_host *host, struct mmc_command *cmd)
 			cmd->resp[0] = OMAP_HSMMC_READ(host->base, RSP10);
 		}
 	}
-	if ((host->data == NULL && !host->response_busy) || cmd->error) {
-		host->mrq = NULL;
-		mmc_request_done(host->mmc, cmd->mrq);
-	}
+	if ((host->data == NULL && !host->response_busy) || cmd->error)
+		omap_hsmmc_request_done(host, cmd->mrq);
 }
 
 /*
@@ -854,14 +867,19 @@ omap_hsmmc_cmd_done(struct omap_hsmmc_host *host, struct mmc_command *cmd)
  */
 static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_host *host, int errno)
 {
+	int dma_ch;
+
 	host->data->error = errno;
 
-	if (host->use_dma && host->dma_ch != -1) {
+	spin_lock(&host->irq_lock);
+	dma_ch = host->dma_ch;
+	host->dma_ch = -1;
+	spin_unlock(&host->irq_lock);
+
+	if (host->use_dma && dma_ch != -1) {
 		dma_unmap_sg(mmc_dev(host->mmc), host->data->sg, host->dma_len,
 			omap_hsmmc_get_dma_dir(host, host->data));
-		omap_free_dma(host->dma_ch);
-		host->dma_ch = -1;
-		up(&host->sem);
+		omap_free_dma(dma_ch);
 	}
 	host->data = NULL;
 }
@@ -923,28 +941,21 @@ static inline void omap_hsmmc_reset_controller_fsm(struct omap_hsmmc_host *host,
 			__func__);
 }
 
-/*
- * MMC controller IRQ handler
- */
-static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
+static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 {
-	struct omap_hsmmc_host *host = dev_id;
 	struct mmc_data *data;
-	int end_cmd = 0, end_trans = 0, status;
-
-	spin_lock(&host->irq_lock);
-
-	if (host->mrq == NULL) {
-		OMAP_HSMMC_WRITE(host->base, STAT,
-			OMAP_HSMMC_READ(host->base, STAT));
-		/* Flush posted write */
-		OMAP_HSMMC_READ(host->base, STAT);
-		spin_unlock(&host->irq_lock);
-		return IRQ_HANDLED;
+	int end_cmd = 0, end_trans = 0;
+
+	if (!host->req_in_progress) {
+		do {
+			OMAP_HSMMC_WRITE(host->base, STAT, status);
+			/* Flush posted write */
+			status = OMAP_HSMMC_READ(host->base, STAT);
+		} while (status & INT_EN_MASK);
+		return;
 	}
 
 	data = host->data;
-	status = OMAP_HSMMC_READ(host->base, STAT);
 	dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
 
 	if (status & ERR) {
@@ -997,15 +1008,27 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
 	}
 
 	OMAP_HSMMC_WRITE(host->base, STAT, status);
-	/* Flush posted write */
-	OMAP_HSMMC_READ(host->base, STAT);
 
 	if (end_cmd || ((status & CC) && host->cmd))
 		omap_hsmmc_cmd_done(host, host->cmd);
 	if ((end_trans || (status & TC)) && host->mrq)
 		omap_hsmmc_xfer_done(host, data);
+}
 
-	spin_unlock(&host->irq_lock);
+/*
+ * MMC controller IRQ handler
+ */
+static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
+{
+	struct omap_hsmmc_host *host = dev_id;
+	int status;
+
+	status = OMAP_HSMMC_READ(host->base, STAT);
+	do {
+		omap_hsmmc_do_irq(host, status);
+		/* Flush posted write */
+		status = OMAP_HSMMC_READ(host->base, STAT);
+	} while (status & INT_EN_MASK);
 
 	return IRQ_HANDLED;
 }
@@ -1205,31 +1228,47 @@ static void omap_hsmmc_config_dma_params(struct omap_hsmmc_host *host,
 /*
  * DMA call back function
  */
-static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *data)
+static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *cb_data)
 {
-	struct omap_hsmmc_host *host = data;
+	struct omap_hsmmc_host *host = cb_data;
+	struct mmc_data *data = host->mrq->data;
+	int dma_ch, req_in_progress;
 
 	if (ch_status & OMAP2_DMA_MISALIGNED_ERR_IRQ)
 		dev_dbg(mmc_dev(host->mmc), "MISALIGNED_ADRS_ERR\n");
 
-	if (host->dma_ch < 0)
+	spin_lock(&host->irq_lock);
+	if (host->dma_ch < 0) {
+		spin_unlock(&host->irq_lock);
 		return;
+	}
 
 	host->dma_sg_idx++;
 	if (host->dma_sg_idx < host->dma_len) {
 		/* Fire up the next transfer. */
-		omap_hsmmc_config_dma_params(host, host->data,
-					   host->data->sg + host->dma_sg_idx);
+		omap_hsmmc_config_dma_params(host, data,
+					   data->sg + host->dma_sg_idx);
+		spin_unlock(&host->irq_lock);
 		return;
 	}
 
-	omap_free_dma(host->dma_ch);
+	dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->dma_len,
+		omap_hsmmc_get_dma_dir(host, data));
+
+	req_in_progress = host->req_in_progress;
+	dma_ch = host->dma_ch;
 	host->dma_ch = -1;
-	/*
-	 * DMA Callback: run in interrupt context.
-	 * mutex_unlock will throw a kernel warning if used.
-	 */
-	up(&host->sem);
+	spin_unlock(&host->irq_lock);
+
+	omap_free_dma(dma_ch);
+
+	/* If DMA has finished after TC, complete the request */
+	if (!req_in_progress) {
+		struct mmc_request *mrq = host->mrq;
+
+		host->mrq = NULL;
+		mmc_request_done(host->mmc, mrq);
+	}
 }
 
 /*
@@ -1238,7 +1277,7 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *data)
 static int omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host,
 					struct mmc_request *req)
 {
-	int dma_ch = 0, ret = 0, err = 1, i;
+	int dma_ch = 0, ret = 0, i;
 	struct mmc_data *data = req->data;
 
 	/* Sanity check: all the SG entries must be aligned by block size. */
@@ -1255,23 +1294,7 @@ static int omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host,
 		 */
 		return -EINVAL;
 
-	/*
-	 * If for some reason the DMA transfer is still active,
-	 * we wait for timeout period and free the dma
-	 */
-	if (host->dma_ch != -1) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(100);
-		if (down_trylock(&host->sem)) {
-			omap_free_dma(host->dma_ch);
-			host->dma_ch = -1;
-			up(&host->sem);
-			return err;
-		}
-	} else {
-		if (down_trylock(&host->sem))
-			return err;
-	}
+	BUG_ON(host->dma_ch != -1);
 
 	ret = omap_request_dma(omap_hsmmc_get_dma_sync_dev(host, data),
 			       "MMC/SD", omap_hsmmc_dma_cb, host, &dma_ch);
@@ -1371,37 +1394,27 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
 	struct omap_hsmmc_host *host = mmc_priv(mmc);
 	int err;
 
-	/*
-	 * Prevent races with the interrupt handler because of unexpected
-	 * interrupts, but not if we are already in interrupt context i.e.
-	 * retries.
-	 */
-	if (!in_interrupt()) {
-		spin_lock_irqsave(&host->irq_lock, host->flags);
-		/*
-		 * Protect the card from I/O if there is a possibility
-		 * it can be removed.
-		 */
-		if (host->protect_card) {
-			if (host->reqs_blocked < 3) {
-				/*
-				 * Ensure the controller is left in a consistent
-				 * state by resetting the command and data state
-				 * machines.
-				 */
-				omap_hsmmc_reset_controller_fsm(host, SRD);
-				omap_hsmmc_reset_controller_fsm(host, SRC);
-				host->reqs_blocked += 1;
-			}
-			req->cmd->error = -EBADF;
-			if (req->data)
-				req->data->error = -EBADF;
-			spin_unlock_irqrestore(&host->irq_lock, host->flags);
-			mmc_request_done(mmc, req);
-			return;
-		} else if (host->reqs_blocked)
-			host->reqs_blocked = 0;
-	}
+	BUG_ON(host->req_in_progress);
+	BUG_ON(host->dma_ch != -1);
+	if (host->protect_card) {
+		if (host->reqs_blocked < 3) {
+			/*
+			 * Ensure the controller is left in a consistent
+			 * state by resetting the command and data state
+			 * machines.
+			 */
+			omap_hsmmc_reset_controller_fsm(host, SRD);
+			omap_hsmmc_reset_controller_fsm(host, SRC);
+			host->reqs_blocked += 1;
+		}
+		req->cmd->error = -EBADF;
+		if (req->data)
+			req->data->error = -EBADF;
+		req->cmd->retries = 0;
+		mmc_request_done(mmc, req);
+		return;
+	} else if (host->reqs_blocked)
+		host->reqs_blocked = 0;
 	WARN_ON(host->mrq != NULL);
 	host->mrq = req;
 	err = omap_hsmmc_prepare_data(host, req);
@@ -1410,8 +1423,6 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
 		if (req->data)
 			req->data->error = err;
 		host->mrq = NULL;
-		if (!in_interrupt())
-			spin_unlock_irqrestore(&host->irq_lock, host->flags);
 		mmc_request_done(mmc, req);
 		return;
 	}
@@ -1980,7 +1991,6 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 	mmc->f_min	= 400000;
 	mmc->f_max	= 52000000;
 
-	sema_init(&host->sem, 1);
 	spin_lock_init(&host->irq_lock);
 
 	host->iclk = clk_get(&pdev->dev, "ick");
@@ -2126,8 +2136,7 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 		}
 	}
 
-	OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
-	OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
+	omap_hsmmc_disable_irq(host);
 
 	mmc_host_lazy_disable(host->mmc);
 
@@ -2247,10 +2256,7 @@ static int omap_hsmmc_suspend(struct platform_device *pdev, pm_message_t state)
 		mmc_host_enable(host->mmc);
 		ret = mmc_suspend_host(host->mmc, state);
 		if (ret == 0) {
-			OMAP_HSMMC_WRITE(host->base, ISE, 0);
-			OMAP_HSMMC_WRITE(host->base, IE, 0);
-
-
+			omap_hsmmc_disable_irq(host);
 			OMAP_HSMMC_WRITE(host->base, HCTL,
 				OMAP_HSMMC_READ(host->base, HCTL) & ~SDBP);
 			mmc_host_disable(host->mmc);
-- 
1.6.3.3
