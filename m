From: Oleg Matcovschi <olegm@lab126.com>
Subject: [PATCH 2/2] mmc-utils: Correctly handle CARD_TYPE.
Date: Thu, 23 May 2013 17:11:07 -0700
Message-ID: <1369354267-18632-2-git-send-email-olegm@lab126.com>
References: <1369354267-18632-1-git-send-email-olegm@lab126.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:56818 "EHLO
	smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755504Ab3EXALy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 May 2013 20:11:54 -0400
In-Reply-To: <1369354267-18632-1-git-send-email-olegm@lab126.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: Oleg Matcovschi <olegm@lab126.com>

Analysis was based on value of EXT_CSD_BOOT_INFO, not CARD_TYPE.
CARD_TYPE should be handled using bitmask, not values.


Signed-off-by: Oleg Matcovschi <olegm@lab126.com>
---
 mmc_cmds.c |   34 +++++++++++-----------------------
 1 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index b407f65..7aad812 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -578,29 +578,16 @@ int do_read_extcsd(int nargs, char **argv)
 		printf("I/O Driver Strength [DRIVER_STRENGTH: 0x%02x]\n",
 			ext_csd[197]);
 
-	printf("Card Type [CARD_TYPE: 0x%02x]\n", ext_csd[196]);
-	/* DEVICE_TYPE in A45 */
-	switch (reg) {
-	case 5:
-		printf("HS200 Single Data Rate eMMC @200MHz 1.2VI/O\n");
-		break;
-	case 4:
-		printf("HS200 Single Data Rate eMMC @200MHz 1.8VI/O\n");
-		break;
-	case 3:
-		printf("HS Dual Data Rate eMMC @52MHz 1.2VI/O\n");
+	/* DEVICE_TYPE in A45, CARD_TYPE in A441 */
+	reg = ext_csd[196];
+	printf("Card Type [CARD_TYPE: 0x%02x]\n", reg);
+	if (reg & 0x20) printf(" HS200 Single Data Rate eMMC @200MHz 1.2VI/O\n");
+	if (reg & 0x10) printf(" HS200 Single Data Rate eMMC @200MHz 1.8VI/O\n");
+	if (reg & 0x08) printf(" HS Dual Data Rate eMMC @52MHz 1.2VI/O\n");
+	if (reg & 0x04)	printf(" HS Dual Data Rate eMMC @52MHz 1.8V or 3VI/O\n");
+	if (reg & 0x02)	printf(" HS eMMC @52MHz - at rated device voltage(s)\n");
+	if (reg & 0x01) printf(" HS eMMC @26MHz - at rated device voltage(s)\n");
 
-		break;
-	case 2:
-		printf("HS Dual Data Rate eMMC @52MHz 1.8V or 3VI/O\n");
-		break;
-	case 1:
-		printf("HS eMMC @52MHz - at rated device voltage(s)\n");
-		break;
-	case 0:
-		printf("HS eMMC @26MHz - at rated device voltage(s)\n");
-		break;
-	}
 	printf("CSD structure version [CSD_STRUCTURE: 0x%02x]\n", ext_csd[194]);
 	/* ext_csd_rev = ext_csd[192] (already done!!!) */
 	printf("Command set [CMD_SET: 0x%02x]\n", ext_csd[191]);
@@ -759,7 +746,8 @@ int do_read_extcsd(int nargs, char **argv)
 			" [PACKED_FAILURE_INDEX]: 0x%02x\n", ext_csd[35]);
 		printf("Power Off Notification"
 			" [POWER_OFF_NOTIFICATION]: 0x%02x\n", ext_csd[34]);
-		printf("Control to turn the Cache ON/OFF"			" [CACHE_CTRL]: 0x%02x\n", ext_csd[33]);
+		printf("Control to turn the Cache ON/OFF"
+			" [CACHE_CTRL]: 0x%02x\n", ext_csd[33]);
 		/* flush_cache ext_csd[32] not readable */
 		/*Reserved [31:0] */
 	}
-- 
1.7.4.1

