From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 08/16] mmc: host: omap_hsmmc: Add software timer when timeout greater than hardware capablility
Date: Fri, 16 Jun 2017 18:15:36 +0530
Message-ID: <20170616124544.15046-9-kishon@ti.com>
References: <20170616124544.15046-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170616124544.15046-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com
Cc: Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kishon@ti.com
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

[rk@ti.com: fix compiler warning in sw timeout function and
use sw timeout for busy timeout]
Signed-off-by: Ravikumar Kattekola <rk@ti.com>
Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
[kishon@ti.com: Fix the timeout value to account for the entire
transfer to complete here.]
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 126 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 109 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index f1d5e8385591..3676ffa72929 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -185,6 +185,11 @@
 #define PSTATE_DLEV		(0xF << 20)
 #define PSTATE_DLEV_DAT0	(0x1 << 20)
 
+#define MMC_BLOCK_TRANSFER_TIME_NS(blksz, bus_width, freq)		\
+				   ((unsigned long long)		\
+				   (2 * (((blksz) * NSEC_PER_SEC *	\
+				   (8 / (bus_width))) / (freq))))
+
 /*
  * One controller can have multiple slots, like on some omap boards using
  * omap.c controller driver. Luckily this is not currently done on any known
@@ -250,6 +255,8 @@ struct omap_hsmmc_host {
 	struct	omap_hsmmc_platform_data	*pdata;
 
 	bool			is_tuning;
+	struct timer_list	timer;
+	unsigned long long	data_timeout;
 
 	/* return MMC cover switch state, can be NULL if not supported.
 	 *
@@ -631,8 +638,8 @@ static void omap_hsmmc_enable_irq(struct omap_hsmmc_host *host,
 	if (host->use_dma)
 		irq_mask &= ~(BRR_EN | BWR_EN);
 
-	/* Disable timeout for erases */
-	if (cmd->opcode == MMC_ERASE)
+	/* Disable timeout for erases or when using software timeout */
+	if (cmd && (cmd->opcode == MMC_ERASE || host->data_timeout))
 		irq_mask &= ~DTO_EN;
 
 	if (host->flags & CLKEXTFREE_ENABLED)
@@ -1239,8 +1246,16 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 	}
 
 	OMAP_HSMMC_WRITE(host->base, STAT, status);
-	if (end_cmd || ((status & CC_EN) && host->cmd))
+	if (end_cmd || ((status & CC_EN) && host->cmd)) {
 		omap_hsmmc_cmd_done(host, host->cmd);
+		if (host->data_timeout) {
+			unsigned long timeout;
+
+			timeout = jiffies +
+				  nsecs_to_jiffies(host->data_timeout);
+			mod_timer(&host->timer, timeout);
+		}
+	}
 	if ((end_trans || (status & TC_EN)) && host->mrq)
 		omap_hsmmc_xfer_done(host, data);
 }
@@ -1254,7 +1269,19 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
 	int status;
 
 	status = OMAP_HSMMC_READ(host->base, STAT);
