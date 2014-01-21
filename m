From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 1/5] mmc: omap_hsmmc: save clock rate to use in interrupt context
Date: Tue, 21 Jan 2014 19:54:38 +0530
Message-ID: <1390314282-20520-2-git-send-email-balajitk@ti.com>
References: <1390314282-20520-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1390314282-20520-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

clk_get_rate throws DEBUG_LOCKS_WARN_ON(in_interrupt()) warning
if called from interrupt context.
use cached clock rate in set_data_timeout, so that
set_data_timeout can be called from interrupt context.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index dbd32ad..8d0048d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -188,6 +188,7 @@ struct omap_hsmmc_host {
 	int			reqs_blocked;
 	int			use_reg;
 	int			req_in_progress;
+	unsigned long		clk_rate;
 	struct omap_hsmmc_next	next_data;
 	struct	omap_mmc_platform_data	*pdata;
 };
@@ -1338,7 +1339,7 @@ static void set_data_timeout(struct omap_hsmmc_host *host,
 	if (clkd == 0)
 		clkd = 1;
 
-	cycle_ns = 1000000000 / (clk_get_rate(host->fclk) / clkd);
+	cycle_ns = 1000000000 / (host->clk_rate / clkd);
 	timeout = timeout_ns / cycle_ns;
 	timeout += timeout_clks;
 	if (timeout) {
@@ -1462,6 +1463,7 @@ static void omap_hsmmc_request(struct mmc_host *mmc, struct mmc_request *req)
 		host->reqs_blocked = 0;
 	WARN_ON(host->mrq != NULL);
 	host->mrq = req;
+	host->clk_rate = clk_get_rate(host->fclk);
 	err = omap_hsmmc_prepare_data(host, req);
 	if (err) {
 		req->cmd->error = err;
-- 
1.7.5.4

