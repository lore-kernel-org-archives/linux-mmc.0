From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: core: remove redundant memset of mmc_decode_cid
Date: Sat, 12 Mar 2016 00:35:45 +0800
Message-ID: <1457714145-6958-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:54058 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932410AbcCKQn5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Mar 2016 11:43:57 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>

When initializing sd or sdio card, we get struct mmc_card
from mmc_alloc_card which allocates it by kzalloc. So we don't
need another memset while decoding cid.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/sd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index bb39a29..b95bd24 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -74,8 +74,6 @@ void mmc_decode_cid(struct mmc_card *card)
 {
 	u32 *resp = card->raw_cid;
 
-	memset(&card->cid, 0, sizeof(struct mmc_cid));
-
 	/*
 	 * SD doesn't currently have a version field so we will
 	 * have to assume we can parse this.
-- 
2.3.7


