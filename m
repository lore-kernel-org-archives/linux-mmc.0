Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9302C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 22 Dec 2020 13:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C33D23103
	for <linux-mmc@archiver.kernel.org>; Tue, 22 Dec 2020 13:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgLVNeM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 22 Dec 2020 08:34:12 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9636 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgLVNeM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Dec 2020 08:34:12 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D0cht6bBsz15gcD;
        Tue, 22 Dec 2020 21:32:46 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 22 Dec 2020 21:33:23 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] mmc: core: use roundup macro to to calculate blk_sz
Date:   Tue, 22 Dec 2020 21:33:55 +0800
Message-ID: <20201222133355.19807-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Don't open-code roundup() kernel macro.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/mmc/core/sdio_io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index 79dbf90216b5..35c69bdeb40e 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -263,8 +263,7 @@ unsigned int sdio_align_size(struct sdio_func *func, unsigned int sz)
 		 * Realign it so that it can be done with one request,
 		 * and recheck if the controller still likes it.
 		 */
-		blk_sz = ((sz + func->cur_blksize - 1) /
-			func->cur_blksize) * func->cur_blksize;
+		blk_sz = roundup(sz, func->cur_blksize);
 		blk_sz = _sdio_align_size(blk_sz);
 
 		/*
-- 
2.22.0

