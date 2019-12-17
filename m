Return-Path: <SRS0=9I0v=2H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A43AC2D0C3
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 02:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6380E21D7D
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 02:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="FJHVJptz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfLQCwp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Dec 2019 21:52:45 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:61772 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726959AbfLQCwo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2019 21:52:44 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576551163; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=3ECQl9XMxsad4PSl6zFfkC79rWSYCYJDuUPFfcf9x9o=; b=FJHVJptzHbuE30cXQ7/d5v43NVoY3Gb97yRGuCyzWRcA/sLQOIwo8YE0fW1r/oEvaEZG46/W
 mqjI8IW92ABd11h6NwG9i0rL1LGm5kgh2J+52eRJvnxHdGzP0/zNgd7Mu76RHV23yueiUa6Q
 DPRDXcg0wy4z2Ua87YqF6/IJzXg=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5df842fa.7fd2679c1b58-smtp-out-n01;
 Tue, 17 Dec 2019 02:52:42 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7492AC43383; Tue, 17 Dec 2019 02:52:42 +0000 (UTC)
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: nguyenb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AE6BEC447A2;
        Tue, 17 Dec 2019 02:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AE6BEC447A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=nguyenb@codeaurora.org
From:   "Bao D. Nguyen" <nguyenb@codeaurora.org>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        asutoshd@codeaurora.org, cang@codeaurora.org,
        Sayali Lokhande <sayalil@codeaurora.org>,
        "Bao D. Nguyen" <nguyenb@codeaurora.org>
Subject: [<PATCH v1> 5/9] mmc: core: fix one NULL pointer dereference after SD card is removed
Date:   Mon, 16 Dec 2019 18:50:38 -0800
Message-Id: <6373c3574eb80f2a760f23883196c309dacfa163.1576540908.git.nguyenb@codeaurora.org>
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

After SD card is removed, the driver would mark its queue DYING to try to
block further more requests from coming into the queue, then clean up its
queue's queuedata by setting it to NULL. However, there can still be new
requests come in right before the DYING mark is set after SD card is
removed. When one new request is allocated and initialized, the queuedata
would be accessed. If queuedata has been cleaned up already, NULL pointer
dereference would happen. This change fixes it by checking if queuedata is
NULL before accessing it, if yes, then bails out with error.

mmc0: card aaaa removed
Buffer I/O error on dev mmcblk0p1, logical block 1, lost async page write
Unable to handle kernel NULL pointer dereference at virtual address
00000000
Mem abort info:
Exception class = DABT (current EL), IL = 32 bits
SET = 0, FnV = 0
EA = 0, S1PTW = 0
Data abort info:
ISV = 0, ISS = 0x00000006
CM = 0, WnR = 0
user pgtable: 4k pages, 39-bit VAs, pgd = ffffffd7bbafa000
[0000000000000000] *pgd=0000000134331003, *pud=0000000134331003,
*pmd=0000000000000000
Internal error: Oops: 96000006 [#1] PREEMPT SMP
task: ffffffd77d193380 task.stack: ffffff8047e30000
pc : mmc_init_request+0x28/0x74
lr : alloc_request_size+0x4c/0x70
...
Process MediaScannerSer (pid: 4710, stack limit = 0xffffff8047e30000)
Call trace:
mmc_init_request+0x28/0x74
alloc_request_size+0x4c/0x70
mempool_alloc+0x104/0x184
get_request+0x324/0x75c
blk_queue_bio+0x154/0x398
generic_make_request+0xcc/0x228
submit_bio+0x13c/0x1d4.

Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
---
 drivers/mmc/core/queue.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 846557b..a1de5f7 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -211,8 +211,11 @@ static int __mmc_init_request(struct mmc_queue *mq, struct request *req,
 			      gfp_t gfp)
 {
 	struct mmc_queue_req *mq_rq = req_to_mmc_queue_req(req);
-	struct mmc_card *card = mq->card;
-	struct mmc_host *host = card->host;
+	struct mmc_host *host;
+
+	if (!mq)
+		return -ENODEV;
+	host = mq->card->host;
 
 	mq_rq->sg = mmc_alloc_sg(mmc_get_max_segments(host), gfp);
 	if (!mq_rq->sg)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
