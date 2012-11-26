From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 1/2 V2] mmc:block : Convert the cmd_timeou_ms to u64 to avoid overflow
Date: Mon, 26 Nov 2012 17:34:41 +0800
Message-ID: <1353922482-25739-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:20484
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753671Ab2KZJzR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Nov 2012 04:55:17 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Haijun Zhang <Haijun.Zhang@freescale.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Chris Ball <cjb@laptop.org>

Convert the cmd_timeou_ms to u64 to avoid overflow

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
Reviewed-by: Anton Vorontsov <cbouatmailru@gmail.com>
CC: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/card/block.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 21056b9..29887b1 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -469,7 +469,8 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 			 *     mrq.data = NULL;
 			 *     cmd.cmd_timeout = idata->ic.cmd_timeout_ms;
 			 */
-			data.timeout_ns = idata->ic.cmd_timeout_ms * 1000000;
+			data.timeout_ns = (u64)idata->ic.cmd_timeout_ms *
+					1000000;
 		}
 
 		mrq.data = &data;
-- 
1.7.0.4


