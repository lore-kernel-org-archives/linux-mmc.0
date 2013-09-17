From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH V2] mmc:core: Avoid useless detecting task when card is busy
Date: Tue, 17 Sep 2013 17:03:32 +0800
Message-ID: <1379408612-5098-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0188.outbound.messaging.microsoft.com ([213.199.154.188]:48259
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751584Ab3IQJIN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Sep 2013 05:08:13 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, X.Xie@freescale.com, ulf.hansson@linaro.org, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

When card is in cpu polling mode to detect card present. Card detecting
task will be scheduled about once every second. When card is busy in large
file transfer, detecting task will be hang and call trace will be prompt.
When handling the request, CMD13 is always followed by every command when
it was complete. So assume that card is present to avoid this duplicate
detecting. Only polling card when card is free to reduce conflict with
data transfer.

<7>mmc0: req done (CMD13): 0: 00000e00 00000000 00000000 00000000
INFO: task kworker/u:1:12 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/u:1     D 00000000     0    12      2 0x00000000
Call Trace:
[ee06dd50] [44042028] 0x44042028
(unreliable)
[ee06de10] [c0007a0c] __switch_to+0xa0/0xf0
[ee06de30] [c04dd50c] __schedule+0x1f8/0x4a4

[ee06dea0] [c04dd898] schedule+0x30/0xbc

[ee06deb0] [c03816a4] __mmc_claim_host+0x98/0x19c

[ee06df00] [c0385f88] mmc_sd_detect+0x38/0xc0

[ee06df10] [c0382b0c] mmc_rescan+0x294/0x2e0
[ee06df40] [c00661cc] process_one_work+0x140/0x3e0

[ee06df70] [c0066bf8] worker_thread+0x18c/0x36c
[ee06dfb0] [c006bf10] kthread+0x7c/0x80

[ee06dff0] [c000de58] kernel_thread+0x4c/0x68
<7>sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000001

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
---
changes for V2:
	- Add card detecting once the last request is done.

 drivers/mmc/card/block.c | 28 ++++++++++++++++++++++++++--
 drivers/mmc/core/core.c  |  5 +++++
 drivers/mmc/core/mmc.c   |  3 ++-
 drivers/mmc/core/sd.c    |  3 ++-
 drivers/mmc/core/sdio.c  |  3 ++-
 5 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 1a3163f..f280320 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1960,9 +1960,20 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 	struct mmc_host *host = card->host;
 	unsigned long flags;
 
-	if (req && !mq->mqrq_prev->req)
+	if (req && !mq->mqrq_prev->req) {
+		/*
+		 * When we are here, card polling task will be blocked.
+		 * So disable it to void this useless schedule.
+		 */
+		if (host->caps & MMC_CAP_NEEDS_POLL) {
+			spin_lock_irqsave(&host->lock, flags);
+			host->rescan_disable = 1;
+			spin_unlock_irqrestore(&host->lock, flags);
+		}
+
 		/* claim host only for the first request */
 		mmc_get_card(card);
+	}
 
 	ret = mmc_blk_part_switch(card, md);
 	if (ret) {
@@ -1999,7 +2010,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 
 out:
 	if ((!req && !(mq->flags & MMC_QUEUE_NEW_REQUEST)) ||
-	     (req && (req->cmd_flags & MMC_REQ_SPECIAL_MASK)))
+	     (req && (req->cmd_flags & MMC_REQ_SPECIAL_MASK))) {
 		/*
 		 * Release host when there are no more requests
 		 * and after special request(discard, flush) is done.
@@ -2007,6 +2018,19 @@ out:
 		 * the 'mmc_blk_issue_rq' with 'mqrq_prev->req'.
 		 */
 		mmc_put_card(card);
+
+		/*
+		 * Detecting card status immediately in case card being
+		 * removed just after the request is complete.
+		 */
+		if (host->caps & MMC_CAP_NEEDS_POLL) {
+			spin_lock_irqsave(&host->lock, flags);
+			host->rescan_disable = 0;
+			spin_unlock_irqrestore(&host->lock, flags);
+			mmc_detect_change(host, 0);
+		}
+	}
+
 	return ret;
 }
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index b9b9fb6..2831c03 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -925,15 +925,20 @@ EXPORT_SYMBOL(__mmc_claim_host);
  */
 int mmc_try_claim_host(struct mmc_host *host)
 {
+	struct mmc_card *card;
 	int claimed_host = 0;
 	unsigned long flags;
 
+	card = host->card;
+	pm_runtime_get_sync(&card->dev);
+
 	spin_lock_irqsave(&host->lock, flags);
 	if (!host->claimed || host->claimer == current) {
 		host->claimed = 1;
 		host->claimer = current;
 		host->claim_cnt += 1;
 		claimed_host = 1;
+		set_current_state(TASK_RUNNING);
 	}
 	spin_unlock_irqrestore(&host->lock, flags);
 	if (host->ops->enable && claimed_host && host->claim_cnt == 1)
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 6d02012..90e5555 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1447,7 +1447,8 @@ static void mmc_detect(struct mmc_host *host)
 	BUG_ON(!host);
 	BUG_ON(!host->card);
 
-	mmc_get_card(host->card);
+	if (!mmc_try_claim_host(host))
+		return;
 
 	/*
 	 * Just check if our card has been removed.
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 5e8823d..7dfb24d 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1045,7 +1045,8 @@ static void mmc_sd_detect(struct mmc_host *host)
 	BUG_ON(!host);
 	BUG_ON(!host->card);
 
-	mmc_get_card(host->card);
+	if (!mmc_try_claim_host(host))
+		return;
 
 	/*
 	 * Just check if our card has been removed.
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 80d89cff..e0cabf5 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -875,7 +875,8 @@ static void mmc_sdio_detect(struct mmc_host *host)
 		}
 	}
 
-	mmc_claim_host(host);
+	if (!mmc_try_claim_host(host))
+		return;
 
 	/*
 	 * Just check if our card has been removed.
-- 
1.8.0


