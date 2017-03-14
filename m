From: Boris Schmidt <boris.schmidt@siemens.com>
Subject: [PATCH v1 1/1] mmc-utils: feature spec 5.0+, device life time estimation for MLC and pSLC mode
Date: Tue, 14 Mar 2017 14:03:22 +0100
Message-ID: <1489496602-10306-2-git-send-email-boris.schmidt@siemens.com>
References: <1489496602-10306-1-git-send-email-boris.schmidt@siemens.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from thoth.sbs.de ([192.35.17.2]:59716 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751663AbdCNNQl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 14 Mar 2017 09:16:41 -0400
In-Reply-To: <1489496602-10306-1-git-send-email-boris.schmidt@siemens.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Boris Schmidt <boris.schmidt@siemens.com>, Chris Ball <chris@printf.net>

Signed-off-by: Boris Schmidt <boris.schmidt@siemens.com>
---
 mmc.h      |  2 ++
 mmc_cmds.c | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/mmc.h b/mmc.h
index a3d732c..f3fa03f 100644
--- a/mmc.h
+++ b/mmc.h
@@ -61,6 +61,8 @@
 #define EXT_CSD_NUM_OF_FW_SEC_PROG_2	304	/* RO */
 #define EXT_CSD_NUM_OF_FW_SEC_PROG_1	303	/* RO */
 #define EXT_CSD_NUM_OF_FW_SEC_PROG_0	302	/* RO */
+#define EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B 	269	/* RO */
+#define EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A 	268	/* RO */
 #define EXT_CSD_FIRMWARE_VERSION	254	/* RO */
 #define EXT_CSD_CACHE_SIZE_3		252
 #define EXT_CSD_CACHE_SIZE_2		251
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 6b86115..191d456 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1738,6 +1738,17 @@ int do_read_extcsd(int nargs, char **argv)
 			(char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);
 	}
 
+	if (ext_csd_rev >= 7) {
+	printf("eMMC Life Time Estimation A [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]: 0x%02x\n",
+			ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]);
+	}
+
+	if (ext_csd_rev >= 7) {
+	printf("eMMC Life Time Estimation B [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]: 0x%02x\n",
+			ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]);
+	}
+
+
 	if (ext_csd_rev >= 8) {
 		printf("Command Queue Support [CMDQ_SUPPORT]: 0x%02x\n",
 		       ext_csd[EXT_CSD_CMDQ_SUPPORT]);
-- 
2.1.4

