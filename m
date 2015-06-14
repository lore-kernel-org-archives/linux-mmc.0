From: Rabin Vincent <rabin.vincent@axis.com>
Subject: [PATCH] mmc: queue: prevent soft lockups on PREEMPT=n
Date: Sun, 14 Jun 2015 19:26:11 +0200
Message-ID: <1434302771-9599-1-git-send-email-rabin.vincent@axis.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:50641 "EHLO
	bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbbFNR0S (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 14 Jun 2015 13:26:18 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Rabin Vincent <rabinv@axis.com>

On systems with CONFIG_PREEMPT=n, under certain circumstances, mmcqd
can continuously process requests for several seconds without blocking,
triggering the soft lockup watchdog.  For example, this can happen if
mmcqd runs on the CPU which services the controller's interrupt, and
a process on a different CPU continuously writes to the MMC block
device.

 NMI watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [mmcqd/0:664]
 CPU: 0 PID: 664 Comm: mmcqd/0 Not tainted 4.1.0-rc7+ #4
 PC is at _raw_spin_unlock_irqrestore+0x24/0x28
 LR is at mmc_start_request+0x104/0x134
 ...
 [<805112a8>] (_raw_spin_unlock_irqrestore) from [<803db664>] (mmc_start_request+0x104/0x134)
 [<803db664>] (mmc_start_request) from [<803dc008>] (mmc_start_req+0x274/0x394)
 [<803dc008>] (mmc_start_req) from [<803eb2c4>] (mmc_blk_issue_rw_rq+0xd0/0xb98)
 [<803eb2c4>] (mmc_blk_issue_rw_rq) from [<803ebe8c>] (mmc_blk_issue_rq+0x100/0x470)
 [<803ebe8c>] (mmc_blk_issue_rq) from [<803ecab8>] (mmc_queue_thread+0xd0/0x170)
 [<803ecab8>] (mmc_queue_thread) from [<8003fd14>] (kthread+0xe0/0xfc)
 [<8003fd14>] (kthread) from [<8000f768>] (ret_from_fork+0x14/0x2c)

Fix it by adding a cond_resched() in the request handling loop so that
other processes get a chance to run.

Signed-off-by: Rabin Vincent <rabin.vincent@axis.com>
---
 drivers/mmc/card/queue.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 8efa368..e78ae97 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -69,6 +69,7 @@ static int mmc_queue_thread(void *d)
 			set_current_state(TASK_RUNNING);
 			cmd_flags = req ? req->cmd_flags : 0;
 			mq->issue_fn(mq, req);
+			cond_resched();
 			if (mq->flags & MMC_QUEUE_NEW_REQUEST) {
 				mq->flags &= ~MMC_QUEUE_NEW_REQUEST;
 				continue; /* fetch again */
-- 
1.7.10.4

