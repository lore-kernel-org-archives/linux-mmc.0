Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B55FC433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Dec 2021 01:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbhLOBNv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Dec 2021 20:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbhLOBNu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Dec 2021 20:13:50 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84026C061574
        for <linux-mmc@vger.kernel.org>; Tue, 14 Dec 2021 17:13:50 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id w24so2316030ply.12
        for <linux-mmc@vger.kernel.org>; Tue, 14 Dec 2021 17:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJXxhsskPiwcAy65vtb1CZVIFaDxHK6R02TxyZaEPAI=;
        b=kW4srf/vvRDaPssh52hoa/7RVy1JoMSLvzkSzMDKVd9JSQp4oGHHKqgxQ6E5XO5vNr
         wc2JpTDyI4KneFadP4Sv7A/RIYzDvYZaKCafYypE12UUHxeIeP0DTg+6aJwKxgOuZuHm
         MPdd/Zm+TblN2SORHgIIgXv/YV31mRoJyb79sYXCNQHNv3T130PMjtDK5vnqJhRav9Sr
         HAIT6Xe3KNgj7mUWRiFMC+EPt6TBk598frw2ckFKS5bPOMncUco/z3WJinJLKR8YSi9S
         +HVr5GtT6u+Cvvo4578Zb42yHDMvYvuAX/2P9O1XljfMOW+hP+1vbXIiXkyR8IX55bZ8
         LCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=TJXxhsskPiwcAy65vtb1CZVIFaDxHK6R02TxyZaEPAI=;
        b=wLgC4FSc1ReRRWOuM3Li8+yItu/vdfMb44RYu0/8xq52Q8DZZays3BywxmxBMgjY2k
         z9yKPiV/4MJfFiphjjjXeghRCT5OGvRlO5X9G4seNk1rH0AYVwVLQR5qzy37wxKbwx5q
         jCGyLhl2Otp4h3Bej0W/lWkL/VZ3QYwD4P9Z5IzsMW0FWT8OQDnFrUU5g5w8WB45+HCi
         MX0shTacH8t+582d27m/Er84BFEA6pTnZb186+ZvBBfKDBOdfcpFNYe1LqjzhX9f1+eF
         QIYidhp91+jTBxeV/hZl2ZJVJmweankQCLltzEhoDGhqneqmc0oWqzwEikus8Qxt9MUw
         NJHw==
X-Gm-Message-State: AOAM531Axt4SsOZKhU+/wlIBx1uHN++ebN/xqQoyEDh4cGKgcGlkXhOB
        CMBEMQQfaIouMMEOrjYZ1Gy3NBRL058=
X-Google-Smtp-Source: ABdhPJyjEpikH8MEZA6WKIVFGENLYb5q5BlzUeYLvi8FHvK9cMf+aFB2n7q/uT5UwuDfvYFCJEpXTw==
X-Received: by 2002:a17:90b:3508:: with SMTP id ls8mr9203612pjb.51.1639530829899;
        Tue, 14 Dec 2021 17:13:49 -0800 (PST)
Received: from localhost.localdomain ([45.124.203.19])
        by smtp.gmail.com with ESMTPSA id p12sm302442pfo.125.2021.12.14.17.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 17:13:48 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: core: Fix blk_status_t handling
Date:   Wed, 15 Dec 2021 11:43:36 +1030
Message-Id: <20211215011336.194089-1-joel@jms.id.au>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Sparse spits out this following warning:

drivers/mmc/core/queue.c:311:21: warning: incorrect type in assignment (different base types)
drivers/mmc/core/queue.c:311:21:    expected int ret
drivers/mmc/core/queue.c:311:21:    got restricted blk_status_t [usertype]
drivers/mmc/core/queue.c:314:21: warning: incorrect type in assignment (different base types)
drivers/mmc/core/queue.c:314:21:    expected int ret
drivers/mmc/core/queue.c:314:21:    got restricted blk_status_t [usertype]
drivers/mmc/core/queue.c:336:16: warning: incorrect type in return expression (different base types)
drivers/mmc/core/queue.c:336:16:    expected restricted blk_status_t
drivers/mmc/core/queue.c:336:16:    got int [assigned] ret

ret is only used for blk_status_t types, so make it that type.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/mmc/core/queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index b15c034b42fb..c69b2d9df6f1 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -234,7 +234,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 	enum mmc_issue_type issue_type;
 	enum mmc_issued issued;
 	bool get_card, cqe_retune_ok;
-	int ret;
+	blk_status_t ret;
 
 	if (mmc_card_removed(mq->card)) {
 		req->rq_flags |= RQF_QUIET;
-- 
2.34.1

