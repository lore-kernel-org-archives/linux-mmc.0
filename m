From: Uri Yanai <uri.yanai@sandisk.com>
Subject: [v3 1/3] mmc: MAN_BKOPS_EN inverse debug message logic
Date: Tue, 7 Feb 2017 18:00:00 +0200
Message-ID: <1486483202-5515-2-git-send-email-uri.yanai@sandisk.com>
References: <1486483202-5515-1-git-send-email-uri.yanai@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:62425 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754626AbdBGQB3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Feb 2017 11:01:29 -0500
In-Reply-To: <1486483202-5515-1-git-send-email-uri.yanai@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, Alex.Lemberg@sandisk.com, Uri Yanai <uri.yanai@sandisk.com>, Alex Lemberg <alex.lemberg@sandisk.com>

Inverse the logic for printing the debug message.
In mmc_decode_ext_csd() print message when MAN_BKOPS_EN is set

Signed-off-by: Uri Yanai <uri.yanai@sandisk.com>
Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>
---
 drivers/mmc/core/mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c0e2507..9d1c149 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -530,8 +530,8 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 						EXT_CSD_MANUAL_BKOPS_MASK);
 			card->ext_csd.raw_bkops_status =
 				ext_csd[EXT_CSD_BKOPS_STATUS];
-			if (!card->ext_csd.man_bkops_en)
-				pr_debug("%s: MAN_BKOPS_EN bit is not set\n",
+			if (card->ext_csd.man_bkops_en)
+				pr_debug("%s: MAN_BKOPS_EN bit is set\n",
 					mmc_hostname(card->host));
 		}
 
-- 
1.9.1

