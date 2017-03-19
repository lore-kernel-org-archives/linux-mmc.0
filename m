From: "Bean Huo (beanhuo)" <beanhuo@micron.com>
Subject: [PATCH V1] mmc: core: fix still flush cache when eMMC cache off
Date: Sun, 19 Mar 2017 00:45:40 +0000
Message-ID: <4e7d0b4b8df1430698e822b1a36bcc11@SIWEX5A.sing.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout.micron.com ([137.201.242.129]:55529 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751360AbdCSBaU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Mar 2017 21:30:20 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "axboe@fb.com" <axboe@fb.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Bean Huo (beanhuo)" <beanhuo@micron.com>, "Zoltan Szubbocsev (zszubbocsev)" <zszubbocsev@micron.com>

This patch fixes the issue that mmc_blk_issue_rq still
flushes cache when eMMC cache has already been off
through user space tool, such as mmc-utils.
The reason is that card->ext_csd.cache_ctrl isn't reset.

Signed-off-by: beanhuo <beanhuo@micron.com>
---
 drivers/mmc/core/block.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 1621fa0..fb3635ac 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -64,6 +64,7 @@ MODULE_ALIAS("mmc:block");
 #define MMC_BLK_TIMEOUT_MS  (10 * 60 * 1000)        /* 10 minute timeout */
 #define MMC_SANITIZE_REQ_TIMEOUT 240000
 #define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
+#define MMC_EXTRACT_VALUE_FROM_ARG(x) ((x & 0x0000FF00) >> 8)
 
 #define mmc_req_rel_wr(req)	((req->cmd_flags & REQ_FUA) && \
 				  (rq_data_dir(req) == WRITE))
@@ -535,6 +536,14 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 		return data.error;
 	}
 
+	if ((MMC_EXTRACT_INDEX_FROM_ARG(cmd.arg) == EXT_CSD_CACHE_CTRL) &&
+	    (cmd.opcode == MMC_SWITCH) && (card->ext_csd.cache_size > 0)) {
+		if (MMC_EXTRACT_VALUE_FROM_ARG(cmd.arg) & 1)
+			card->ext_csd.cache_ctrl = 1;
+		else
+			card->ext_csd.cache_ctrl = 0;
+	}
+
 	/*
 	 * According to the SD specs, some commands require a delay after
 	 * issuing the command.
-- 
2.7.4
