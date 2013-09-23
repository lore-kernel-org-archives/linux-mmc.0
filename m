From: Oliver Metz <oliver@freetz.org>
Subject: [PATCH 1/2] Add defines for ext_csd field MAX_ENH_SIZE_MULT
Date: Mon, 23 Sep 2013 08:40:51 +0200
Message-ID: <1379918452-25211-1-git-send-email-oliver@freetz.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dd12814.kasserver.com ([85.13.134.252]:38454 "EHLO
	dd12814.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753280Ab3IWGsh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Sep 2013 02:48:37 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ben.l.gardiner@gmail.com

Signed-off-by: Oliver Metz <oliver@freetz.org>
---
 mmc.h      | 3 +++
 mmc_cmds.c | 6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/mmc.h b/mmc.h
index a345c1d..ac82446 100644
--- a/mmc.h
+++ b/mmc.h
@@ -52,6 +52,9 @@
 #define EXT_CSD_BKOPS_EN		163	/* R/W */
 #define EXT_CSD_RST_N_FUNCTION		162	/* R/W */
 #define EXT_CSD_PARTITIONING_SUPPORT	160	/* RO */
+#define EXT_CSD_MAX_ENH_SIZE_MULT_2	159
+#define EXT_CSD_MAX_ENH_SIZE_MULT_1	158
+#define EXT_CSD_MAX_ENH_SIZE_MULT_0	157
 #define EXT_CSD_PARTITIONS_ATTRIBUTE	156	/* R/W */
 #define EXT_CSD_PARTITION_SETTING_COMPLETED	155	/* R/W */
 #define EXT_CSD_ENH_SIZE_MULT_2		142
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 867a88d..f3f6c03 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1005,8 +1005,10 @@ int do_read_extcsd(int nargs, char **argv)
 		else
 			printf(" Device cannot have enhanced tech.\n");
 
-		reg = (ext_csd[159] << 16) | (ext_csd[158] << 8) |
-			ext_csd[157];
+		reg = (ext_csd[EXT_CSD_MAX_ENH_SIZE_MULT_2] << 16) |
+			(ext_csd[EXT_CSD_MAX_ENH_SIZE_MULT_1] << 8) |
+			ext_csd[EXT_CSD_MAX_ENH_SIZE_MULT_0];
+
 		printf("Max Enhanced Area Size [MAX_ENH_SIZE_MULT]: 0x%06x\n",
 			   reg);
 		unsigned int wp_sz = get_hc_wp_grp_size(ext_csd);
-- 
1.8.4

