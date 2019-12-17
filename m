Return-Path: <SRS0=9I0v=2H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5C6C2D0C3
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 02:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B9F24655
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 02:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="nq87AV2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfLQCxD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Dec 2019 21:53:03 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:25671 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727105AbfLQCwq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2019 21:52:46 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576551165; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=i+lqutq77CSCW+Va4i3in2E5g8ytBPYH4T/8wrRI3Xk=; b=nq87AV2ngySvrP4S0ye5mSwrla234LI6dYyy3R9veY4f4XPgApLW3fAPw1fTndxqUEJUKWDa
 kEVeRW2H99RNz9AkLfNKjjWPnhj/NVLLOFTkUnyzay0tnfBzhmLu3cuDrMzuZIS+gzO7FctH
 mgVKZByzM6B51l50hWsab36Vgxo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df842f9.7f382a4b9030-smtp-out-n03;
 Tue, 17 Dec 2019 02:52:41 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 92F45C4479C; Tue, 17 Dec 2019 02:52:41 +0000 (UTC)
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: nguyenb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 83802C43383;
        Tue, 17 Dec 2019 02:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 83802C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=nguyenb@codeaurora.org
From:   "Bao D. Nguyen" <nguyenb@codeaurora.org>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        asutoshd@codeaurora.org, cang@codeaurora.org,
        Sayali Lokhande <sayalil@codeaurora.org>,
        "Bao D. Nguyen" <nguyenb@codeaurora.org>
Subject: [<PATCH v1> 4/9] mmc: core: fix SD card request queue refcount underflow during shutdown
Date:   Mon, 16 Dec 2019 18:50:37 -0800
Message-Id: <afdbf5eff1918f4004f2418e90bd08400d40ed1b.1576540907.git.nguyenb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1576540906.git.nguyenb@codeaurora.org>
References: <cover.1576540906.git.nguyenb@codeaurora.org>
In-Reply-To: <cover.1576540906.git.nguyenb@codeaurora.org>
References: <cover.1576540906.git.nguyenb@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Can Guo <cang@codeaurora.org>

When system shutdown, kernel shall call shutdown function of mmc to stop
its request queue and clean it up, during which the request queue's kobject
shall be put once. In normal cases, if the SD card is removed, the
mmc_blk_remove routine releases all the resources and kobjects related to
the disk and request queue by decreasing their kref counts to 0. But if the
SD card is removed after its shutdown function is called, below kref count
underflow error shall be thrown out because the kref count was decreased
once during request queue cleanup by the shutdown function in advance. This
change fixes it by skipping request queue cleanup in the mmc blk routine if
the queue has been marked as dead.

[  166.187211] refcount_t: underflow; use-after-free.
[  166.187277] ------------[ cut here ]------------
[  166.187321] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[  166.187542] Workqueue: events_freezable mmc_rescan
[  166.187558] task: ffffffe673b96680 task.stack: ffffff8008418000
[  166.187579] pc : refcount_sub_and_test+0x64/0x78
[  166.187593] lr : refcount_sub_and_test+0x64/0x78
[  166.187605] sp : ffffff800841ba20 pstate : 60c00145
[  166.188319] Call trace:
[  166.188331]  refcount_sub_and_test+0x64/0x78
[  166.188343]  refcount_dec_and_test+0x18/0x24
[  166.188355]  kobject_put+0x5c/0x74
[  166.188374]  blk_put_queue+0x1c/0x28
[  166.188388]  disk_release+0x70/0x90
[  166.188402]  device_release+0x38/0x90
[  166.188429]  kobject_cleanup+0xc4/0x1c0
[  166.188441]  kobject_put+0x68/0x74
[  166.188455]  put_disk+0x20/0x2c
[  166.188467]  mmc_blk_put+0x9c/0xdc
[  166.188480]  mmc_blk_remove_req+0x110/0x120
[  166.188493]  mmc_blk_remove+0x14c/0x22c
[  166.188505]  mmc_bus_remove+0x24/0x34
[  166.188517]  device_release_driver_internal+0x13c/0x1e0
[  166.188528]  device_release_driver+0x24/0x30
[  166.188540]  bus_remove_device+0xdc/0x120
[  166.188552]  device_del+0x1e0/0x284
[  166.188564]  mmc_remove_card+0x68/0x7c
[  166.188577]  mmc_sd_remove+0x24/0x48
[  166.188588]  mmc_sd_detect+0x120/0x1a4
[  166.188600]  mmc_rescan+0xf4/0x384
[  166.188613]  process_one_work+0x1c0/0x3d4
[  166.188625]  worker_thread+0x224/0x344
[  166.188637]  kthread+0x120/0x130
[  166.188649]  ret_from_fork+0x10/0x18.

Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
---
 drivers/mmc/core/queue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 9edc086..846557b 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -506,7 +506,8 @@ void mmc_cleanup_queue(struct mmc_queue *mq)
 	if (blk_queue_quiesced(q))
 		blk_mq_unquiesce_queue(q);
 
-	blk_cleanup_queue(q);
+	if (likely(!blk_queue_dead(q)))
+		blk_cleanup_queue(q);
 	blk_mq_free_tag_set(&mq->tag_set);
 
 	/*
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
