Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49699C43334
	for <linux-mmc@archiver.kernel.org>; Sat, 25 Jun 2022 12:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiFYM4D (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 25 Jun 2022 08:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiFYM4C (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 25 Jun 2022 08:56:02 -0400
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C97618353
        for <linux-mmc@vger.kernel.org>; Sat, 25 Jun 2022 05:56:01 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 55KQonppmZfs855KQoIbv6; Sat, 25 Jun 2022 14:55:59 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 25 Jun 2022 14:55:59 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 2/3] memstick/ms_block: Fix a memory leak
Date:   Sat, 25 Jun 2022 14:55:56 +0200
Message-Id: <b3b78926569445962ea5c3b6e9102418a9effb88.1656155715.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1656155715.git.christophe.jaillet@wanadoo.fr>
References: <cover.1656155715.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

'erased_blocks_bitmap' is never freed. As it is allocated at the same time
as 'used_blocks_bitmap', it is likely that it should be freed also at the
same time.

Add the corresponding bitmap_free() in msb_data_clear().

Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is speculative.
---
 drivers/memstick/core/ms_block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index f8f151163667..f8fdf88fb240 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -1947,6 +1947,7 @@ static void msb_data_clear(struct msb_data *msb)
 {
 	kfree(msb->boot_page);
 	bitmap_free(msb->used_blocks_bitmap);
+	bitmap_free(msb->erased_blocks_bitmap);
 	kfree(msb->lba_to_pba_table);
 	kfree(msb->cache);
 	msb->card = NULL;
-- 
2.34.1

