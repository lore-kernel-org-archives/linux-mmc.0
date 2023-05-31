Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C66FC7EE23
	for <linux-mmc@archiver.kernel.org>; Wed, 31 May 2023 00:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjEaA16 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 30 May 2023 20:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjEaA16 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 May 2023 20:27:58 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA2AC7
        for <linux-mmc@vger.kernel.org>; Tue, 30 May 2023 17:27:55 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id D0FB280A0C;
        Wed, 31 May 2023 02:27:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1685492872;
        bh=/+360ojmfrwe3lZMIxXlsB8Bx+Yd3xwEddcLbB4BRO8=;
        h=From:To:Cc:Subject:Date:From;
        b=INNVVh/ZhzK+oyksRoI2CEKMQHBZMxVBut5m0fc5L9AGjjJc/SsnqH9cWup1ODYJm
         LbIDu5EFtHrCaK/GjWXQO1SEb9rJV6v7Bajimi4ysb7722eRIWaJdNOlpvpq3BUQTX
         6lKrIVVUNsZMHzJ30CIoUsshreulTtOplCYsQnXohy/WbLG8kROe+FR80R2Y+enYb2
         1+pRBodE+nPHgutK1MW6cvRyATvC9NQUjWZLKLdaj2tcz6ey0EtuPStVIVxgAyH9qt
         VRcuRvoCTopnqMOw90joyyeEKF8gwy3kzJLS7j3+y64vZ6pWpNBjsBKOAKC42Ez3il
         nOnnvgWj7ZlYQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-mmc@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        =?UTF-8?q?Christian=20L=C3=B6hle?= <CLoehle@hyperstone.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Wu <michael@allwinnertech.com>,
        Ming Lei <ming.lei@redhat.com>,
        Seunghui Lee <sh043.lee@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] [RFC] Revert "mmc: core: Fixup support for writeback-cache for eMMC and SD"
Date:   Wed, 31 May 2023 02:27:40 +0200
Message-Id: <20230531002740.1235620-1-marex@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This reverts commit 08ebf903af57cda6d773f3dd1671b64f73b432b8.

On STM32MP153C DHCOR DRC Compact with microSD card
Kingston Canvas Go! Plus MicroSDXC I 64 GiB U3/V30/A2 SDCG3/64GB
it is no longer possible to mount ext4 filesystem.

Git bisect points to this commit which is being reverted here. A bit of
investigation shows that for non-working microSD cards
  cache_enabled=TRUE fua_enabled=false
For working microSD card (Kingston Canvas React Plus, MicroSDXC II
64 GiB U3/V90/A1 SDCR2/64GB)
  cache_enabled=FALSE fua_enabled=false

It seems enabling the cache for SD cards causes the issue. Before the
reverted commit, the cache was not reported enabled for SD cards. I am
not sure whether such blunt revert is the correct solution however, any
ideas ?

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "Christian Löhle" <CLoehle@hyperstone.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Avri Altman <avri.altman@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Marek Vasut <marex@denx.de>
Cc: Michael Wu <michael@allwinnertech.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Seunghui Lee <sh043.lee@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
---
 drivers/mmc/core/block.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index db6d8a0999100..72aa47af11d37 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2413,8 +2413,6 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	struct mmc_blk_data *md;
 	int devidx, ret;
 	char cap_str[10];
-	bool cache_enabled = false;
-	bool fua_enabled = false;
 
 	devidx = ida_simple_get(&mmc_blk_ida, 0, max_devices, GFP_KERNEL);
 	if (devidx < 0) {
@@ -2494,17 +2492,13 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 			md->flags |= MMC_BLK_CMD23;
 	}
 
-	if (md->flags & MMC_BLK_CMD23 &&
+	if (mmc_card_mmc(card) &&
+	    md->flags & MMC_BLK_CMD23 &&
 	    ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
 	     card->ext_csd.rel_sectors)) {
 		md->flags |= MMC_BLK_REL_WR;
-		fua_enabled = true;
-		cache_enabled = true;
+		blk_queue_write_cache(md->queue.queue, true, true);
 	}
-	if (mmc_cache_enabled(card->host))
-		cache_enabled  = true;
-
-	blk_queue_write_cache(md->queue.queue, cache_enabled, fua_enabled);
 
 	string_get_size((u64)size, 512, STRING_UNITS_2,
 			cap_str, sizeof(cap_str));
-- 
2.39.2

