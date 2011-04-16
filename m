From: Andrei Warkentin <andreiw@motorola.com>
Subject: [PATCH] MMC: Block CMD23 support for UHS104/SDXC cards.
Date: Sat, 16 Apr 2011 18:38:13 -0500
Message-ID: <1302997093-5497-1-git-send-email-andreiw@motorola.com>
References: <1302950458-1969-5-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og111.obsmtp.com ([64.18.0.22]:58584 "EHLO
	exprod5og111.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759203Ab1DPXAd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Apr 2011 19:00:33 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3GMweAt010597
	for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 18:58:41 -0400 (EDT)
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3GMwe4r010591
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 18:58:40 -0400 (EDT)
Received: by gwb17 with SMTP id 17so2558351gwb.15
        for <linux-mmc@vger.kernel.org>; Sat, 16 Apr 2011 16:00:31 -0700 (PDT)
In-Reply-To: <1302950458-1969-5-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrei Warkentin <andreiw@motorola.com>, arindam.nath@amd.com, cjb@laptop.org, arnd@arndb.de

SD cards operating at UHS104 or better support SET_BLOCK_COUNT.

Cc: arindam.nath@amd.com
Cc: cjb@laptop.org
Cc: arnd@arndb.de
Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/block.c |    9 ++++++---
 drivers/mmc/core/sd.c    |    7 +++++++
 include/linux/mmc/card.h |    4 ++++
 include/linux/mmc/sd.h   |    2 +-
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 4b1a58e..520529a 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -851,9 +851,12 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	blk_queue_logical_block_size(md->queue.queue, 512);
 	set_capacity(md->disk, size);
 
-	if (mmc_host_cmd23(card->host) &&
-	    mmc_card_mmc(card))
-		md->flags |= MMC_BLK_CMD23;
+	if (mmc_host_cmd23(card->host)) {
+		if (mmc_card_mmc(card) ||
+		    (mmc_card_sd(card) &&
+		     card->scr.cmds & SD_SCR_CMD23_SUPPORT))
+			md->flags |= MMC_BLK_CMD23;
+	}
 
 	if (mmc_card_mmc(card) &&
 	    md->flags & MMC_BLK_CMD23 &&
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 6dac89f..a3d771a 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -195,6 +195,13 @@ static int mmc_decode_scr(struct mmc_card *card)
 	else
 		card->erased_byte = 0x0;
 
+	if (scr->sda_vsn == SCR_SPEC_VER_2) {
+
+		/* Check if Physical Layer Spec v3.0X is supported. */
+		scr->sda_spec3 = UNSTUFF_BITS(resp, 47, 1);
+		if (scr->sda_spec3)
+			scr->cmds = UNSTUFF_BITS(resp, 32, 2);
+	}
 	return 0;
 }
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index c758181..e6b2e6f 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -67,9 +67,13 @@ struct mmc_ext_csd {
 
 struct sd_scr {
 	unsigned char		sda_vsn;
+	unsigned char		sda_spec3;
 	unsigned char		bus_widths;
 #define SD_SCR_BUS_WIDTH_1	(1<<0)
 #define SD_SCR_BUS_WIDTH_4	(1<<2)
+	unsigned char		cmds;
+#define SD_SCR_CMD20_SUPPORT   (1<<0)
+#define SD_SCR_CMD23_SUPPORT   (1<<1)
 };
 
 struct sd_ssr {
diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
index 3fd85e0..9fe0689 100644
--- a/include/linux/mmc/sd.h
+++ b/include/linux/mmc/sd.h
@@ -59,7 +59,7 @@
 
 #define SCR_SPEC_VER_0		0	/* Implements system specification 1.0 - 1.01 */
 #define SCR_SPEC_VER_1		1	/* Implements system specification 1.10 */
-#define SCR_SPEC_VER_2		2	/* Implements system specification 2.00 */
+#define SCR_SPEC_VER_2		2	/* Implements system specification 2.00-3.0X */
 
 /*
  * SD bus widths
-- 
1.7.0.4

