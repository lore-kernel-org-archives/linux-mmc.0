From: Bastian Stender <bst@pengutronix.de>
Subject: [PATCH] mmc: block: fix updating ext_csd caches on ioctl call
Date: Thu,  8 Mar 2018 15:08:11 +0100
Message-ID: <20180308140811.6966-1-bst@pengutronix.de>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Marcin Wojtas <mw@semihalf.com>, Seshagiri Holi <sholi@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, kernel@pengutronix.de, Bastian Stender <bst@pengutronix.de>, Jan Luebbe <jlu@pengutronix.de>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

PARTITION_CONFIG is cached in mmc_card->ext_csd.part_config and the
currently active partition in mmc_blk_data->part_curr. These caches do
not always reflect changes if the ioctl call modifies the
PARTITION_CONFIG registers, e.g. by changing BOOT_PARTITION_ENABLE.

Write the PARTITION_CONFIG value extracted from the ioctl call to the
cache and update the currently active partition accordingly. This
ensures that the user space cannot change the values behind the
kernel's back. The next call to mmc_blk_part_switch() will operate on
the data set by the ioctl and reflect the changes appropriately.

Signed-off-by: Bastian Stender <bst@pengutronix.de>
Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Cc: stable@vger.kernel.org
---
 drivers/mmc/core/block.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 20135a5de748..2cfb963d9f37 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -72,6 +72,7 @@ MODULE_ALIAS("mmc:block");
 #define MMC_BLK_TIMEOUT_MS  (10 * 1000)
 #define MMC_SANITIZE_REQ_TIMEOUT 240000
 #define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
+#define MMC_EXTRACT_VALUE_FROM_ARG(x) ((x & 0x0000FF00) >> 8)
 
 #define mmc_req_rel_wr(req)	((req->cmd_flags & REQ_FUA) && \
 				  (rq_data_dir(req) == WRITE))
@@ -586,6 +587,24 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 		return data.error;
 	}
 
+	/*
+	 * Make sure the cache of the PARTITION_CONFIG register and
+	 * PARTITION_ACCESS bits is updated in case the ioctl ext_csd write
+	 * changed it successfully.
+	 */
+	if ((MMC_EXTRACT_INDEX_FROM_ARG(cmd.arg) == EXT_CSD_PART_CONFIG) &&
+	    (cmd.opcode == MMC_SWITCH)) {
+		struct mmc_blk_data *main_md = dev_get_drvdata(&card->dev);
+		u8 value = MMC_EXTRACT_VALUE_FROM_ARG(cmd.arg);
+
+		/*
+		 * Update cache so the next mmc_blk_part_switch call operates
+		 * on up-to-date data.
+		 */
+		card->ext_csd.part_config = value;
+		main_md->part_curr = value & EXT_CSD_PART_CONFIG_ACC_MASK;
+	}
+
 	/*
 	 * According to the SD specs, some commands require a delay after
 	 * issuing the command.
-- 
2.16.1
