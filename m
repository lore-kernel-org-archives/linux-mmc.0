From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [patch] workaround of 1-bit mmc card in case cmd19 & cmd 14 not supported
Date: Thu, 16 Dec 2010 22:21:13 -0500
Message-ID: <AANLkTim8BAxZE9SFigp3WD68qgMAWUpOABo4-dwsfv7N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:60499 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab0LQDVO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Dec 2010 22:21:14 -0500
Received: by fxm18 with SMTP id 18so250919fxm.2
        for <linux-mmc@vger.kernel.org>; Thu, 16 Dec 2010 19:21:13 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

If controller does not support cmd19 & cmd14, here is workaround we using.
Send just in case somebody require.

>From b95c5e8d1c5b42a149a521c4992dfd8fc8d61143 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Thu, 16 Dec 2010 22:28:40 -0500
Subject: [PATCH] mmc: workaround of 1-bit mmc card

	In case controller does not support cmd19 & cmd14.
	Use workaround to decrease bus width when error happen via reading
partition table

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mmc/card/block.c |   28 ++++++++++++++++++++++++++++
 include/linux/mmc/host.h |    2 ++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 217f820..c0d2b73 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -432,6 +432,34 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue
*mq, struct request *req)
 		 * programming mode even when things go wrong.
 		 */
 		if (brq.cmd.error || brq.data.error || brq.stop.error) {
+			if (mmc_card_mmc(card)) {
+				u8 width = card->host->ios.bus_width;
+
+				if (width == MMC_BUS_WIDTH_4) {
+					printk(KERN_WARNING "%s: "
+						"retrying using 1 BIT WIDTH \n",
+						req->rq_disk->disk_name);
+					mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+							EXT_CSD_BUS_WIDTH,
+							EXT_CSD_BUS_WIDTH_1);
+
+					mmc_set_bus_width(card->host,
+							MMC_BUS_WIDTH_1);
+					continue;
+				}
+				if (width == MMC_BUS_WIDTH_8) {
+					printk(KERN_WARNING "%s: "
+						"retrying using 4 BIT WIDTH \n",
+						req->rq_disk->disk_name);
+					mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+						EXT_CSD_BUS_WIDTH,
+						EXT_CSD_BUS_WIDTH_4);
+
+					mmc_set_bus_width(card->host,
+						MMC_BUS_WIDTH_4);
+					continue;
+				}
+			}
 			if (brq.data.blocks > 1 && rq_data_dir(req) == READ) {
 				/* Redo read one sector at a time */
 				printk(KERN_WARNING "%s: retrying using single "
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 4a9d9d2..2a2c1ab 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -249,6 +249,8 @@ extern struct mmc_host *mmc_alloc_host(int extra,
struct device *);
 extern int mmc_add_host(struct mmc_host *);
 extern void mmc_remove_host(struct mmc_host *);
 extern void mmc_free_host(struct mmc_host *);
+extern int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value);
+extern void mmc_set_bus_width(struct mmc_host *host, unsigned int width);

 static inline void *mmc_priv(struct mmc_host *host)
 {
-- 
1.7.0.4
