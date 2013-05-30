From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH 2/8] extract definitions for EXT_CSD register EXT_CSD_PARTITIONING_SUPPORT
Date: Thu, 30 May 2013 17:12:45 -0400
Message-ID: <6a5d8577ff57538e9186784f4ecd839c47fd38a2.1369947867.git.bengardiner@nanometrics.ca>
References: <cover.1369947867.git.bengardiner@nanometrics.ca>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35685 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758273Ab3E3VNK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 May 2013 17:13:10 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so1928276iec.36
        for <linux-mmc@vger.kernel.org>; Thu, 30 May 2013 14:13:10 -0700 (PDT)
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
 mmc_cmds.c |    6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/mmc.h b/mmc.h
index c863751..47ef8ea 100644
--- a/mmc.h
+++ b/mmc.h
@@ -40,6 +40,7 @@
 #define EXT_CSD_WR_REL_PARAM		166
 #define EXT_CSD_BKOPS_EN		163	/* R/W */
 #define EXT_CSD_RST_N_FUNCTION		162	/* R/W */
+#define EXT_CSD_PARTITIONING_SUPPORT	160	/* RO */
 #define EXT_CSD_NATIVE_SECTOR_SIZE	63 /* R */
 #define EXT_CSD_USE_NATIVE_SECTOR	62 /* R/W */
 #define EXT_CSD_DATA_SECTOR_SIZE	61 /* R */
@@ -79,6 +80,8 @@
 #define EXT_CSD_PART_CONFIG_ACC_BOOT1	  (0x2)
 #define EXT_CSD_PART_CONFIG_ACC_USER_AREA (0x7)
 #define EXT_CSD_PART_CONFIG_ACC_ACK	  (0x40)
+#define EXT_CSD_PARTITIONING_EN		(1<<0)
+#define EXT_CSD_ENH_ATTRIBUTE_EN	(1<<1)
 
 /* From kernel linux/mmc/core.h */
 #define MMC_RSP_PRESENT	(1 << 0)
diff --git a/mmc_cmds.c b/mmc_cmds.c
index b407f65..8cf6e89 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -670,14 +670,14 @@ int do_read_extcsd(int nargs, char **argv)
 		printf("H/W reset function"
 			" [RST_N_FUNCTION]: 0x%02x\n", ext_csd[162]);
 		printf("HPI management [HPI_MGMT]: 0x%02x\n", ext_csd[161]);
-		reg = ext_csd[160];
+		reg = ext_csd[EXT_CSD_PARTITIONING_SUPPORT];
 		printf("Partitioning Support [PARTITIONING_SUPPORT]: 0x%02x\n",
 			reg);
-		if (reg & 0x1)
+		if (reg & EXT_CSD_PARTITIONING_EN)
 			printf(" Device support partitioning feature\n");
 		else
 			printf(" Device NOT support partitioning feature\n");
-		if (reg & 0x2)
+		if (reg & EXT_CSD_ENH_ATTRIBUTE_EN)
 			printf(" Device can have enhanced tech.\n");
 		else
 			printf(" Device cannot have enhanced tech.\n");
-- 
1.7.3.5