+
 	while (status & (INT_EN_MASK | CIRQ_EN)) {
+		/*
+		 * During a successful bulk data transfer command-completion
+		 * interrupt and transfer-completion interrupt will be
+		 * generated, but software-timeout timer should be deleted
+		 * only on non-cc interrupts (transfer complete or error)
+		 */
+		if (host->data_timeout && (status & (~CC_EN))) {
+			del_timer(&host->timer);
+			host->data_timeout = 0;
+		}
+
 		if (host->req_in_progress)
 			omap_hsmmc_do_irq(host, status);
 
@@ -1268,6 +1295,25 @@ static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void omap_hsmmc_soft_timeout(unsigned long data)
+{
+	struct omap_hsmmc_host *host = (struct omap_hsmmc_host *)data;
+	bool end_trans = false;
+
+	omap_hsmmc_disable_irq(host);
+	if (host->data || host->response_busy) {
+		host->response_busy = 0;
+		end_trans = true;
+	}
+
+	hsmmc_command_incomplete(host, -ETIMEDOUT, 0);
+	if (end_trans && host->mrq)
+		omap_hsmmc_xfer_done(host, host->data);
+	else if (host->cmd)
+		omap_hsmmc_cmd_done(host, host->cmd);
+	host->data_timeout = 0;
+}
+
 static void set_sd_bus_power(struct omap_hsmmc_host *host)
 {
 	unsigned long i;
@@ -1462,6 +1508,9 @@ static void set_data_timeout(struct omap_hsmmc_host *host,
 	unsigned long long timeout = timeout_ns;
 	unsigned int cycle_ns;
 	uint32_t reg, clkd, dto = 0;
+	struct mmc_ios *ios = &host->mmc->ios;
+	struct mmc_data *data = host->mrq->data;
+	struct mmc_command *cmd = host->mrq->cmd;
 
 	reg = OMAP_HSMMC_READ(host->base, SYSCTL);
 	clkd = (reg & CLKD_MASK) >> CLKD_SHIFT;
@@ -1471,23 +1520,60 @@ static void set_data_timeout(struct omap_hsmmc_host *host,
 	cycle_ns = 1000000000 / (host->clk_rate / clkd);
 	do_div(timeout, cycle_ns);
 	timeout += timeout_clks;
-	if (timeout) {
-		while ((timeout & 0x80000000) == 0) {
-			dto += 1;
-			timeout <<= 1;
-		}
-		dto = 31 - dto;
+
+	if (!timeout)
+		goto out;
+
+	while ((timeout & 0x80000000) == 0) {
+		dto += 1;
 		timeout <<= 1;
-		if (timeout && dto)
-			dto += 1;
-		if (dto >= 13)
-			dto -= 13;
-		else
-			dto = 0;
-		if (dto > 14)
-			dto = 14;
+	}
+	dto = 31 - dto;
+	timeout <<= 1;
+	if (timeout && dto)
+		dto += 1;
+	if (dto >= 13)
+		dto -= 13;
+	else
+		dto = 0;
+	if (dto > 14) {
+		/*
+		 * DRA7 Errata No i834: When using high speed HS200 and
+		 * SDR104 cards, the functional clock for MMC module
+		 * will be 192MHz. At this frequency, the maximum
+		 * obtainable timeout (DTO =0xE) in hardware is
+		 * (1/192MHz)*2^27 = 700ms. Commands taking longer than
+		 * 700ms will be affected by this small window frame
+		 * and will be timing out frequently even without a
+		 * genuine timeout from the card. Workaround for
+		 * this errata is use a software timer instead of
+		 * hardware timer to provide the timeout requested
+		 * by the upper layer.
+		 *
+		 * The timeout from the upper layer denotes the delay
+		 * between the end bit of the read command and the
+		 * start bit of the data block and in the case of
+		 * multiple-read operation, they also define the
+		 * typical delay between the end bit of a data
+		 * block and the start bit of next data block.
+		 *
+		 * Calculate the total timeout value for the entire
+		 * transfer to complete from the timeout value given
+		 * by the upper layer.
+		 */
+		if (data)
+			host->data_timeout = (data->blocks *
+					      (timeout_ns +
+					      MMC_BLOCK_TRANSFER_TIME_NS(
+					      data->blksz, ios->bus_width,
+					      ios->clock)));
+		else if (cmd->flags & MMC_RSP_BUSY)
+			host->data_timeout = timeout_ns;
+
+		dto = 14;
 	}
 
+out:
 	reg &= ~DTO_MASK;
 	reg |= dto << DTO_SHIFT;
 	OMAP_HSMMC_WRITE(host->base, SYSCTL, reg);
@@ -2347,6 +2433,8 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	mmc->ops	= &omap_hsmmc_ops;
 
 	spin_lock_init(&host->irq_lock);
+	setup_timer(&host->timer, omap_hsmmc_soft_timeout,
+		    (unsigned long)host);
 
 	host->fclk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(host->fclk)) {
@@ -2511,6 +2599,8 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
 	dma_release_channel(host->tx_chan);
 	dma_release_channel(host->rx_chan);
 
+	del_timer_sync(&host->timer);
+
 	pm_runtime_dont_use_autosuspend(host->dev);
 	pm_runtime_put_sync(host->dev);
 	pm_runtime_disable(host->dev);
@@ -2544,6 +2634,8 @@ static int omap_hsmmc_suspend(struct device *dev)
 	if (host->dbclk)
 		clk_disable_unprepare(host->dbclk);
 
+	del_timer_sync(&host->timer);
+
 	pm_runtime_put_sync(host->dev);
 	return 0;
 }
-- 
2.11.0
