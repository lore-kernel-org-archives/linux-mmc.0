Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5733BC43334
	for <linux-mmc@archiver.kernel.org>; Sat, 25 Jun 2022 12:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbiFYM4M (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 25 Jun 2022 08:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiFYM4L (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 25 Jun 2022 08:56:11 -0400
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72DD18366
        for <linux-mmc@vger.kernel.org>; Sat, 25 Jun 2022 05:56:10 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 55KZoQtCWgoLG55KZolijr; Sat, 25 Jun 2022 14:56:07 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 25 Jun 2022 14:56:07 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 3/3] memstick/ms_block: Use the bitmap API when applicable
Date:   Sat, 25 Jun 2022 14:56:05 +0200
Message-Id: <b216df8798f765ab14bce65739c220643320f376.1656155715.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1656155715.git.christophe.jaillet@wanadoo.fr>
References: <cover.1656155715.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use bitmap_equal() instead of hand writing it. It improves semantic and
avoids some explicit computation to convert a number of bits to a number of
bytes.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/memstick/core/ms_block.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index f8fdf88fb240..c05edfc1c841 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -2245,8 +2245,8 @@ static int msb_resume(struct memstick_dev *card)
 		goto out;
 
 	if (msb->block_count != new_msb->block_count ||
-		memcmp(msb->used_blocks_bitmap, new_msb->used_blocks_bitmap,
-							msb->block_count / 8))
+	    !bitmap_equal(msb->used_blocks_bitmap, new_msb->used_blocks_bitmap,
+							msb->block_count))
 		goto out;
 
 	card_dead = false;
-- 
2.34.1

