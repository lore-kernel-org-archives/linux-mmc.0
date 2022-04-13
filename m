Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CBAC433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Apr 2022 08:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbiDMIJh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Apr 2022 04:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiDMIJg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2022 04:09:36 -0400
X-Greylist: delayed 125 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Apr 2022 01:07:11 PDT
Received: from support.corp-email.com (support.corp-email.com [222.73.234.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4E32C667
        for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2022 01:07:09 -0700 (PDT)
Received: from ([114.119.32.142])
        by support.corp-email.com ((D)) with ASMTP (SSL) id IES00052
        for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2022 16:04:52 +0800
Received: from localhost.localdomain (172.16.35.4) by GCY-MBS-28.TCL.com
 (10.136.3.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 13 Apr
 2022 16:04:53 +0800
From:   Rokudo Yan <wu-yan@tcl.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <tang.ding@tcl.com>, <mingbo.feng@tcl.com>, <wu-yan@tcl.com>
Subject: [PATCH] mmc: avoid livelock in mmc_sd_detect
Date:   Wed, 13 Apr 2022 16:04:46 +0800
Message-ID: <20220413080446.1308828-1-wu-yan@tcl.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.35.4]
X-ClientProxiedBy: GCY-EXS-21.TCL.com (10.74.128.61) To GCY-MBS-28.TCL.com
 (10.136.3.28)
tUid:   2022413160452f4d4ff0960d1c924a24807b44eaa51c2
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There is a potential livelock when mmc_sd_detect is invoked by
pm_suspend, as below:

[thread do suspend]
state_store
 -pm_suspend
  -__pm_notifier_call_chain
   -mmc_pm_notify
    -cancel_delayed_work_sync(&host->detect)
     -__cancel_work_timer
      -__flush_work
       -wait_for_completion
       wait for detect work current running to complete

[kworker run detect work]
process_one_work
 -mmc_rescan
  -mmc_sd_detect
   -mmc_get_card
    -__mmc_claim_host
     -schedule
     wait for current host claimer release

[kworker dispatch io (current host claimer)]
process_one_work
 -blk_mq_run_work_fn
  -__blk_mq_run_hw_queue
   -blk_mq_sched_dispatch_requests
    -blk_mq_do_dispatch_sched
     -blk_mq_dispatch_rq_list
      -mmc_mq_queue_rq
       -mmc_get_card -- claim mmc host if inflight=1 (the first io)
                        and only release when all ios complete
       -mmc_blk_mq_issue_rq

if there are continous io requests in the system to keep queue busy
(inflight !=0 all the time), the supsend process will blocked and
hang the system.

This issue can reproduced by steps below:
1. prepare 1 SD card
2. run fio to keep the card io busy
  fio --size=1m --bs=32k --ioengine=libaio --iodepth=64 \
    --direct=1 --rw=read --time_based --runtime=60000 \
    --name=test --filename=<path under sd card>
3. suspend the system (echo mem > /sys/power/state)
4. resume the system
5. suspend the system again & device hang

Signed-off-by: Rokudo Yan <wu-yan@tcl.com>
---
 drivers/mmc/core/queue.c | 8 ++++++++
 drivers/mmc/core/sd.c    | 2 ++
 include/linux/mmc/host.h | 3 +++
 3 files changed, 13 insertions(+)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index c69b2d9df6f1..f00fc45a4fd5 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -241,6 +241,14 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 		return BLK_STS_IOERR;
 	}
 
+	/*
+	 * requeue the io if sd detect is on-going to avoid livelock
+	 * when mmc_sd_detect is invoked by pm_suspend and there are
+	 * continous io requests simultaneously.
+	 */
+	if (host->doing_sd_detect)
+		return BLK_STS_RESOURCE;
+
 	issue_type = mmc_issue_type(mq, req);
 
 	spin_lock_irq(&mq->lock);
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 68df6b2f49cc..460ea6ab9aba 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1594,6 +1594,7 @@ static void mmc_sd_detect(struct mmc_host *host)
 {
 	int err;
 
+	host->doing_sd_detect = true;
 	mmc_get_card(host->card, NULL);
 
 	/*
@@ -1611,6 +1612,7 @@ static void mmc_sd_detect(struct mmc_host *host)
 		mmc_power_off(host);
 		mmc_release_host(host);
 	}
+	host->doing_sd_detect = false;
 }
 
 static int sd_can_poweroff_notify(struct mmc_card *card)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 7afb57cab00b..4abfc5d7ef20 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -501,6 +501,9 @@ struct mmc_host {
 	/* Host Software Queue support */
 	bool			hsq_enabled;
 
+	/* indicate SD detect on-going */
+	bool			doing_sd_detect;
+
 	unsigned long		private[] ____cacheline_aligned;
 };
 
-- 
2.25.1

