From: Ben Gardiner <ben.l.gardiner@gmail.com>
Subject: [PATCH 2/3] pretty print write reliability settings
Date: Thu, 19 Sep 2013 11:14:28 -0400
Message-ID: <be5cb909791ab0d92c04c8e8a2462c661da57f27.1379602866.git.ben.l.gardiner@gmail.com>
References: <cover.1379602866.git.ben.l.gardiner@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qe0-f54.google.com ([209.85.128.54]:50302 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662Ab3ISPOl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Sep 2013 11:14:41 -0400
Received: by mail-qe0-f54.google.com with SMTP id cy11so5911096qeb.27
        for <linux-mmc@vger.kernel.org>; Thu, 19 Sep 2013 08:14:40 -0700 (PDT)
In-Reply-To: <cover.1379602866.git.ben.l.gardiner@gmail.com>
In-Reply-To: <cover.1379602866.git.ben.l.gardiner@gmail.com>
References: <cover.1379602866.git.ben.l.gardiner@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org

Signed-off-by: Ben Gardiner <ben.l.gardiner@gmail.com>
---
 mmc.h      |  1 +
 mmc_cmds.c | 26 ++++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/mmc.h b/mmc.h
index ad07b44..72baab8 100644
--- a/mmc.h
+++ b/mmc.h
@@ -46,6 +46,7 @@
 #define EXT_CSD_PART_CONFIG		179
 #define EXT_CSD_ERASE_GROUP_DEF		175
 #define EXT_CSD_BOOT_WP			173
+#define EXT_CSD_WR_REL_SET			167
 #define EXT_CSD_WR_REL_PARAM		166
 #define EXT_CSD_SANITIZE_START		165
 #define EXT_CSD_BKOPS_EN		163	/* R/W */
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 5ea19ac..7874b23 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -917,10 +917,32 @@ int do_read_extcsd(int nargs, char **argv)
 		/* A441]: reserved [170] */
 		printf("FW configuration [FW_CONFIG]: 0x%02x\n", ext_csd[169]);
 		printf("RPMB Size [RPMB_SIZE_MULT]: 0x%02x\n", ext_csd[168]);
+
+		reg = ext_csd[EXT_CSD_WR_REL_SET];
+		const char * const fast = "existing data is at risk if a power "
+				"failure occurs during a write operation";
+		const char * const reliable = "the device protects existing "
+				"data if a power failure occurs during a write "
+				"operation";
 		printf("Write reliability setting register"
-			" [WR_REL_SET]: 0x%02x\n", ext_csd[167]);
+			" [WR_REL_SET]: 0x%02x\n", reg);
+
+		printf(" user area: %s\n", reg & (1<<0) ? reliable : fast);
+		int i;
+		for (i = 1; i <= 4; i++) {
+			printf(" partition %d: %s\n", i,
+				reg & (1<<i) ? reliable : fast);
+		}
+
+		reg = ext_csd[EXT_CSD_WR_REL_PARAM];
 		printf("Write reliability parameter register"
-			" [WR_REL_PARAM]: 0x%02x\n", ext_csd[166]);
+			" [WR_REL_PARAM]: 0x%02x\n", reg);
+		if (reg & 0x01)
+			printf(" Device supports writing EXT_CSD_WR_REL_SET\n");
+		if (reg & 0x04)
+			printf(" Device supports the enhanced def. of reliable "
+				"write\n");
+
 		/* sanitize_start ext_csd[165]]: not readable
 		 * bkops_start ext_csd[164]]: only writable */
 		printf("Enable background operations handshake"
-- 
1.8.1.2

