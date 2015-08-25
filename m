From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 11/11] mmc: host: omap_hsmmc: add software timer when timeout greater than hardware capablility
Date: Tue, 25 Aug 2015 14:35:42 +0530
Message-ID: <1440493542-26150-12-git-send-email-kishon@ti.com>
References: <1440493542-26150-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440493542-26150-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
Cc: neilb@suse.de, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

From: Mugunthan V N <mugunthanvnm@ti.com>

DRA7 Errata No i834: When using high speed HS200 and SDR104
cards, the functional clock for MMC module will be 192MHz.
At this frequency, the maximum obtainable timeout (DTO =0xE)
in hardware is (1/192MHz)*2^27 = 700ms. Commands taking longer
than 700ms will be affected by this small window frame and
will be timing out frequently even without a genune timeout
from the card. Workarround for this errata is use a software
timer instead of hardware timer to provide the delay requested
by the upper layer

So adding a software timer as a work around for the errata.
Instead of using software timeout only for larger delays requested
when using HS200/SDR104 cards which results in hardware and
software timer race conditions, so move all the timeout request
to use software timer when HS200/SDR104 card is connected and
use hardware timer when other type cards are connected.

Also start the software timer after queueing to DMA to ensure
we are more likely to expire within correct limits. To be ever
more sure that we won't expire this soft timer too early, we're
adding a 1000000ns slack to the data timeout requested by the
upper layer.

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   71 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index bc59822..ec80de9 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -168,6 +168,7 @@
 #define ACNE	(1 << 0)
 
 #define MMC_AUTOSUSPEND_DELAY	100
+#define MMC_SOFT_TIMER_SLACK	1000000		/* ns */
 #define MMC_TIMEOUT_MS		20		/* 20 mSec */
 #define MMC_TIMEOUT_US		20000		/* 20000 micro Sec */
 #define OMAP_MMC_MIN_CLOCK	400000
@@ -246,6 +247,10 @@ struct omap_hsmmc_host {
 	struct omap_hsmmc_next	next_data;
 	struct	omap_hsmmc_platform_data	*pdata;
 
+	struct timer_list	timer;
+	unsigned long		data_timeout;
+	unsigned int		need_i834_errata:1;
+
 	u32			*tuning_data;
 	int			tuning_size;
 
@@ -670,8 +675,8 @@ static void omap_hsmmc_enable_irq(struct omap_hsmmc_host *host,
 		irq_mask &= ~(BRR_EN | BWR_EN);
 	}
 
-	/* Disable timeout for erases */
-	if (cmd->opcode == MMC_ERASE)
+	/* Disable timeout for erases or when using software timeout */
+	if (cmd->opcode == MMC_ERASE || host->need_i834_errata)
 		irq_mask &= ~DTO_EN;
 
 	spin_lock_irqsave(&host->irq_lock, flags);
@@ -761,6 +766,22 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
 		OMAP_HSMMC_WRITE(host->base, HCTL, regval);
 	}
 
+	/*
+	 * DRA7 Errata No i834: When using high speed HS200 and SDR104
+	 * cards, the functional clock for MMC module will be 192MHz.
+	 * At this frequency, the maximum obtainable timeout (DTO =0xE)
+	 * in hardware is (1/192MHz)*2^27 = 700ms. Commands taking longer
+	 * than 700ms will be affected by this small window frame and
+	 * will be timing out frequently even without a genune timeout
+	 * from the card. Workarround for this errata is use a software
+	 * timer instead of hardware timer to provide the delay requested
+	 * by the upper layer
+	 */
+	if (ios->clock == 192000000)
+		host->need_i834_errata = true;
+	else
+		host->need_i834_errata = false;
+
 	omap_hsmmc_start_clock(host);
 }
 
@@ -1307,6 +1328,16 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
 	int status;
 
 	status = OMAP_HSMMC_READ(host->base, STAT);
+
+	/*
+	 * During a successful bulk data transfer command-completion
+	 * interrupt and transfer-completion interrupt will be generated,
+	 * but software-timeout timer should be deleted only on non-CC
+	 * interrupts (transfer complete or error)
+	 */
+	if (host->need_i834_errata && (status & (~CC_EN)))
+		del_timer(&host->timer);
+
 	while (status & (INT_EN_MASK | CIRQ_EN)) {
 		if (host->req_in_progress)
 			omap_hsmmc_do_irq(host, status);
@@ -1321,6 +1352,13 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void omap_hsmmc_soft_timeout(unsigned long data)
+{
+	struct omap_hsmmc_host *host = (struct omap_hsmmc_host *)data;
+
+	hsmmc_command_incomplete(host, -ETIMEDOUT, 0);
+}
+
 static void set_sd_bus_power(struct omap_hsmmc_host *host)
 {
 	unsigned long i;
@@ -1522,6 +1560,22 @@ static void set_data_timeout(struct omap_hsmmc_host *host,
 	if (clkd == 0)
 		clkd = 1;
 
+	if (host->need_i834_errata) {
+		unsigned long delta;
+
+		delta = (timeout_clks / (host->clk_rate / clkd));
+
+		/*
+		 * We should really be using just timeout_ns + delta,
+		 * however we have no control over when DMA will
+		 * actually start transferring; due to that we will add
+		 * an extra slack to make sure we don't expire too
+		 * early.
+		 */
+		host->data_timeout = timeout_ns + delta + MMC_SOFT_TIMER_SLACK;
+		return;
+	}
+
 	cycle_ns = 1000000000 / (host->clk_rate / clkd);
 	timeout = timeout_ns / cycle_ns;
 	timeout += timeout_clks;
@@ -1560,6 +1614,13 @@ static void omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host)
 				req->data->timeout_clks);
 	chan = omap_hsmmc_get_dma_chan(host, req->data);
 	dma_async_issue_pending(chan);
+
+	if (host->need_i834_errata) {
+		unsigned long timeout;
+
+		timeout = jiffies + nsecs_to_jiffies(host->data_timeout);
+		mod_timer(&host->timer, timeout);
+	}
 }
 
 /*
@@ -2426,6 +2487,8 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	spin_lock_init(&host->irq_lock);
 	init_completion(&host->buf_ready);
+	setup_timer(&host->timer, omap_hsmmc_soft_timeout,
+		    (unsigned long)host);
 
 	host->fclk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(host->fclk)) {
@@ -2624,6 +2687,8 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 	if (host->rx_chan)
 		dma_release_channel(host->rx_chan);
 
+	del_timer_sync(&host->timer);
+
 	pm_runtime_put_sync(host->dev);
 	pm_runtime_disable(host->dev);
 	device_init_wakeup(&pdev->dev, false);
@@ -2656,6 +2721,8 @@ static int omap_hsmmc_suspend(struct device *dev)
 	if (host->dbclk)
 		clk_disable_unprepare(host->dbclk);
 
+	del_timer_sync(&host->timer);
+
 	pm_runtime_put_sync(host->dev);
 	return 0;
 }
-- 
1.7.9.5
