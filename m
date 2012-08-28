From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCHv2 1/2] mmc: omap_hsmmc: convert from IP timer to hrtimer
Date: Tue, 28 Aug 2012 18:49:06 +0530
Message-ID: <1346159947-3194-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36920 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752860Ab2H1NT2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 28 Aug 2012 09:19:28 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: cjb@laptop.org, balbi@ti.com, Venkatraman S <svenkatr@ti.com>

omap hsmmc controller IP has a built in timer that can be programmed to
guard against unresponsive operations. But its range is very narrow,
and the maximum countable time is a few seconds.

Card maintenance operations like BKOPS and MMC_ERASE and long
stream writes like packed command require timers of order of
several minutes, much beyond the capability of the IP timer.
So get rid of using the IP timer entirely and use kernel's hrtimer
functionality for guarding the device operations.
As part of this change, a workaround that disabled timeouts for
MMC_ERASE command is removed, and the arbitary timing of 100ms
is used only when the timeout is not explicitly specified by core.

A trivial change to get rid of unnecessary dealiasing of host->data
in omap_hsmmc_do_irq is also included.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---

v1->v2:
   Fix typos in commit message.
   Add checks to handle subtle races between MMC IRQ and HRTIMER IRQ
   Mark set_guard_timer function as static
   (Felipe's comment to use macros for INT_EN_MASK is done as a separate patch )
 drivers/mmc/host/omap_hsmmc.c | 96 ++++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 46 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 9afdd20..57e86a4 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -79,7 +79,7 @@
 #define CLKD_SHIFT		6
 #define DTO_MASK		0x000F0000
 #define DTO_SHIFT		16
-#define INT_EN_MASK		0x307F0033
+#define INT_EN_MASK		0x306E0033
 #define BWR_ENABLE		(1 << 4)
 #define BRR_ENABLE		(1 << 5)
 #define DTO_ENABLE		(1 << 20)
@@ -160,6 +160,7 @@ struct omap_hsmmc_host {
 	unsigned int		dma_sg_idx;
 	unsigned char		bus_mode;
 	unsigned char		power_mode;
+	unsigned int		ns_per_clk_cycle;
 	int			suspended;
 	int			irq;
 	int			use_dma, dma_ch;
@@ -172,6 +173,7 @@ struct omap_hsmmc_host {
 	int			reqs_blocked;
 	int			use_reg;
 	int			req_in_progress;
+	struct hrtimer	guard_timer;
 	struct omap_hsmmc_next	next_data;
 
 	struct	omap_mmc_platform_data	*pdata;
@@ -455,10 +457,6 @@ static void omap_hsmmc_enable_irq(struct omap_hsmmc_host *host,
 	else
 		irq_mask = INT_EN_MASK;
 
-	/* Disable timeout for erases */
-	if (cmd->opcode == MMC_ERASE)
-		irq_mask &= ~DTO_ENABLE;
-
 	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
 	OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
 	OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
@@ -508,6 +506,9 @@ static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
 		&& time_before(jiffies, timeout))
 		cpu_relax();
 
+	if (ios->clock)
+		host->ns_per_clk_cycle = DIV_ROUND_UP(NSEC_PER_SEC, ios->clock);
+
 	omap_hsmmc_start_clock(host);
 }
 
@@ -824,7 +825,7 @@ omap_hsmmc_xfer_done(struct omap_hsmmc_host *host, struct mmc_data *data)
 		omap_hsmmc_request_done(host, mrq);
 		return;
 	}
-
+	hrtimer_cancel(&host->guard_timer);
 	host->data = NULL;
 
 	if (!data->error)
@@ -859,8 +860,11 @@ omap_hsmmc_cmd_done(struct omap_hsmmc_host *host, struct mmc_command *cmd)
 			cmd->resp[0] = OMAP_HSMMC_READ(host->base, RSP10);
 		}
 	}
