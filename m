From: Mario Schuknecht <mario.schuknecht@dresearch-fe.de>
Subject: [PATCH] mmc-utils: small fixes of output
Date: Wed, 15 May 2013 08:28:04 +0200
Message-ID: <1368599284-28499-1-git-send-email-mario.schuknecht@dresearch-fe.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from zk223.dresearch-fe.de ([217.92.177.116]:47759 "EHLO
	zk223.dresearch-fe.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754960Ab3EOGiF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 May 2013 02:38:05 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, Mario Schuknecht <mario.schuknecht@dresearch-fe.de>

Improve "extcsd read" output of the registers.
Right-shift by 3 of EXT_CSD_BOOT_CFG_EN bits.
Expand the EXT_CSD_BOOT_CFG_ACC bit mask to 0x7.
Add case 3 RPMB partition.

Signed-off-by: Mario Schuknecht <mario.schuknecht@dresearch-fe.de>
---
 mmc.h      |    2 +-
 mmc_cmds.c |    7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/mmc.h b/mmc.h
index c863751..a01c079 100644
--- a/mmc.h
+++ b/mmc.h
@@ -70,7 +70,7 @@
 #define EXT_CSD_BOOT_INFO_ALT		(1<<0)
 #define EXT_CSD_BOOT_CFG_ACK		(1<<6)
 #define EXT_CSD_BOOT_CFG_EN		(0x38)
-#define EXT_CSD_BOOT_CFG_ACC		(0x03)
+#define EXT_CSD_BOOT_CFG_ACC		(0x07)
 #define EXT_CSD_RST_N_EN_MASK		(0x03)
 #define EXT_CSD_HW_RESET_EN		(0x01)
 #define EXT_CSD_HW_RESET_DIS		(0x02)
diff --git a/mmc_cmds.c b/mmc_cmds.c
index b407f65..96a1cb5 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -613,7 +613,7 @@ int do_read_extcsd(int nargs, char **argv)
 		ext_csd[181]);
 	reg = ext_csd[EXT_CSD_BOOT_CFG];
 	printf("Boot configuration bytes [PARTITION_CONFIG: 0x%02x]\n", reg);
-	switch (reg & EXT_CSD_BOOT_CFG_EN) {
+	switch ((reg & EXT_CSD_BOOT_CFG_EN)>>3) {
 	case 0x0:
 		printf(" Not boot enable\n");
 		break;
@@ -637,8 +637,11 @@ int do_read_extcsd(int nargs, char **argv)
 	case 0x2:
 		printf(" R/W Boot Partition 2\n");
 		break;
+	case 0x3:
+		printf(" R/W Replay Protected Memory Block (RPMB)\n");
+		break;
 	default:
-		printf(" Access to General Purpuse partition %d\n",
+		printf(" Access to General Purpose partition %d\n",
 			(reg & EXT_CSD_BOOT_CFG_ACC) - 3);
 		break;
 	}
-- 
1.7.9.5

