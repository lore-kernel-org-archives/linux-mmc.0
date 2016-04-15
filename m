From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] mmc: drop unnecessary bit checking
Date: Fri, 15 Apr 2016 20:16:12 +0900
Message-ID: <1460718972-17306-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-09.nifty.com ([210.131.2.76]:18105 "EHLO
	conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbcDOLQM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Apr 2016 07:16:12 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Adrian Hunter <adrian.hunter@intel.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, Chaotian Jing <chaotian.jing@mediatek.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>

This if-block is going to call mmc_card_set_blockaddr(), so
mmc_card_blockaddr() right before it is redundant.

I am fixing the block comment style while I am here.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/core/mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4dbe3df..c96bc81 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1483,12 +1483,13 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		if (err)
 			goto free_card;
 
-		/* If doing byte addressing, check if required to do sector
+		/*
+		 * If doing byte addressing, check if required to do sector
 		 * addressing.  Handle the case of <2GB cards needing sector
 		 * addressing.  See section 8.1 JEDEC Standard JED84-A441;
 		 * ocr register has bit 30 set for sector addressing.
 		 */
-		if (!(mmc_card_blockaddr(card)) && (rocr & (1<<30)))
+		if (rocr & BIT(30))
 			mmc_card_set_blockaddr(card);
 
 		/* Erase size depends on CSD and Extended CSD */
-- 
1.9.1

