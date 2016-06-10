From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] mmc-utils: Add Command Queue fields to Extended CSD
Date: Fri, 10 Jun 2016 11:28:59 +0300
Message-ID: <1465547339-10557-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:62608 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101AbcFJIdD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 10 Jun 2016 04:33:03 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

Display Command Queue information when printing Extended CSD
Example:

	# mmc extcsd read /dev/mmcblk0 | grep CMDQ
	Command Queue Support [CMDQ_SUPPORT]: 0x01
	Command Queue Depth [CMDQ_DEPTH]: 16
	Command Enabled [CMDQ_MODE_EN]: 0x01

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 mmc.h      | 3 +++
 mmc_cmds.c | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/mmc.h b/mmc.h
index 8c77fd5572eb..a3d732c7215c 100644
--- a/mmc.h
+++ b/mmc.h
@@ -55,6 +55,8 @@
 #define EXT_CSD_FFU_ARG_2		489	/* RO */
 #define EXT_CSD_FFU_ARG_1		488	/* RO */
 #define EXT_CSD_FFU_ARG_0		487	/* RO */
+#define EXT_CSD_CMDQ_DEPTH		307	/* RO */
+#define EXT_CSD_CMDQ_SUPPORT		308	/* RO */
 #define EXT_CSD_NUM_OF_FW_SEC_PROG_3	305	/* RO */
 #define EXT_CSD_NUM_OF_FW_SEC_PROG_2	304	/* RO */
 #define EXT_CSD_NUM_OF_FW_SEC_PROG_1	303	/* RO */
@@ -119,6 +121,7 @@
 #define EXT_CSD_MODE_CONFIG		30
 #define EXT_CSD_MODE_OPERATION_CODES	29	/* W */
 #define EXT_CSD_FFU_STATUS		26	/* R */
+#define EXT_CSD_CMDQ_MODE_EN		15	/* R/W */
 
 /*
  * WR_REL_PARAM field definitions
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 36276106b7bf..295d50541dee 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1723,6 +1723,15 @@ int do_read_extcsd(int nargs, char **argv)
 		printf("eMMC Firmware Version: %s\n",
 			(char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);
 	}
+
+	if (ext_csd_rev >= 8) {
+		printf("Command Queue Support [CMDQ_SUPPORT]: 0x%02x\n",
+		       ext_csd[EXT_CSD_CMDQ_SUPPORT]);
+		printf("Command Queue Depth [CMDQ_DEPTH]: %u\n",
+		       (ext_csd[EXT_CSD_CMDQ_DEPTH] & 0x1f) + 1);
+		printf("Command Enabled [CMDQ_MODE_EN]: 0x%02x\n",
+		       ext_csd[EXT_CSD_CMDQ_MODE_EN]);
+	}
 out_free:
 	return ret;
 }
-- 
1.9.1

