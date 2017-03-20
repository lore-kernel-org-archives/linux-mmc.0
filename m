From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 1/2] mmc-utils: feature spec 5.0+, Pre EOL information
Date: Mon, 20 Mar 2017 12:07:08 +0100
Message-ID: <20170320110709.31079-1-alexander.stein@systec-electronic.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:36351 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754218AbdCTLIP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Mar 2017 07:08:15 -0400
Received: from imapserver.systec-electronic.com (unknown [212.185.67.146])
        by webbox1416.server-home.net (Postfix) with ESMTPA id C81AC27A3EF
        for <linux-mmc@vger.kernel.org>; Mon, 20 Mar 2017 12:07:22 +0100 (CET)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Alexander Stein <alexander.stein@systec-electronic.com>

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 mmc.h      | 1 +
 mmc_cmds.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/mmc.h b/mmc.h
index f3fa03f..fa49df6 100644
--- a/mmc.h
+++ b/mmc.h
@@ -63,6 +63,7 @@
 #define EXT_CSD_NUM_OF_FW_SEC_PROG_0	302	/* RO */
 #define EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B 	269	/* RO */
 #define EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A 	268	/* RO */
+#define EXT_CSD_PRE_EOL_INFO		267	/* RO */
 #define EXT_CSD_FIRMWARE_VERSION	254	/* RO */
 #define EXT_CSD_CACHE_SIZE_3		252
 #define EXT_CSD_CACHE_SIZE_2		251
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 0e4322e..728ad77 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1748,6 +1748,11 @@ int do_read_extcsd(int nargs, char **argv)
 			ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]);
 	}
 
+	if (ext_csd_rev >= 7) {
+		printf("eMMC Pre EOL information [EXT_CSD_PRE_EOL_INFO]: 0x%02x\n",
+			ext_csd[EXT_CSD_PRE_EOL_INFO]);
+	}
+
 	if (ext_csd_rev >= 8) {
 		printf("Command Queue Support [CMDQ_SUPPORT]: 0x%02x\n",
 		       ext_csd[EXT_CSD_CMDQ_SUPPORT]);
-- 
2.10.2

