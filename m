From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 11/11] mmc: tmio: cosmetic: prettify the tmio_mmc_set_ios() function
Date: Tue, 24 Jan 2012 13:01:40 +0100
Message-ID: <1327406500-7233-12-git-send-email-g.liakhovetski@gmx.de>
References: <1327406500-7233-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:64572 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247Ab2AXMBv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jan 2012 07:01:51 -0500
In-Reply-To: <1327406500-7233-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc_pio.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 64f6c99..08f3e67 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -756,6 +756,7 @@ fail:
 static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
+	struct device *dev = &host->pdev->dev;
 	unsigned long flags;
 
 	mutex_lock(&host->ios_lock);
@@ -763,13 +764,13 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
@@ -792,7 +793,7 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	 */
 	if (ios->power_mode == MMC_POWER_ON && ios->clock) {
 		if (!host->power) {
-			pm_runtime_get_sync(&host->pdev->dev);
+			pm_runtime_get_sync(dev);
 			host->power = true;
 		}
 		tmio_mmc_set_clock(host, ios->clock);
@@ -806,7 +807,7 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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

