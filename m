Return-Path: <SRS0=7UF0=6V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BE8C38A24
	for <linux-mmc@archiver.kernel.org>; Thu,  7 May 2020 16:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D182083B
	for <linux-mmc@archiver.kernel.org>; Thu,  7 May 2020 16:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="UhTFXu5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgEGQQA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 May 2020 12:16:00 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:34024 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726222AbgEGQQA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 May 2020 12:16:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588868159; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=w5NiSQ77D5gTRpc269gInIopQbtzyb+mp/b4/2QKUDE=; b=UhTFXu5ulu7Vd/LRB1gzux5OpXKN+1a7Fv7CPwPDaMddmIQr0hyuScgqlz+pIQW9In2PS7iS
 2JxXhAcbGH222aY+Rwub05XeKtkjJrWy3LbDQkTKaFIaqMH5OYPYETiDhpLAbONO/zg5U/p+
 UyLq8aAhBWL+pnylPy/fdDxIMVA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb43438.7f2b80073570-smtp-out-n04;
 Thu, 07 May 2020 16:15:52 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7F4DAC44793; Thu,  7 May 2020 16:15:51 +0000 (UTC)
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4D35DC433F2;
        Thu,  7 May 2020 16:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D35DC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     stummala@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Sarthak Garg <sartgarg@codeaurora.org>,
        <stable@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Andreas Koop <andreas.koop@zf.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH V2] mmc: core: Fix recursive locking issue in CQE recovery path
Date:   Thu,  7 May 2020 21:45:33 +0530
Message-Id: <1588868135-31783-1-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1588775643-18037-3-git-send-email-vbadigan@codeaurora.org>
References: <1588775643-18037-3-git-send-email-vbadigan@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Sarthak Garg <sartgarg@codeaurora.org>

Consider the following stack trace

-001|raw_spin_lock_irqsave
-002|mmc_blk_cqe_complete_rq
-003|__blk_mq_complete_request(inline)
-003|blk_mq_complete_request(rq)
-004|mmc_cqe_timed_out(inline)
-004|mmc_mq_timed_out

mmc_mq_timed_out acquires the queue_lock for the first
time. The mmc_blk_cqe_complete_rq function also tries to acquire
the same queue lock resulting in recursive locking where the task
is spinning for the same lock which it has already acquired leading
to watchdog bark.

Fix this issue with the lock only for the required critical section.

Cc: <stable@vger.kernel.org>
Fixes: 1e8e55b67030 ("mmc: block: Add CQE support")
Suggested-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Sarthak Garg <sartgarg@codeaurora.org>
---
 drivers/mmc/core/queue.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 25bee3d..b5fd3bc 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -107,7 +107,7 @@ static enum blk_eh_timer_return mmc_cqe_timed_out(struct request *req)
 	case MMC_ISSUE_DCMD:
 		if (host->cqe_ops->cqe_timeout(host, mrq, &recovery_needed)) {
 			if (recovery_needed)
-				__mmc_cqe_recovery_notifier(mq);
+				mmc_cqe_recovery_notifier(mrq);
 			return BLK_EH_RESET_TIMER;
 		}
 		/* No timeout (XXX: huh? comment doesn't make much sense) */
@@ -127,18 +127,13 @@ static enum blk_eh_timer_return mmc_mq_timed_out(struct request *req,
 	struct mmc_card *card = mq->card;
 	struct mmc_host *host = card->host;
 	unsigned long flags;
-	int ret;
+	bool ignore_tout;
 
 	spin_lock_irqsave(&mq->lock, flags);
-
-	if (mq->recovery_needed || !mq->use_cqe || host->hsq_enabled)
-		ret = BLK_EH_RESET_TIMER;
-	else
-		ret = mmc_cqe_timed_out(req);
-
+	ignore_tout = mq->recovery_needed || !mq->use_cqe || host->hsq_enabled;
 	spin_unlock_irqrestore(&mq->lock, flags);
 
-	return ret;
+	return ignore_tout ? BLK_EH_RESET_TIMER : mmc_cqe_timed_out(req);
 }
 
 static void mmc_mq_recovery_handler(struct work_struct *work)
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
