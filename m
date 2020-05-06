Return-Path: <SRS0=wp20=6U=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C75C28CBC
	for <linux-mmc@archiver.kernel.org>; Wed,  6 May 2020 14:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01815208CA
	for <linux-mmc@archiver.kernel.org>; Wed,  6 May 2020 14:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="W86F9Y1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgEFOfE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 May 2020 10:35:04 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:21098 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729078AbgEFOfE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 May 2020 10:35:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588775703; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=VGWu+jgcC6PXT/LdkNQ8zizPYREz2ezvMgLbsLUy08w=; b=W86F9Y1qwuQC0lYSd3l2oav9CeFhlcLzdJrEQIlo56vtS7TAX8joHYEuQ1vdo0PM6CeKb/rJ
 ej4/uTbsXqvNkJnlx5pghp9Shyq/Ci683mb7tEeTH37+ngUZtZW9qsaAGi/QBCopnE+LFZaZ
 JP3AKV+JTFu6rwNuEVIUFeB2/lo=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb2cb0d.7f424385a068-smtp-out-n02;
 Wed, 06 May 2020 14:34:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A5B50C43637; Wed,  6 May 2020 14:34:52 +0000 (UTC)
Received: from vbadigan-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6F57CC433D2;
        Wed,  6 May 2020 14:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6F57CC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     stummala@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        <stable@vger.kernel.org>, Baolin Wang <baolin.wang@linaro.org>,
        Avri Altman <avri.altman@wdc.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH V1 1/2] mmc: core: Check request type before completing the request
Date:   Wed,  6 May 2020 20:04:02 +0530
Message-Id: <1588775643-18037-2-git-send-email-vbadigan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1588775643-18037-1-git-send-email-vbadigan@codeaurora.org>
References: <1588775643-18037-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In the request completion path with CQE, request type is being checked
after the request is getting completed. This is resulting in returning
the wrong request type and leading to the IO hang issue.

ASYNC request type is getting returned for DCMD type requests.
Because of this mismatch, mq->cqe_busy flag is never getting cleared
and the driver is not invoking blk_mq_hw_run_queue. So requests are not
getting dispatched to the LLD from the block layer.

All these eventually leading to IO hang issues.
So, get the request type before completing the request.

Cc: <stable@vger.kernel.org> # v4.19+
Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 drivers/mmc/core/block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 8499b56..c5367e2 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1370,6 +1370,7 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
 	struct mmc_request *mrq = &mqrq->brq.mrq;
 	struct request_queue *q = req->q;
 	struct mmc_host *host = mq->card->host;
+	enum mmc_issue_type issue_type = mmc_issue_type(mq, req);
 	unsigned long flags;
 	bool put_card;
 	int err;
@@ -1399,7 +1400,7 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
 
 	spin_lock_irqsave(&mq->lock, flags);
 
-	mq->in_flight[mmc_issue_type(mq, req)] -= 1;
+	mq->in_flight[issue_type] -= 1;
 
 	put_card = (mmc_tot_in_flight(mq) == 0);
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
