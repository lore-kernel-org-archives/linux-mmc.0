From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 1/1] mmc: core: fix build warning
Date: Wed, 30 Oct 2013 22:13:00 +0800
Message-ID: <1383142380-25091-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:28491 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753317Ab3J3Ob6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2013 10:31:58 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, b29396@freescale.com, wsa@the-dreams.de

drivers/mmc/core/mmc_ops.c: In function '__mmc_switch':
drivers/mmc/core/mmc_ops.c:484:11: warning: 'status' may be used uninitialized in this function [-Wuninitialized]

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/core/mmc_ops.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index aae8d8b..651260c 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -414,7 +414,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	int err;
 	struct mmc_command cmd = {0};
 	unsigned long timeout;
-	u32 status;
+	u32 uninitialized_var(status);
 	bool ignore_crc = false;
 
 	BUG_ON(!card);
-- 
1.7.2.rc3


