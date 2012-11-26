From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH] Powerpc eSDHC: Convert the cmd_timeou_ms to u64 to avoid overflow
Date: Mon, 26 Nov 2012 16:35:58 +0800
Message-ID: <1353918959-12146-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:34603
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754058Ab2KZI4M (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Nov 2012 03:56:12 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Haijun Zhang <Haijun.Zhang@freescale.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Chris Ball <cjb@laptop.org>

Convert the cmd_timeou_ms to u64 to avoid overflow

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
CC: Anton Vorontsov <cbouatmailru@gmail.com>
CC: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/card/block.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 21056b9..51903de 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -469,7 +469,8 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 			 *     mrq.data = NULL;
 			 *     cmd.cmd_timeout = idata->ic.cmd_timeout_ms;
 			 */
-			data.timeout_ns = idata->ic.cmd_timeout_ms * 1000000;
+			data.timeout_ns = (u64)idata->ic.cmd_timeout_ms *
+						1000000;
 		}
 
 		mrq.data = &data;
-- 
1.7.0.4


