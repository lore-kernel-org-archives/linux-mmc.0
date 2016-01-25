From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] mmc: make MAN_BKOPS_EN message a debug
Date: Mon, 25 Jan 2016 20:18:12 +0100
Message-ID: <1453749492-2064-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:33158 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757451AbcAYTSq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 25 Jan 2016 14:18:46 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Dirk Behme <dirk.behme@gmail.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

IMO this info is only useful for developers. Most users won't need this
information, since there is not much they can do about it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/core/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index bf49e44571f20a..07a135bc893057 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -501,7 +501,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 			card->ext_csd.raw_bkops_status =
 				ext_csd[EXT_CSD_BKOPS_STATUS];
 			if (!card->ext_csd.man_bkops_en)
-				pr_info("%s: MAN_BKOPS_EN bit is not set\n",
+				pr_debug("%s: MAN_BKOPS_EN bit is not set\n",
 					mmc_hostname(card->host));
 		}
 
-- 
2.1.4

