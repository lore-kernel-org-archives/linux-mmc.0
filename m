From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 2/2] mmc-utils: Check for ext_csd_rev only once
Date: Mon, 20 Mar 2017 12:07:09 +0100
Message-ID: <20170320110709.31079-2-alexander.stein@systec-electronic.com>
References: <20170320110709.31079-1-alexander.stein@systec-electronic.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:36352 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754205AbdCTLIP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Mar 2017 07:08:15 -0400
Received: from imapserver.systec-electronic.com (unknown [212.185.67.146])
        by webbox1416.server-home.net (Postfix) with ESMTPA id 0E12727A592
        for <linux-mmc@vger.kernel.org>; Mon, 20 Mar 2017 12:07:23 +0100 (CET)
In-Reply-To: <20170320110709.31079-1-alexander.stein@systec-electronic.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Alexander Stein <alexander.stein@systec-electronic.com>

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 mmc_cmds.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 728ad77..d7215bb 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1736,19 +1736,10 @@ int do_read_extcsd(int nargs, char **argv)
 	if (ext_csd_rev >= 7) {
 		printf("eMMC Firmware Version: %s\n",
 			(char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);
-	}
-
-	if (ext_csd_rev >= 7) {
 		printf("eMMC Life Time Estimation A [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]: 0x%02x\n",
 			ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A]);
-	}
-
-	if (ext_csd_rev >= 7) {
 		printf("eMMC Life Time Estimation B [EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]: 0x%02x\n",
 			ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B]);
-	}
-
-	if (ext_csd_rev >= 7) {
 		printf("eMMC Pre EOL information [EXT_CSD_PRE_EOL_INFO]: 0x%02x\n",
 			ext_csd[EXT_CSD_PRE_EOL_INFO]);
 	}
-- 
2.10.2

