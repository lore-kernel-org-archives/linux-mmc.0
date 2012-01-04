From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 11/11] mmc: tmio: cosmetic: prettify the tmio_mmc_set_ios() function
Date: Wed,  4 Jan 2012 15:17:16 +0100
Message-ID: <1325686636-23905-12-git-send-email-g.liakhovetski@gmx.de>
References: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc_pio.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 9106b3d..f68e6f3 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -752,6 +752,7 @@ fail:
 static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct device *dev = &host->pdev->dev;
 	unsigned long flags;
 
 	mutex_lock(&host->ios_lock);
@@ -759,13 +760,13 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	spin_lock_irqsave(&host->lock, flags);
 	if (host->mrq) {
 		if (IS_ERR(host->mrq)) {
-			dev_dbg(&host->pdev->dev,
+			dev_dbg(dev,
 				"%s.%d: concurrent .set_ios(), clk %u, mode %u\n",
 				current->comm, task_pid_nr(current),
 				ios->clock, ios->power_mode);
 			host->mrq = ERR_PTR(-EINTR);
 		} else {
-			dev_dbg(&host->pdev->dev,
+			dev_dbg(dev,
 				"%s.%d: CMD%u active since %lu, now %lu!\n",
 				current->comm, task_pid_nr(current),
 				host->mrq->cmd->opcode, host->last_req_ts, jiffies);
@@ -788,7 +789,7 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	 */
 	if (ios->power_mode == MMC_POWER_ON && ios->clock) {
 		if (!host->power) {
-			pm_runtime_get_sync(&host->pdev->dev);
+			pm_runtime_get_sync(dev);
 			host->power = true;
 		}
 		tmio_mmc_set_clock(host, ios->clock);
@@ -802,7 +803,7 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			host->set_pwr(host->pdev, 0);
 		if (host->power) {
 			host->power = false;
-			pm_runtime_put(&host->pdev->dev);
+			pm_runtime_put(dev);
 		}
 		tmio_mmc_clk_stop(host);
 	}
-- 
1.7.2.5

