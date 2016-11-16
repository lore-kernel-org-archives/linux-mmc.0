From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/9] mmc: core: Remove redundant __mmc_send_status()
Date: Wed, 16 Nov 2016 11:51:14 +0100
Message-ID: <1479293481-20186-3-git-send-email-ulf.hansson@linaro.org>
References: <1479293481-20186-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37775 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754180AbcKPKvh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2016 05:51:37 -0500
Received: by mail-wm0-f44.google.com with SMTP id t79so63886406wmt.0
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2016 02:51:36 -0800 (PST)
In-Reply-To: <1479293481-20186-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>

There are only one users left which calls __mmc_send_status(). Moreover,
the ignore_crc parameter isn't being used, so let's just remove these
redundant parts.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 4773c56..0515748 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -54,8 +54,7 @@
 	0xff, 0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee,
 };
 
-static inline int __mmc_send_status(struct mmc_card *card, u32 *status,
-				    bool ignore_crc)
+int mmc_send_status(struct mmc_card *card, u32 *status)
 {
 	int err;
 	struct mmc_command cmd = {0};
@@ -67,8 +66,6 @@ static inline int __mmc_send_status(struct mmc_card *card, u32 *status,
 	if (!mmc_host_is_spi(card->host))
 		cmd.arg = card->rca << 16;
 	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
-	if (ignore_crc)
-		cmd.flags &= ~MMC_RSP_CRC;
 
 	err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
 	if (err)
@@ -83,11 +80,6 @@ static inline int __mmc_send_status(struct mmc_card *card, u32 *status,
 	return 0;
 }
 
-int mmc_send_status(struct mmc_card *card, u32 *status)
-{
-	return __mmc_send_status(card, status, false);
-}
-
 static int _mmc_select_card(struct mmc_host *host, struct mmc_card *card)
 {
 	struct mmc_command cmd = {0};
-- 
1.9.1

