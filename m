From: Oliver Metz <oliver@freetz.org>
Subject: [PATCH 2/2] Don't use u8 for fields with more than 1 byte
Date: Mon, 23 Sep 2013 08:40:52 +0200
Message-ID: <1379918452-25211-2-git-send-email-oliver@freetz.org>
References: <1379918452-25211-1-git-send-email-oliver@freetz.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dd12814.kasserver.com ([85.13.134.252]:38453 "EHLO
	dd12814.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234Ab3IWGsh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Sep 2013 02:48:37 -0400
In-Reply-To: <1379918452-25211-1-git-send-email-oliver@freetz.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ben.l.gardiner@gmail.com

Signed-off-by: Oliver Metz <oliver@freetz.org>
---
 mmc_cmds.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index f3f6c03..145faa4 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -700,6 +700,7 @@ int do_read_smart_status(int nargs, char **argv)
 int do_read_extcsd(int nargs, char **argv)
 {
 	__u8 ext_csd[512], ext_csd_rev, reg;
+	__u32 regl;
 	int fd, ret;
 	char *device;
 	const char *str;
@@ -1005,15 +1006,15 @@ int do_read_extcsd(int nargs, char **argv)
 		else
 			printf(" Device cannot have enhanced tech.\n");
 
-		reg = (ext_csd[EXT_CSD_MAX_ENH_SIZE_MULT_2] << 16) |
+		regl = (ext_csd[EXT_CSD_MAX_ENH_SIZE_MULT_2] << 16) |
 			(ext_csd[EXT_CSD_MAX_ENH_SIZE_MULT_1] << 8) |
 			ext_csd[EXT_CSD_MAX_ENH_SIZE_MULT_0];
 
 		printf("Max Enhanced Area Size [MAX_ENH_SIZE_MULT]: 0x%06x\n",
-			   reg);
+			   regl);
 		unsigned int wp_sz = get_hc_wp_grp_size(ext_csd);
 		unsigned int erase_sz = get_hc_erase_grp_size(ext_csd);
-		printf(" i.e. %lu KiB\n", 512l * reg * wp_sz * erase_sz);
+		printf(" i.e. %lu KiB\n", 512l * regl * wp_sz * erase_sz);
 
 		printf("Partitions attribute [PARTITIONS_ATTRIBUTE]: 0x%02x\n",
 			ext_csd[EXT_CSD_PARTITIONS_ATTRIBUTE]);
@@ -1036,23 +1037,23 @@ int do_read_extcsd(int nargs, char **argv)
 		printf(" [GP_SIZE_MULT_1]: 0x%06x\n", (ext_csd[145] << 16) |
 			   (ext_csd[144] << 8) | ext_csd[143]);
 
-		reg =	(ext_csd[EXT_CSD_ENH_SIZE_MULT_2] << 16) |
+		regl =	(ext_csd[EXT_CSD_ENH_SIZE_MULT_2] << 16) |
 			(ext_csd[EXT_CSD_ENH_SIZE_MULT_1] << 8) |
 			ext_csd[EXT_CSD_ENH_SIZE_MULT_0];
 		printf("Enhanced User Data Area Size"
-			" [ENH_SIZE_MULT]: 0x%06x\n", reg);
-		printf(" i.e. %lu KiB\n", 512l * reg *
+			" [ENH_SIZE_MULT]: 0x%06x\n", regl);
+		printf(" i.e. %lu KiB\n", 512l * regl *
 		       get_hc_erase_grp_size(ext_csd) *
 		       get_hc_wp_grp_size(ext_csd));
 
-		reg =	(ext_csd[EXT_CSD_ENH_START_ADDR_3] << 24) |
+		regl =	(ext_csd[EXT_CSD_ENH_START_ADDR_3] << 24) |
 			(ext_csd[EXT_CSD_ENH_START_ADDR_2] << 16) |
 			(ext_csd[EXT_CSD_ENH_START_ADDR_1] << 8) |
 			ext_csd[EXT_CSD_ENH_START_ADDR_0];
 		printf("Enhanced User Data Start Address"
-			" [ENH_START_ADDR]: 0x%06x\n", reg);
+			" [ENH_START_ADDR]: 0x%06x\n", regl);
 		printf(" i.e. %lu bytes offset\n", (is_blockaddresed(ext_csd) ?
-				1l : 512l) * reg);
+				1l : 512l) * regl);
 
 		/* A441]: reserved [135] */
 		printf("Bad Block Management mode"
-- 
1.8.4

