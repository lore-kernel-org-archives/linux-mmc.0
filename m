From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH] Use u64 to calculate the timeout value to avoid overflow
Date: Mon, 26 Nov 2012 16:35:59 +0800
Message-ID: <1353918959-12146-2-git-send-email-Haijun.Zhang@freescale.com>
References: <1353918959-12146-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe002.messaging.microsoft.com ([207.46.163.25]:37287
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754058Ab2KZI4R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Nov 2012 03:56:17 -0500
In-Reply-To: <1353918959-12146-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Haijun Zhang <Haijun.Zhang@freescale.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Chris Ball <cjb@laptop.org>

As data timeout_ns use u64 to avoid overflow.
So we use macro div_u64 to perform a division.
Below C file modified:
 - drivers/mmc/host/atmel-mci.c
 - drivers/mmc/host/bfin_sdh.c
 - drivers/mmc/host/davinci_mmc.c
 - drivers/mmc/host/mmci.c
 - drivers/mmc/host/mvsdio.c
 - drivers/mmc/host/mxs-mmc.c
 - drivers/mmc/host/omap.c
 - drivers/mmc/host/tifm_sd.c
 - drivers/mmc/host/wbsd.c

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
CC: Anton Vorontsov <cbouatmailru@gmail.com>
CC: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/atmel-mci.c   |    7 +++----
 drivers/mmc/host/bfin_sdh.c    |    2 +-
 drivers/mmc/host/davinci_mmc.c |    4 ++--
 drivers/mmc/host/mmci.c        |    2 +-
 drivers/mmc/host/mvsdio.c      |    2 +-
 drivers/mmc/host/mxs-mmc.c     |    4 ++--
 drivers/mmc/host/omap.c        |    2 +-
 drivers/mmc/host/tifm_sd.c     |    4 ++--
 drivers/mmc/host/wbsd.c        |    2 +-
 9 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index ddf096e..0f74d37 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -593,17 +593,16 @@ static void atmci_timeout_timer(unsigned long data)
 	tasklet_schedule(&host->tasklet);
 }
 
-static inline unsigned int atmci_ns_to_clocks(struct atmel_mci *host,
-					unsigned int ns)
+static inline unsigned int atmci_ns_to_clocks(struct atmel_mci *host, u64 ns)
 {
 	/*
 	 * It is easier here to use us instead of ns for the timeout,
 	 * it prevents from overflows during calculation.
 	 */
-	unsigned int us = DIV_ROUND_UP(ns, 1000);
+	u64 us = DIV_ROUND_UP_ULL(ns, 1000);
 
 	/* Maximum clock frequency is host->bus_hz/2 */
-	return us * (DIV_ROUND_UP(host->bus_hz, 2000000));
+	return (u32)(us * (DIV_ROUND_UP_ULL(host->bus_hz, 2000000)));
 }
 
 static void atmci_set_timeout(struct atmel_mci *host,
diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
index b9b463e..88e0abb 100644
--- a/drivers/mmc/host/bfin_sdh.c
+++ b/drivers/mmc/host/bfin_sdh.c
@@ -143,7 +143,7 @@ static int sdh_setup_data(struct sdh_host *host, struct mmc_data *data)
 	bfin_write_SDH_DATA_CTL(data_ctl);
 	/* the time of a host clock period in ns */
 	cycle_ns = 1000000000 / (host->sclk / (2 * (host->clk_div + 1)));
-	timeout = data->timeout_ns / cycle_ns;
+	timeout = div_u64(data->timeout_ns, cycle_ns);
 	timeout += data->timeout_clks;
 	bfin_write_SDH_DATA_TIMER(timeout);
 	SSYNC();
diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 2063677..a48b475 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -568,10 +568,10 @@ mmc_davinci_prepare_data(struct mmc_davinci_host *host, struct mmc_request *req)
 		(data->flags & MMC_DATA_STREAM) ? "stream" : "block",
 		(data->flags & MMC_DATA_WRITE) ? "write" : "read",
 		data->blocks, data->blksz);
