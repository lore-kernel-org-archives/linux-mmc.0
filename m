From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH 6/8] report if card is block-addressed and effect on ENH_START_ADDR
Date: Thu, 30 May 2013 17:12:49 -0400
Message-ID: <e433a47d4c420bf7f35f41574c955dda9a28fa42.1369947867.git.bengardiner@nanometrics.ca>
References: <cover.1369947867.git.bengardiner@nanometrics.ca>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:44665 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758343Ab3E3VNQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 May 2013 17:13:16 -0400
Received: by mail-ie0-f169.google.com with SMTP id u16so1974979iet.0
        for <linux-mmc@vger.kernel.org>; Thu, 30 May 2013 14:13:16 -0700 (PDT)
In-Reply-To: <cover.1369947867.git.bengardiner@nanometrics.ca>
In-Reply-To: <cover.1369947867.git.bengardiner@nanometrics.ca>
References: <cover.1369947867.git.bengardiner@nanometrics.ca>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 mmc.h      |    4 ++++
 mmc_cmds.c |   28 +++++++++++++++++++++++++---
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/mmc.h b/mmc.h
index fa46c3a..bedde31 100644
--- a/mmc.h
+++ b/mmc.h
@@ -35,6 +35,10 @@
 #define EXT_CSD_HPI_FEATURE		503
 #define EXT_CSD_BKOPS_SUPPORT		502	/* RO */
 #define EXT_CSD_BOOT_INFO		228	/* R/W */
+#define EXT_CSD_SEC_COUNT_3		215
+#define EXT_CSD_SEC_COUNT_2		214
+#define EXT_CSD_SEC_COUNT_1		213
+#define EXT_CSD_SEC_COUNT_0		212
 #define EXT_CSD_PART_SWITCH_TIME	199
 #define EXT_CSD_BOOT_CFG		179
 #define EXT_CSD_PART_CONFIG		179
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 21d5b4f..149c904 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -424,6 +424,21 @@ int do_status_get(int nargs, char **argv)
 	return ret;
 }
 
+unsigned int get_sector_count(__u8 *ext_csd)
+{
+	return (ext_csd[EXT_CSD_SEC_COUNT_3] << 24) |
+	(ext_csd[EXT_CSD_SEC_COUNT_2] << 16) |
+	(ext_csd[EXT_CSD_SEC_COUNT_1] << 8)  |
+	ext_csd[EXT_CSD_SEC_COUNT_0];
+}
+
+int is_blockaddresed(__u8 *ext_csd)
+{
+	unsigned int sectors = get_sector_count(ext_csd);
+
+	return (sectors > (2u * 1024 * 1024 * 1024) / 512);
+}
+
 int do_read_extcsd(int nargs, char **argv)
 {
 	__u8 ext_csd[512], ext_csd_rev, reg;
@@ -591,9 +606,14 @@ int do_read_extcsd(int nargs, char **argv)
 	/* A441/A43: reserved [218] */
 	printf("Sleep/awake timeout [S_A_TIMEOUT: 0x%02x]\n", ext_csd[217]);
 	/* A441/A43: reserved [216] */
-	printf("Sector Count [SEC_COUNT: 0x%08x]\n", (ext_csd[215] << 24) |
-		      (ext_csd[214] << 16) | (ext_csd[213] << 8)  |
-		      ext_csd[212]);
+
+	unsigned int sectors =	get_sector_count(ext_csd);
+	printf("Sector Count [SEC_COUNT: 0x%08x]\n", sectors);
+	if (is_blockaddresed(ext_csd))
+		printf(" Device is block-addressed\n");
+	else
+		printf(" Device is NOT block-addressed\n");
+
 	/* A441/A43: reserved [211] */
 	printf("Minimum Write Performance for 8bit:\n");
 	printf(" [MIN_PERF_W_8_52: 0x%02x]\n", ext_csd[210]);
@@ -763,6 +783,8 @@ int do_read_extcsd(int nargs, char **argv)
 			ext_csd[EXT_CSD_ENH_START_ADDR_0];
 		printf("Enhanced User Data Start Address"
 			" [ENH_START_ADDR]: 0x%06x\n", reg);
+		printf(" i.e. %lu bytes offset\n", (is_blockaddresed(ext_csd) ?
+				1l : 512l) * reg);
 
 		/* A441]: reserved [135] */
 		printf("Bad Block Management mode"
-- 
1.7.3.5

