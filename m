From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH V2 14/16] mmc: omap_hsmmc: adjust host controller clock in regard to current OPP
Date: Fri,  6 May 2011 12:14:13 +0300
Message-ID: <1304673255-31634-15-git-send-email-adrian.hunter@nokia.com>
References: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:41073 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753766Ab1EFJSR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 6 May 2011 05:18:17 -0400
In-Reply-To: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

We should like to adjust MMC host controller clock whenever the OPP is changed.
OPP affects to L3/L4 bus frequency. Due to this we update the maximum frequency
limits before each upcoming request and when the divisor is calculated.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   65 +++++++++++++++++++++++++++++++++++++----
 1 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index ee57b9b..e1c9017 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -187,6 +187,9 @@ struct omap_hsmmc_host {
 	int			use_reg;
 	int			req_in_progress;
 
+	/* Actual output frequency of host controller */
+	unsigned int		freq;
+
 	struct	omap_mmc_platform_data	*pdata;
 };
 
@@ -592,13 +595,31 @@ static void omap_hsmmc_disable_irq(struct omap_hsmmc_host *host)
 	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
 }
 
+/*
+ * Recalculate desired clock frequency with regard to maximum possible
+ * frequency at current OPP.
+ *
+ * Choose either target frequency (ios->clock) or maximum possible frequency at
+ * current OPP (get_max_freq() returns this limit)
+ */
+static void omap_hsmmc_recalc_freq(struct omap_hsmmc_host *host,
+				   struct mmc_ios *ios)
+{
+	struct omap_mmc_platform_data *pdata = host->pdata;
+
+	if (pdata->get_max_freq)
+		host->freq = min(ios->clock, pdata->get_max_freq(host->dev));
+	else
+		host->freq = ios->clock;
+}
+
 /* Calculate divisor for the given clock frequency */
-static u16 calc_divisor(struct mmc_ios *ios)
+static u16 calc_divisor(struct omap_hsmmc_host *host)
 {
 	u16 dsor = 0;
 
-	if (ios->clock) {
-		dsor = DIV_ROUND_UP(OMAP_MMC_MASTER_CLOCK, ios->clock);
+	if (host->freq) {
+		dsor = DIV_ROUND_UP(OMAP_MMC_MASTER_CLOCK, host->freq);
 		if (dsor > 250)
 			dsor = 250;
 	}
@@ -608,17 +629,16 @@ static u16 calc_divisor(struct mmc_ios *ios)
 
 static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
 {
-	struct mmc_ios *ios = &host->mmc->ios;
 	unsigned long regval;
 	unsigned long timeout;
 
-	dev_dbg(mmc_dev(host->mmc), "Set clock to %uHz\n", ios->clock);
+	dev_dbg(mmc_dev(host->mmc), "Set clock to %uHz\n", host->freq);
 
 	omap_hsmmc_stop_clock(host);
 
 	regval = OMAP_HSMMC_READ(host->base, SYSCTL);
 	regval = regval & ~(CLKD_MASK | DTO_MASK);
-	regval = regval | (calc_divisor(ios) << 6) | (DTO << 16);
+	regval = regval | (calc_divisor(host) << 6) | (DTO << 16);
 	OMAP_HSMMC_WRITE(host->base, SYSCTL, regval);
 	OMAP_HSMMC_WRITE(host->base, SYSCTL,
 		OMAP_HSMMC_READ(host->base, SYSCTL) | ICE);
@@ -742,6 +762,7 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 
 	omap_hsmmc_set_bus_width(host);
 
+	omap_hsmmc_recalc_freq(host, ios);
 	omap_hsmmc_set_clock(host);
 
 	omap_hsmmc_set_bus_mode(host);
@@ -925,6 +946,8 @@ static void omap_hsmmc_request_done(struct omap_hsmmc_host *host, struct mmc_req
 	if (mrq->data && host->use_dma && dma_ch != -1)
 		return;
 	host->mrq = NULL;
+	if (host->pdata->inactive)
+		host->pdata->inactive(host->dev);
 	mmc_request_done(host->mmc, mrq);
 }
 
@@ -984,6 +1007,9 @@ omap_hsmmc_cmd_done(struct omap_hsmmc_host *host, struct mmc_command *cmd)
 	}
 	if ((host->data == NULL && !host->response_busy) || cmd->error)
 		omap_hsmmc_request_done(host, cmd->mrq);
+	else if (host->data == NULL && host->response_busy &&
+		 host->pdata->inactive)
+		host->pdata->inactive(host->dev);
 }
 
 /*
@@ -1404,6 +1430,8 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *cb_data)
 		struct mmc_request *mrq = host->mrq;
 
 		host->mrq = NULL;
+		if (host->pdata->inactive)
+			host->pdata->inactive(host->dev);
 		mmc_request_done(host->mmc, mrq);
 	}
 }
@@ -1533,6 +1561,26 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
 
 	BUG_ON(host->req_in_progress);
 	BUG_ON(host->dma_ch != -1);
+
+	if (host->pdata->active) {
+		unsigned int new_freq;
+
+		/*
+		 * active() returns minimum of two (target, maximum)
+		 * frequencies.
+		 */
+		new_freq = host->pdata->active(host->dev, mmc->ios.clock);
+
+		/*
+		 * We need to update actual frequency if it is not equal to the
+		 * minimum of two (target and maximum) frequencies
+		 */
+		if (host->freq != new_freq) {
+			host->freq = new_freq;
+			omap_hsmmc_set_clock(host);
+		}
+	}
+
 	if (host->protect_card) {
 		if (host->reqs_blocked < 3) {
 			/*
@@ -1548,6 +1596,8 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
 		if (req->data)
 			req->data->error = -EBADF;
 		req->cmd->retries = 0;
+		if (host->pdata->inactive)
+			host->pdata->inactive(host->dev);
 		mmc_request_done(mmc, req);
 		return;
 	} else if (host->reqs_blocked)
@@ -1560,6 +1610,8 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
 		if (req->data)
 			req->data->error = err;
 		host->mrq = NULL;
+		if (host->pdata->inactive)
+			host->pdata->inactive(host->dev);
 		mmc_request_done(mmc, req);
 		return;
 	}
@@ -1616,6 +1668,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 	}
 
+	omap_hsmmc_recalc_freq(host, ios);
 	omap_hsmmc_set_clock(host);
 
 	if (do_send_init_stream)
-- 
1.7.0.4

