Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F235FC432BE
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Jul 2021 10:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E014D60FD8
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Jul 2021 10:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbhG1KdB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 28 Jul 2021 06:33:01 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:53222
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236013AbhG1KdA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Jul 2021 06:33:00 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D4D9E3F10D;
        Wed, 28 Jul 2021 10:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627468378;
        bh=XNO1mrfFFBkuWhQ9luWLXC9e6Sd/brZvm/BfQzCu/60=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=A0E1Ewc9Hjw2p/eCM4HgbdnyQ0uRRC0T3ej+jpp+246828u6zaW7dnIjoxNlaqVwd
         VUJT4U913YowuC2e+b0K947MI2or739H4kEgcvljrGynSf2lRatKHV5jVOO5T2B7HS
         YL3OP3Lp6M+ZrbodTaPlr5yDsbeRsYX0mBcQ+ZwRRR7RrvWfE+ZLsOH7rlCu9Gum5s
         QJf6j6DZY/qBH7NaMIMn9U/E7kC1rD6kqtVwE4XBPkOVAtVvR6QVT085yL3ON78Jai
         ySpum3qbgSm91lavMmuVlwuVRQF+ePBOKCVDLbF3gJHos7Byu8jTwl1MQGpvyIMWkC
         lZ7IvuSMgc6jA==
From:   Colin King <colin.king@canonical.com>
To:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ms_block: Fix spelling contraction "cant" -> "can't"
Date:   Wed, 28 Jul 2021 11:32:54 +0100
Message-Id: <20210728103254.171546-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a pr_err message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/memstick/core/ms_block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index 4a4573fa7b0f..acf36676e388 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -1105,7 +1105,7 @@ static u16 msb_get_free_block(struct msb_data *msb, int zone)
 	dbg_verbose("result of the free blocks scan: pba %d", pba);
 
 	if (pba == msb->block_count || (msb_get_zone_from_pba(pba)) != zone) {
-		pr_err("BUG: cant get a free block");
+		pr_err("BUG: can't get a free block");
 		msb->read_only = true;
 		return MS_BLOCK_INVALID;
 	}
-- 
2.31.1

