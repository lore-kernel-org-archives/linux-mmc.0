From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH 3/3] mmc: mmc: fix switch timeout issue caused by jiffies precision
Date: Thu, 19 May 2016 16:47:42 +0800
Message-ID: <1463647662-27426-4-git-send-email-chaotian.jing@mediatek.com>
References: <1463647662-27426-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([210.61.82.184]:47560 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753981AbcESIsX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 May 2016 04:48:23 -0400
In-Reply-To: <1463647662-27426-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>

with CONFIG_HZ=100, the precision of jiffies is 10ms, and the
generic_cmd6_time of some card is also 10ms. then, may be current
time is only 5ms, but already timed out caused by jiffies precision.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/core/mmc_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 32de144..ad6e979 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -534,7 +534,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		timeout_ms = MMC_OPS_TIMEOUT_MS;
 
 	/* Must check status to be sure of no errors. */
-	timeout = jiffies + msecs_to_jiffies(timeout_ms);
+	timeout = jiffies + msecs_to_jiffies(timeout_ms) + 1;
 	do {
 		/*
 		 * Due to the possibility of being preempted after
-- 
1.8.1.1.dirty