-	if ((host->data == NULL && !host->response_busy) || cmd->error)
+	if ((host->data == NULL && !host->response_busy) || cmd->error) {
+		if (cmd->error != -ETIMEDOUT)
+			hrtimer_cancel(&host->guard_timer);
 		omap_hsmmc_request_done(host, cmd->mrq);
+	}
 }
 
 /*
@@ -992,7 +996,7 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 			hsmmc_command_incomplete(host, -EILSEQ);
 
 		end_cmd = 1;
-		if (host->data || host->response_busy) {
+		if (data || host->response_busy) {
 			end_trans = 1;
 			host->response_busy = 0;
 		}
@@ -1292,41 +1296,35 @@ static int omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host,
 	return 0;
 }
 
-static void set_data_timeout(struct omap_hsmmc_host *host,
-			     unsigned int timeout_ns,
-			     unsigned int timeout_clks)
+static void set_guard_timer(struct omap_hsmmc_host *host,
+		unsigned long timeout_ms, unsigned long timeout_ns,
+		unsigned int timeout_clks)
 {
-	unsigned int timeout, cycle_ns;
-	uint32_t reg, clkd, dto = 0;
+	ktime_t gtime;
+	unsigned int sec, nsec;
 
-	reg = OMAP_HSMMC_READ(host->base, SYSCTL);
-	clkd = (reg & CLKD_MASK) >> CLKD_SHIFT;
-	if (clkd == 0)
-		clkd = 1;
+	sec = timeout_ms / MSEC_PER_SEC;
+	nsec = (timeout_ms % MSEC_PER_SEC) * NSEC_PER_MSEC + timeout_ns;
 
-	cycle_ns = 1000000000 / (clk_get_rate(host->fclk) / clkd);
-	timeout = timeout_ns / cycle_ns;
-	timeout += timeout_clks;
-	if (timeout) {
-		while ((timeout & 0x80000000) == 0) {
-			dto += 1;
-			timeout <<= 1;
-		}
-		dto = 31 - dto;
-		timeout <<= 1;
-		if (timeout && dto)
-			dto += 1;
-		if (dto >= 13)
-			dto -= 13;
-		else
-			dto = 0;
-		if (dto > 14)
-			dto = 14;
-	}
+	nsec += timeout_clks * host->ns_per_clk_cycle;
+	gtime = ktime_set(sec, nsec);
 
-	reg &= ~DTO_MASK;
-	reg |= dto << DTO_SHIFT;
-	OMAP_HSMMC_WRITE(host->base, SYSCTL, reg);
+	hrtimer_start(&host->guard_timer, gtime, HRTIMER_MODE_REL);
+}
+
+static enum hrtimer_restart omap_hsmmc_timedout(struct hrtimer *gtimer)
+{
+	struct omap_hsmmc_host *host;
+	host = container_of(gtimer, struct omap_hsmmc_host, guard_timer);
+	if (host->req_in_progress) {
+		omap_hsmmc_disable_irq(host);
+		hsmmc_command_incomplete(host, -ETIMEDOUT);
+		host->response_busy = 0;
+		omap_hsmmc_cmd_done(host, host->cmd);
+		if (host->data)
+			omap_hsmmc_xfer_done(host, host->data);
+	}
+	return HRTIMER_NORESTART;
 }
 
 /*
@@ -1340,18 +1338,22 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host *host, struct mmc_request *req)
 
 	if (req->data == NULL) {
 		OMAP_HSMMC_WRITE(host->base, BLK, 0);
-		/*
-		 * Set an arbitrary 100ms data timeout for commands with
-		 * busy signal.
-		 */
-		if (req->cmd->flags & MMC_RSP_BUSY)
-			set_data_timeout(host, 100000000U, 0);
+		if (req->cmd->cmd_timeout_ms == 0) {
+			/*
+			 * Set an arbitrary 100ms data timeout for commands with
+			 * busy signal.
+			 */
+			set_guard_timer(host, 100, 0, 0);
+		} else {
+			set_guard_timer(host, req->cmd->cmd_timeout_ms, 0, 0);
+		}
 		return 0;
 	}
 
 	OMAP_HSMMC_WRITE(host->base, BLK, (req->data->blksz)
 					| (req->data->blocks << 16));
-	set_data_timeout(host, req->data->timeout_ns, req->data->timeout_clks);
+	set_guard_timer(host, 0, req->data->timeout_ns,
+			req->data->timeout_clks);
 
 	if (host->use_dma) {
 		ret = omap_hsmmc_start_dma_transfer(host, req);
@@ -1921,6 +1923,8 @@ static int __devinit omap_hsmmc_probe(struct platform_device *pdev)
 		pdata->suspend = omap_hsmmc_suspend_cdirq;
 		pdata->resume = omap_hsmmc_resume_cdirq;
 	}
+	hrtimer_init(&host->guard_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	host->guard_timer.function = omap_hsmmc_timedout;
 
 	omap_hsmmc_disable_irq(host);
 
-- 
1.7.11.1.25.g0e18bef

