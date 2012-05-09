From: Saugata Das <saugata.das@stericsson.com>
Subject: [RFC 1/2] [MMC-4.5] Disable emulation
Date: Wed, 9 May 2012 20:18:20 +0530
Message-ID: <1336574901-26579-1-git-send-email-saugata.das@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:41969 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755190Ab2EIOse (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 May 2012 10:48:34 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: patches@linaro.org, saugata.das@linaro.org

From: Saugata Das <saugata.das@linaro.org>

This patch adds the support for large sector size of 4KB by disabling emulation.
This patch passes eMMC DATA_SECTOR_SIZE as the logical block size during
mmc_blk_alloc_req.

In order to use this patch for 4KB sector size, ensure that USE_NATIVE_SECTOR
is enabled, partition table is 4KB sector size aligned and file system block
size is 4KB.

Signed-off-by: Saugata Das <saugata.das@linaro.org>
---
 drivers/mmc/card/block.c |    6 +++++-
 drivers/mmc/core/mmc.c   |    2 ++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index a7c75d8..0e54118e 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1517,7 +1517,11 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	snprintf(md->disk->disk_name, sizeof(md->disk->disk_name),
 		 "mmcblk%d%s", md->name_idx, subname ? subname : "");
 
-	blk_queue_logical_block_size(md->queue.queue, 512);
+	if (mmc_card_mmc(card))
+		blk_queue_logical_block_size(md->queue.queue,
+			card->ext_csd.data_sector_size);
+	else
+		blk_queue_logical_block_size(md->queue.queue, 512);
 	set_capacity(md->disk, size);
 
 	if (mmc_host_cmd23(card->host)) {
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 02914d6..8dcbe995 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -533,6 +533,8 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		} else {
 			card->ext_csd.data_tag_unit_size = 0;
 		}
+	} else {
+		card->ext_csd.data_sector_size = 512;
 	}
 
 out:
-- 
1.7.4.3

