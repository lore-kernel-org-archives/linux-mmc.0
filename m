Return-Path: <SRS0=LKB8=BU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FC1C433DF
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Aug 2020 08:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E2262073A
	for <linux-mmc@archiver.kernel.org>; Mon, 10 Aug 2020 08:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgHJICv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 10 Aug 2020 04:02:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50716 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgHJICv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Aug 2020 04:02:51 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k52lc-0004UZ-4m; Mon, 10 Aug 2020 08:02:48 +0000
From:   Colin King <colin.king@canonical.com>
To:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ms_block: fix spelling mistake "doesn'" -> "doesn't"
Date:   Mon, 10 Aug 2020 09:02:47 +0100
Message-Id: <20200810080247.47024-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a debug message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/memstick/core/ms_block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index d9ee8e3dc72d..ad1c6f2db089 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -1223,7 +1223,7 @@ static int msb_read_boot_blocks(struct msb_data *msb)
 		}
 
 		if (be16_to_cpu(page->header.block_id) != MS_BLOCK_BOOT_ID) {
-			dbg("the pba at %d doesn' contain boot block ID", pba);
+			dbg("the pba at %d doesn't contain boot block ID", pba);
 			continue;
 		}
 
-- 
2.27.0

