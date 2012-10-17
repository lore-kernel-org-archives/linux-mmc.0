From: Sangho Yi <antiroot@gmail.com>
Subject: [PATCH 1/3] drivers: mmc: core: sdio.c: fixed lines with > 80 chars
Date: Wed, 17 Oct 2012 23:13:16 +0900
Message-ID: <1350483199-3048-1-git-send-email-antiroot@gmail.com>
References: <n>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59306 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757124Ab2JQOPN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Oct 2012 10:15:13 -0400
In-Reply-To: <n>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: prakity@marvell.com, aaron.lu@amd.com, linus.walleij@linaro.org, ulf.hansson@stericsson.com, cjb@laptop.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Sangho Yi <antiroot@gmail.com>

Fixed coding style warning cases for exceeding 80 chars per line on
sdio.c.

Signed-off-by: Sangho Yi <antiroot@gmail.com>
---
 drivers/mmc/core/sdio.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 2273ce6..14326e8 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -47,7 +47,8 @@ static int sdio_read_fbr(struct sdio_func *func)
 
 	if (data == 0x0f) {
 		ret = mmc_io_rw_direct(func->card, 0, 0,
-			SDIO_FBR_BASE(func->num) + SDIO_FBR_STD_IF_EXT, 0, &data);
+			SDIO_FBR_BASE(func->num) + SDIO_FBR_STD_IF_EXT,
+			0, &data);
 		if (ret)
 			goto out;
 	}
@@ -619,7 +620,8 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 		card->type = MMC_TYPE_SD_COMBO;
 
 		if (oldcard && (oldcard->type != MMC_TYPE_SD_COMBO ||
-		    memcmp(card->raw_cid, oldcard->raw_cid, sizeof(card->raw_cid)) != 0)) {
+			memcmp(card->raw_cid, oldcard->raw_cid,
+			sizeof(card->raw_cid)) != 0)) {
 			mmc_remove_card(card);
 			return -ENOENT;
 		}
-- 
1.7.9.5

