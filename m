From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH 5/8] fix printing ENH_START_ADDR
Date: Thu, 30 May 2013 17:12:48 -0400
Message-ID: <bbb231483b7aaec5b225fbbda381bc97bd1b7939.1369947867.git.bengardiner@nanometrics.ca>
References: <cover.1369947867.git.bengardiner@nanometrics.ca>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:43670 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758308Ab3E3VNO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 May 2013 17:13:14 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so1919821iec.22
        for <linux-mmc@vger.kernel.org>; Thu, 30 May 2013 14:13:14 -0700 (PDT)
In-Reply-To: <cover.1369947867.git.bengardiner@nanometrics.ca>
In-Reply-To: <cover.1369947867.git.bengardiner@nanometrics.ca>
References: <cover.1369947867.git.bengardiner@nanometrics.ca>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org

The enhanced user area start field is 4 bytes long
according to the eMMC 4.41 spec.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 mmc.h      |    4 ++++
 mmc_cmds.c |    8 ++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/mmc.h b/mmc.h
index 3577f42..fa46c3a 100644
--- a/mmc.h
+++ b/mmc.h
@@ -44,6 +44,10 @@
 #define EXT_CSD_RST_N_FUNCTION		162	/* R/W */
 #define EXT_CSD_PARTITIONING_SUPPORT	160	/* RO */
 #define EXT_CSD_PARTITION_SETTING_COMPLETED	155	/* R/W */
+#define EXT_CSD_ENH_START_ADDR_3	139
+#define EXT_CSD_ENH_START_ADDR_2	138
+#define EXT_CSD_ENH_START_ADDR_1	137
+#define EXT_CSD_ENH_START_ADDR_0	136
 #define EXT_CSD_NATIVE_SECTOR_SIZE	63 /* R */
 #define EXT_CSD_USE_NATIVE_SECTOR	62 /* R/W */
 #define EXT_CSD_DATA_SECTOR_SIZE	61 /* R */
diff --git a/mmc_cmds.c b/mmc_cmds.c
index a2ccc1d..21d5b4f 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -756,9 +756,13 @@ int do_read_extcsd(int nargs, char **argv)
 		printf("Enhanced User Data Area Size"
 			" [ENH_SIZE_MULT]: 0x%06x\n", (ext_csd[142] << 16) |
 			(ext_csd[141] << 8) | ext_csd[140]);
+
+		reg =	(ext_csd[EXT_CSD_ENH_START_ADDR_3] << 24) |
+			(ext_csd[EXT_CSD_ENH_START_ADDR_2] << 16) |
+			(ext_csd[EXT_CSD_ENH_START_ADDR_1] << 8) |
+			ext_csd[EXT_CSD_ENH_START_ADDR_0];
 		printf("Enhanced User Data Start Address"
-			" [ENH_START_ADDR]: 0x%06x\n", (ext_csd[139] << 16) |
-			   (ext_csd[138] << 8) | ext_csd[137]);
+			" [ENH_START_ADDR]: 0x%06x\n", reg);
 
 		/* A441]: reserved [135] */
 		printf("Bad Block Management mode"
-- 
1.7.3.5

