From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH 7/8] print KiB sizes for some fields
Date: Thu, 30 May 2013 17:12:50 -0400
Message-ID: <2c03f113553ff8b20af216559bfa7b149de3f684.1369947867.git.bengardiner@nanometrics.ca>
References: <cover.1369947867.git.bengardiner@nanometrics.ca>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:48763 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758369Ab3E3VNR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 May 2013 17:13:17 -0400
Received: by mail-ie0-f180.google.com with SMTP id b11so1893401iee.39
        for <linux-mmc@vger.kernel.org>; Thu, 30 May 2013 14:13:17 -0700 (PDT)
In-Reply-To: <cover.1369947867.git.bengardiner@nanometrics.ca>
In-Reply-To: <cover.1369947867.git.bengardiner@nanometrics.ca>
References: <cover.1369947867.git.bengardiner@nanometrics.ca>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 mmc.h      |    3 +++
 mmc_cmds.c |   40 ++++++++++++++++++++++++++++++++++------
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/mmc.h b/mmc.h
index bedde31..5385e0e 100644
--- a/mmc.h
+++ b/mmc.h
@@ -48,6 +48,9 @@
 #define EXT_CSD_RST_N_FUNCTION		162	/* R/W */
 #define EXT_CSD_PARTITIONING_SUPPORT	160	/* RO */
 #define EXT_CSD_PARTITION_SETTING_COMPLETED	155	/* R/W */
+#define EXT_CSD_ENH_SIZE_MULT_2		142
+#define EXT_CSD_ENH_SIZE_MULT_1		141
+#define EXT_CSD_ENH_SIZE_MULT_0		140
 #define EXT_CSD_ENH_START_ADDR_3	139
 #define EXT_CSD_ENH_START_ADDR_2	138
 #define EXT_CSD_ENH_START_ADDR_1	137
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 149c904..37bb211 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -439,6 +439,16 @@ int is_blockaddresed(__u8 *ext_csd)
 	return (sectors > (2u * 1024 * 1024 * 1024) / 512);
 }
 
+unsigned int get_hc_wp_grp_size(__u8 *ext_csd)
+{
+	return ext_csd[221];
+}
+
+unsigned int get_hc_erase_grp_size(__u8 *ext_csd)
+{
+	return ext_csd[224];
+}
+
 int do_read_extcsd(int nargs, char **argv)
 {
 	__u8 ext_csd[512], ext_csd_rev, reg;
@@ -593,14 +603,22 @@ int do_read_extcsd(int nargs, char **argv)
 	/* A441/A43: reserved [227] */
 	printf("Boot partition size [BOOT_SIZE_MULTI: 0x%02x]\n", ext_csd[226]);
 	printf("Access size [ACC_SIZE: 0x%02x]\n", ext_csd[225]);
+
+	reg = get_hc_erase_grp_size(ext_csd);
 	printf("High-capacity erase unit size [HC_ERASE_GRP_SIZE: 0x%02x]\n",
-		ext_csd[224]);
+		reg);
+	printf(" i.e. %u KiB\n", 512 * reg);
+
 	printf("High-capacity erase timeout [ERASE_TIMEOUT_MULT: 0x%02x]\n",
 		ext_csd[223]);
 	printf("Reliable write sector count [REL_WR_SEC_C: 0x%02x]\n",
 		ext_csd[222]);
+
+	reg = get_hc_wp_grp_size(ext_csd);
 	printf("High-capacity W protect group size [HC_WP_GRP_SIZE: 0x%02x]\n",
-		ext_csd[221]);
+		reg);
+	printf(" i.e. %lu KiB\n", 512l * get_hc_erase_grp_size(ext_csd) * reg);
+
 	printf("Sleep current (VCC) [S_C_VCC: 0x%02x]\n", ext_csd[220]);
 	printf("Sleep current (VCCQ) [S_C_VCCQ: 0x%02x]\n", ext_csd[219]);
 	/* A441/A43: reserved [218] */
@@ -749,9 +767,14 @@ int do_read_extcsd(int nargs, char **argv)
 		else
 			printf(" Device cannot have enhanced tech.\n");
 
+		reg = (ext_csd[159] << 16) | (ext_csd[158] << 8) |
+			ext_csd[157];
 		printf("Max Enhanced Area Size [MAX_ENH_SIZE_MULT]: 0x%06x\n",
-			   (ext_csd[159] << 16) | (ext_csd[158] << 8) |
-			    ext_csd[157]);
+			   reg);
+		unsigned int wp_sz = get_hc_wp_grp_size(ext_csd);
+		unsigned int erase_sz = get_hc_erase_grp_size(ext_csd);
+		printf(" i.e. %lu KiB\n", 512l * reg * wp_sz * erase_sz);
+
 		printf("Partitions attribute [PARTITIONS_ATTRIBUTE]: 0x%02x\n",
 			ext_csd[156]);
 		reg = ext_csd[EXT_CSD_PARTITION_SETTING_COMPLETED];
@@ -773,9 +796,14 @@ int do_read_extcsd(int nargs, char **argv)
 		printf(" [GP_SIZE_MULT_1]: 0x%06x\n", (ext_csd[145] << 16) |
 			   (ext_csd[144] << 8) | ext_csd[143]);
 
+		reg =	(ext_csd[EXT_CSD_ENH_SIZE_MULT_2] << 16) |
+			(ext_csd[EXT_CSD_ENH_SIZE_MULT_1] << 8) |
+			ext_csd[EXT_CSD_ENH_SIZE_MULT_0];
 		printf("Enhanced User Data Area Size"
-			" [ENH_SIZE_MULT]: 0x%06x\n", (ext_csd[142] << 16) |
-			(ext_csd[141] << 8) | ext_csd[140]);
+			" [ENH_SIZE_MULT]: 0x%06x\n", reg);
+		printf(" i.e. %lu KiB\n", 512l * reg *
+		       get_hc_erase_grp_size(ext_csd) *
+		       get_hc_wp_grp_size(ext_csd));
 
 		reg =	(ext_csd[EXT_CSD_ENH_START_ADDR_3] << 24) |
 			(ext_csd[EXT_CSD_ENH_START_ADDR_2] << 16) |
-- 
1.7.3.5

