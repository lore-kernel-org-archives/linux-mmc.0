From: Ravikumar Kattekola <rk@ti.com>
Subject: [PATCH 3/3] mmc: host: omap_hsmmc: avoid possible overflow of timeout value
Date: Mon, 30 Jan 2017 15:41:58 +0530
Message-ID: <1485771118-13748-4-git-send-email-rk@ti.com>
References: <1485771118-13748-1-git-send-email-rk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485771118-13748-1-git-send-email-rk@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, peter.ujfalusi@ti.com, nsekhar@ti.com, tony@atomide.com, afenkart@gmail.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kishon@ti.com, rk@ti.com
List-Id: linux-mmc@vger.kernel.org

Fixes: a45c6cb81647 ("[ARM] 5369/1: omap mmc: Add new omap
hsmmc controller for 2430 and 34xx, v3")

when using really large timeout (up to 4*60*1000 ms for bkops)
there is a possibility of data overflow using
unsigned int so use 64 bit unsigned long long.

Signed-off-by: Ravikumar Kattekola <rk@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 51ca3d7..a58bd65 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1469,10 +1469,11 @@ static int omap_hsmmc_setup_dma_transfer(struct omap_hsmmc_host *host,
 }
 
 static void set_data_timeout(struct omap_hsmmc_host *host,
-			     unsigned int timeout_ns,
+			     unsigned long long timeout_ns,
 			     unsigned int timeout_clks)
 {
-	unsigned int timeout, cycle_ns;
+	unsigned long long timeout = timeout_ns;
+	unsigned int cycle_ns;
 	uint32_t reg, clkd, dto = 0;
 
 	reg = OMAP_HSMMC_READ(host->base, SYSCTL);
@@ -1481,7 +1482,7 @@ static void set_data_timeout(struct omap_hsmmc_host *host,
 		clkd = 1;
 
 	cycle_ns = 1000000000 / (host->clk_rate / clkd);
-	timeout = timeout_ns / cycle_ns;
+	do_div(timeout, cycle_ns);
 	timeout += timeout_clks;
 	if (timeout) {
 		while ((timeout & 0x80000000) == 0) {
@@ -1527,7 +1528,7 @@ static void omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host)
 omap_hsmmc_prepare_data(struct omap_hsmmc_host *host, struct mmc_request *req)
 {
 	int ret;
-	unsigned int timeout;
+	unsigned long long timeout;
 
 	host->data = req->data;
 
-- 
1.9.1
