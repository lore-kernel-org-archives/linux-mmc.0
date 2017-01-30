From: Ravikumar Kattekola <rk@ti.com>
Subject: [PATCH 1/3] mmc: host: omap_hsmmc: reset cmd line on ceb error
Date: Mon, 30 Jan 2017 15:41:56 +0530
Message-ID: <1485771118-13748-2-git-send-email-rk@ti.com>
References: <1485771118-13748-1-git-send-email-rk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485771118-13748-1-git-send-email-rk@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, peter.ujfalusi@ti.com, nsekhar@ti.com, tony@atomide.com, afenkart@gmail.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kishon@ti.com, rk@ti.com
List-Id: linux-mmc@vger.kernel.org

When CEB (command end bit error) occurs
reset CMD line to avoid system ending up in
erroneous state.
While command line is reset for CTO and CCRC errors,
it's not done for CEB error. Fix it here.

Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Ravikumar Kattekola <rk@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index ad11c4c..0ee5650 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1162,7 +1162,7 @@ static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int status)
 	if (status & ERR_EN) {
 		omap_hsmmc_dbg_report_irq(host, status);
 
-		if (status & (CTO_EN | CCRC_EN))
+		if (status & (CTO_EN | CCRC_EN | CEB_EN))
 			end_cmd = 1;
 		if (host->data || host->response_busy) {
 			end_trans = !end_cmd;
-- 
1.9.1
