From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH 3/8] extract definitions for EXT_CSD register PARTITION_SETTING_COMPLETED and pretty-print
Date: Thu, 30 May 2013 17:12:46 -0400
Message-ID: <632a4be43200006578b73fddef30aa0de14c25a5.1369947867.git.bengardiner@nanometrics.ca>
References: <cover.1369947867.git.bengardiner@nanometrics.ca>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55780 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758308Ab3E3VNL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 May 2013 17:13:11 -0400
Received: by mail-ie0-f174.google.com with SMTP id aq17so1896210iec.19
        for <linux-mmc@vger.kernel.org>; Thu, 30 May 2013 14:13:11 -0700 (PDT)
In-Reply-To: <cover.1369947867.git.bengardiner@nanometrics.ca>
In-Reply-To: <cover.1369947867.git.bengardiner@nanometrics.ca>
References: <cover.1369947867.git.bengardiner@nanometrics.ca>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 mmc.h      |    1 +
 mmc_cmds.c |    8 +++++++-
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/mmc.h b/mmc.h
index 47ef8ea..3420d7b 100644
--- a/mmc.h
+++ b/mmc.h
@@ -41,6 +41,7 @@
 #define EXT_CSD_BKOPS_EN		163	/* R/W */
 #define EXT_CSD_RST_N_FUNCTION		162	/* R/W */
 #define EXT_CSD_PARTITIONING_SUPPORT	160	/* RO */
+#define EXT_CSD_PARTITION_SETTING_COMPLETED	155	/* R/W */
 #define EXT_CSD_NATIVE_SECTOR_SIZE	63 /* R */
 #define EXT_CSD_USE_NATIVE_SECTOR	62 /* R/W */
 #define EXT_CSD_DATA_SECTOR_SIZE	61 /* R */
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 8cf6e89..dd7498e 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -687,9 +687,15 @@ int do_read_extcsd(int nargs, char **argv)
 			    ext_csd[157]);
 		printf("Partitions attribute [PARTITIONS_ATTRIBUTE]: 0x%02x\n",
 			ext_csd[156]);
+		reg = ext_csd[EXT_CSD_PARTITION_SETTING_COMPLETED];
 		printf("Partitioning Setting"
 			" [PARTITION_SETTING_COMPLETED]: 0x%02x\n",
-			ext_csd[155]);
+			reg);
+		if(reg)
+			printf(" Device partition setting complete\n");
+		else
+			printf(" Device partition setting NOT complete\n");
+
 		printf("General Purpose Partition Size\n"
 			" [GP_SIZE_MULT_4]: 0x%06x\n", (ext_csd[154] << 16) |
 			(ext_csd[153] << 8) | ext_csd[152]);
-- 
1.7.3.5

