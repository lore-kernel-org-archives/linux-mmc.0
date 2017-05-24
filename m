From: Brandon Schaefer <bschaef14@gmail.com>
Subject: [PATCH] mmc ioctl: Notify mmc core of ext_csd change
Date: Wed, 24 May 2017 15:02:30 -0700
Message-ID: <1495663350-93076-1-git-send-email-brandon.schaefer@flukenetworks.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34431 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164318AbdEXWCe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 May 2017 18:02:34 -0400
Received: by mail-pf0-f195.google.com with SMTP id w69so34786751pfk.1
        for <linux-mmc@vger.kernel.org>; Wed, 24 May 2017 15:02:34 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Brandon Schaefer <brandon.schaefer@flukenetworks.com>

Let mmc core know of ext_csd change when userspace utilizes ioctl to
change PARTITION_CONFIG (previously BOOT_CONFIG). Otherwise changing
boot partitions from userspace can be trampled on.

Signed-off-by: Brandon Schaefer <brandon.schaefer@flukenetworks.com>
---
 drivers/mmc/core/block.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 64f9fda..d5b0085 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -63,7 +63,9 @@ MODULE_ALIAS("mmc:block");
 
 #define MMC_BLK_TIMEOUT_MS  (10 * 60 * 1000)        /* 10 minute timeout */
 #define MMC_SANITIZE_REQ_TIMEOUT 240000
-#define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
+#define MMC_EXTRACT_SWITCH_MODE_FROM_ARG(x) (((x) & 0x030F0000) >> 24)
+#define MMC_EXTRACT_INDEX_FROM_ARG(x) (((x) & 0x00FF0000) >> 16)
+#define MMC_EXTRACT_VALUE_FROM_ARG(x) (((x) & 0x00000FF0) >> 8)
 
 #define mmc_req_rel_wr(req)	((req->cmd_flags & REQ_FUA) && \
 				  (rq_data_dir(req) == WRITE))
@@ -517,6 +519,24 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 		return err;
 	}
 
+	if ((MMC_EXTRACT_INDEX_FROM_ARG(cmd.arg) == EXT_CSD_PART_CONFIG) &&
+	    (cmd.opcode == MMC_SWITCH)) {
+		u8 mode = MMC_EXTRACT_SWITCH_MODE_FROM_ARG(cmd.arg);
+		u8 value = MMC_EXTRACT_VALUE_FROM_ARG(cmd.arg);
+
+		switch (mode) {
+		case MMC_SWITCH_MODE_SET_BITS:
+			card->ext_csd.part_config |= value;
+			break;
+		case MMC_SWITCH_MODE_CLEAR_BITS:
+			card->ext_csd.part_config &= ~value;
+			break;
+		case MMC_SWITCH_MODE_WRITE_BYTE:
+			card->ext_csd.part_config = value;
+			break;
+		}
+	}
+
 	mmc_wait_for_req(card->host, &mrq);
 
 	if (cmd.error) {
-- 
2.7.4

