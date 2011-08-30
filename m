From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH] mmc: core: eMMC4.5 Add the timeout for switch
Date: Tue, 30 Aug 2011 15:52:50 +0530
Message-ID: <1314699770-17120-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38561 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988Ab1H3KW5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Aug 2011 06:22:57 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>

This patch adds the code to handle the default timeout
for switch command.
For eMMC 4.5 devices if timeout is not specified for the switch
command while accessing a specific field,then the default timeout
shall be used to timeout. Specification says there is no timeout
defined while accessing BKOPS_START, SANITIZE_START, FLUSH_CACHE
field(so these fields are excluded).

Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
---
 drivers/mmc/core/mmc.c     |    5 +++++
 drivers/mmc/core/mmc_ops.c |    8 ++++++++
 include/linux/mmc/card.h   |    1 +
 include/linux/mmc/mmc.h    |    4 ++++
 4 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 5700b1c..5b9fb6a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -405,6 +405,11 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 	if (card->ext_csd.rev >= 5)
 		card->ext_csd.rel_param = ext_csd[EXT_CSD_WR_REL_PARAM];
 
+	if (card->ext_csd.rev > 5) {
+		/* (eMMC 4.5)timeout is expressed in units of 10 ms*/
+		card->ext_csd.cmd6_timeout = ext_csd[EXT_CSD_CMD6_TIME]*10;
+	}
+
 	if (ext_csd[EXT_CSD_ERASED_MEM_CONT])
 		card->erased_byte = 0xFF;
 	else
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 770c3d0..c4d82f4 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -394,6 +394,14 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
 	cmd.cmd_timeout_ms = timeout_ms;
 
+	/* timeout is not defined for below command indexes (eMMC 4.5) */
+	if ((timeout_ms == 0)					&&
+		(card->ext_csd->rev > 5)			&&
+		(index != EXT_CSD_BKOPS_START)		&&
+		(index != EXT_CSD_SANITIZE_START)	&&
+		(index != EXT_CSD_FLUSH_CACHE))
+			cmd.cmd_timeout_ms = card->ext_csd->cmd6_timeout;
+
 	err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
 	if (err)
 		return err;
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index b460fc2..ef88412 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -50,6 +50,7 @@ struct mmc_ext_csd {
 	u8			rel_sectors;
 	u8			rel_param;
 	u8			part_config;
+	u8			cmd6_timeout;	/* timeout in ms */
 	unsigned int		part_time;		/* Units: ms */
 	unsigned int		sa_timeout;		/* Units: 100ns */
 	unsigned int		hs_max_dtr;
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 5a794cb..a23f836 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -270,8 +270,11 @@ struct _mmc_csd {
  * EXT_CSD fields
  */
 
+#define EXT_CSD_FLUSH_CACHE		32	/* R/W */
 #define EXT_CSD_PARTITION_ATTRIBUTE	156	/* R/W */
 #define EXT_CSD_PARTITION_SUPPORT	160	/* RO */
+#define EXT_CSD_BKOPS_START		164	/* R/W */
+#define EXT_CSD_SANITIZE_START		165	/* R/W */
 #define EXT_CSD_WR_REL_PARAM		166	/* RO */
 #define EXT_CSD_ERASE_GROUP_DEF		175	/* R/W */
 #define EXT_CSD_PART_CONFIG		179	/* R/W */
@@ -293,6 +296,7 @@ struct _mmc_csd {
 #define EXT_CSD_SEC_ERASE_MULT		230	/* RO */
 #define EXT_CSD_SEC_FEATURE_SUPPORT	231	/* RO */
 #define EXT_CSD_TRIM_MULT		232	/* RO */
+#define EXT_CSD_CMD6_TIME		248	/* RO */
 
 /*
  * EXT_CSD field definitions
-- 
1.7.1

