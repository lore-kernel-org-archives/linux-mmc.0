From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH] mmc: trivial: fix the compiling warning
Date: Tue, 05 Nov 2013 22:26:26 +0900
Message-ID: <003201ceda2a$a1546f70$e3fd4e50$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:47415 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754632Ab3KEN02 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Nov 2013 08:26:28 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MVS004Y1LC3M520@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 05 Nov 2013 22:26:27 +0900 (KST)
In-reply-to: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>, 'Ulf Hansson' <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

Fixed the following warning.

drivers/mmc/core/mmc_ops.c:484:11: warning: 'status' may be used
uninitialized in this function [-Wmaybe-uninitialized]

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/core/mmc_ops.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index aae8d8b..e5b5eeb 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -414,7 +414,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	int err;
 	struct mmc_command cmd = {0};
 	unsigned long timeout;
-	u32 status;
+	u32 status = 0;
 	bool ignore_crc = false;
 
 	BUG_ON(!card);
-- 
1.7.0.4


