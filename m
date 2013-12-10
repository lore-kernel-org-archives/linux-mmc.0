From: Abbas Raza <abbas_raza@mentor.com>
Subject: [PATCH] mmc: core: Update ext_csd if touched by ioctl
Date: Tue, 10 Dec 2013 17:58:17 +0500
Message-ID: <1386680297-21695-1-git-send-email-abbas_raza@mentor.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:54032 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331Ab3LJM6b (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2013 07:58:31 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Abbas Raza <Abbas_Raza@mentor.com>, Chris Ball <cjb@laptop.org>, Dirk Behme <dirk.behme@gmail.com>

From: Abbas Raza <Abbas_Raza@mentor.com>

In case an ioctl changes an EXT_CSD register, update the internal ext_csd
data structure, too. Else the driver's internal ext_csd data structure and
the EXT_CSD register content doesn't match any more. In this case additional
ioctls changing the ext_csd would revert the initial one due to the old data
in the driver's internal ext_csd data.

E.g. using the mmc utils utility to enable the bootpart

mmc bootpart enable 1 0 /dev/mmcblk1

correctly writes to the EXT_CSD structure of the device, but
doesn't update

card->ext_csd.part_config

Issuing additional MMC_SWITCH commands afterwards use the then (wrong)
card->ext_csd.part_config. Resulting in an undo of the initial mmc bootpart
enable.

Fix this by updating the ext_csd in case of an EXT_CSD update ioctl.

Cc: Chris Ball <cjb@laptop.org>
Cc: Dirk Behme <dirk.behme@gmail.com>
Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
Signed-off-by: Abbas Raza <Abbas_Raza@mentor.com>
---
 drivers/mmc/card/block.c | 12 ++++++++++++
 drivers/mmc/core/mmc.c   | 31 +++++++++++++++++++++++++------
 include/linux/mmc/mmc.h  |  4 ++++
 3 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index b3f4cfe..a376ad1 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -543,6 +543,18 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev,
 					__func__, status, err);
 	}
 
+	if ((cmd.opcode == MMC_SWITCH) && ((cmd.arg >> 24) & 0x3)) {
+		/*
+		 * In case the IOCTL has modified the EXT_CSD,
+		 * update it, i.e. re-read the EXT_CSD.
+		 */
+		err = mmc_update_ext_csd(card);
+		if (err)
+			dev_err(mmc_dev(card->host),
+				"%s: EXT_CSD update failed, error %d\n",
+					__func__, err);
+	}
+
 cmd_rel_host:
 	mmc_release_host(card->host);
 
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 810860b..023ff85 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -15,7 +15,6 @@
 #include <linux/stat.h>
 
 #include <linux/mmc/host.h>
-#include <linux/mmc/card.h>
 #include <linux/mmc/mmc.h>
 
 #include "core.h"
@@ -268,7 +267,7 @@ static void mmc_select_card_type(struct mmc_card *card)
 /*
  * Decode extended CSD.
  */
-static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
+static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd, bool update)
 {
 	int err = 0, idx;
 	unsigned int part_size;
@@ -347,7 +346,9 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		 * There are two boot regions of equal size, defined in
 		 * multiples of 128K.
 		 */
-		if (ext_csd[EXT_CSD_BOOT_MULT] && mmc_boot_partition_access(card->host)) {
+		if (ext_csd[EXT_CSD_BOOT_MULT] &&
+				mmc_boot_partition_access(card->host) &&
+				!update) {
 			for (idx = 0; idx < MMC_NUM_BOOT_PARTITION; idx++) {
 				part_size = ext_csd[EXT_CSD_BOOT_MULT] << 17;
 				mmc_part_add(card, part_size,
@@ -425,7 +426,8 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 				card->ext_csd.enhanced_area_en = 1;
 			}
 
-			for (idx = 0; idx < MMC_NUM_GP_PARTITION; idx++) {
+			for (idx = 0; !update && idx < MMC_NUM_GP_PARTITION;
+					idx++) {
 				if (!ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3] &&
 				!ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3 + 1] &&
 				!ext_csd[EXT_CSD_GP_SIZE_MULT + idx * 3 + 2])
@@ -509,7 +511,8 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		 * RPMB regions are defined in multiples of 128K.
 		 */
 		card->ext_csd.raw_rpmb_size_mult = ext_csd[EXT_CSD_RPMB_MULT];
-		if (ext_csd[EXT_CSD_RPMB_MULT] && mmc_host_cmd23(card->host)) {
+		if (ext_csd[EXT_CSD_RPMB_MULT] && mmc_host_cmd23(card->host) &&
+		    !update) {
 			mmc_part_add(card, ext_csd[EXT_CSD_RPMB_MULT] << 17,
 				EXT_CSD_PART_CONFIG_ACC_RPMB,
 				"rpmb", 0, false,
@@ -960,7 +963,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		err = mmc_get_ext_csd(card, &ext_csd);
 		if (err)
 			goto free_card;
-		err = mmc_read_ext_csd(card, ext_csd);
+		err = mmc_read_ext_csd(card, ext_csd, 0);
 		if (err)
 			goto free_card;
 
@@ -1503,6 +1506,22 @@ static void mmc_attach_bus_ops(struct mmc_host *host)
 	mmc_attach_bus(host, bus_ops);
 }
 
+int mmc_update_ext_csd(struct mmc_card *card)
+{
+	u8 *new_ext_csd;
+	int err;
+
+	err = mmc_get_ext_csd(card, &new_ext_csd);
+	if (err || new_ext_csd == NULL)
+		goto out;
+
+	err = mmc_read_ext_csd(card, new_ext_csd, 1);
+
+out:
+	mmc_free_ext_csd(new_ext_csd);
+	return err;
+}
+
 /*
  * Starting point for MMC card init.
  */
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 94d532e..8494772 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -24,6 +24,8 @@
 #ifndef LINUX_MMC_MMC_H
 #define LINUX_MMC_MMC_H
 
+#include <linux/mmc/card.h>
+
 /* Standard MMC commands (4.1)           type  argument     response */
    /* class 1 */
 #define MMC_GO_IDLE_STATE         0   /* bc                          */
@@ -407,4 +409,6 @@ struct _mmc_csd {
 #define MMC_SWITCH_MODE_CLEAR_BITS	0x02	/* Clear bits which are 1 in value */
 #define MMC_SWITCH_MODE_WRITE_BYTE	0x03	/* Set target to value */
 
+int mmc_update_ext_csd(struct mmc_card *card);
+
 #endif /* LINUX_MMC_MMC_H */
-- 
1.8.3.2