-	dev_dbg(mmc_dev(host->mmc), "  DTO %d cycles + %d ns\n",
+	dev_dbg(mmc_dev(host->mmc), "  DTO %d cycles + %lld ns\n",
 		data->timeout_clks, data->timeout_ns);
 	timeout = data->timeout_clks +
-		(data->timeout_ns / host->ns_in_one_cycle);
+		div_u64(data->timeout_ns, host->ns_in_one_cycle);
 	if (timeout > 0xffff)
 		timeout = 0xffff;
 
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index edc3e9b..09fe317 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -632,7 +632,7 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	host->size = data->blksz * data->blocks;
 	data->bytes_xfered = 0;
 
-	clks = (unsigned long long)data->timeout_ns * host->cclk;
+	clks = data->timeout_ns * host->cclk;
 	do_div(clks, 1000000000UL);
 
 	timeout = data->timeout_clks + (unsigned int)clks;
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index de4c20b..3badc4f 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -92,7 +92,7 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
 	}
 
 	/* If timeout=0 then maximum timeout index is used. */
-	tmout = DIV_ROUND_UP(data->timeout_ns, host->ns_per_clk);
+	tmout = DIV_ROUND_UP_ULL(data->timeout_ns, host->ns_per_clk);
 	tmout += data->timeout_clks;
 	tmout_index = fls(tmout - 1) - 12;
 	if (tmout_index < 0)
diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 206fe49..9f3617b 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -331,7 +331,7 @@ out:
 		 "%s: failed to prep dma\n", __func__);
 }
 
-static unsigned short mxs_ns_to_ssp_ticks(unsigned clock_rate, unsigned ns)
+static unsigned short mxs_ns_to_ssp_ticks(unsigned clock_rate, u64 ns)
 {
 	const unsigned int ssp_timeout_mul = 4096;
 	/*
@@ -339,7 +339,7 @@ static unsigned short mxs_ns_to_ssp_ticks(unsigned clock_rate, unsigned ns)
 	 * and might overflow
 	 */
 	const unsigned int clock_per_ms = clock_rate / 1000;
-	const unsigned int ms = ns / 1000;
+	const unsigned int ms = div_u64(ns, 1000);
 	const unsigned int ticks = ms * clock_per_ms;
 	const unsigned int ssp_ticks = ticks / ssp_timeout_mul;
 
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 48ad361..daf0636 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -921,7 +921,7 @@ static inline void set_data_timeout(struct mmc_omap_host *host, struct mmc_reque
 	u16 reg;
 
 	cycle_ns = 1000000000 / host->current_slot->fclk_freq;
-	timeout = req->data->timeout_ns / cycle_ns;
+	timeout = div_u64(req->data->timeout_ns, cycle_ns);
 	timeout += req->data->timeout_clks;
 
 	/* Check if we need to use timeout multiplier register */
diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
index 43d9628..4552d2b 100644
--- a/drivers/mmc/host/tifm_sd.c
+++ b/drivers/mmc/host/tifm_sd.c
@@ -599,8 +599,8 @@ static void tifm_sd_set_data_timeout(struct tifm_sd *host,
 	if (fixed_timeout)
 		return;
 
-	data_timeout += data->timeout_ns /
-			((1000000000UL / host->clk_freq) * host->clk_div);
+	data_timeout += div_u64(data->timeout_ns,
+			((1000000000UL / host->clk_freq) * host->clk_div));
 
 	if (data_timeout < 0xffff) {
 		writel(data_timeout, sock->addr + SOCK_MMCSD_DATA_TO);
diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
index 64acd9c..dc31295 100644
--- a/drivers/mmc/host/wbsd.c
+++ b/drivers/mmc/host/wbsd.c
@@ -558,7 +558,7 @@ static void wbsd_prepare_data(struct wbsd_host *host, struct mmc_data *data)
 		wbsd_write_index(host, WBSD_IDX_TAAC, 127);
 	else {
 		wbsd_write_index(host, WBSD_IDX_TAAC,
-			data->timeout_ns / 1000000);
+			div_u64(data->timeout_ns, 1000000));
 	}
 
 	if (data->timeout_clks > 255)
-- 
1.7.0.4


