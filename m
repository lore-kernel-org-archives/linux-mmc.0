From: Andrei Warkentin <andreiw@motorola.com>
Subject: [v6 4/5] MMC: Block CMD23 support for UHS104/SDXC cards.
Date: Mon, 23 May 2011 15:06:38 -0500
Message-ID: <1306181199-13915-5-git-send-email-andreiw@motorola.com>
References: <1305841590-26963-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og106.obsmtp.com ([64.18.0.182]:53197 "EHLO
	exprod5og106.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932368Ab1EWTd3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 May 2011 15:33:29 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.168])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p4NJV47r022770
	for <linux-mmc@vger.kernel.org>; Mon, 23 May 2011 15:31:04 -0400 (EDT)
Received: from mail-pw0-f42.google.com (mail-pw0-f42.google.com [209.85.160.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p4NJUw6b022683
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 23 May 2011 15:31:04 -0400 (EDT)
Received: by mail-pw0-f42.google.com with SMTP id 3so3491887pwj.15
        for <linux-mmc@vger.kernel.org>; Mon, 23 May 2011 12:33:27 -0700 (PDT)
In-Reply-To: <1305841590-26963-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Andrei Warkentin <andreiw@motorola.com>, arindam.nath@amd.com, arnd@arndb.de, malchev@google.com

SD cards operating at UHS104 or better support SET_BLOCK_COUNT.

Cc: arindam.nath@amd.com
Cc: cjb@laptop.org
Cc: arnd@arndb.de
Cc: malchev@google.com
Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
---
 drivers/mmc/card/block.c |    9 ++++++---
 drivers/mmc/core/sd.c    |    2 ++
 include/linux/mmc/card.h |    3 +++
 include/linux/mmc/sd.h   |    2 +-
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index a380acc..71da564 100755
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1057,9 +1057,12 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
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
index 596d0b9..ff27741 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -203,6 +203,8 @@ static int mmc_decode_scr(struct mmc_card *card)
 	else
 		card->erased_byte = 0x0;
 
+	if (scr->sda_spec3)
+		scr->cmds = UNSTUFF_BITS(resp, 32, 2);
 	return 0;
 }
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 4a0e27b..c6927a4 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -72,6 +72,9 @@ struct sd_scr {
 	unsigned char		bus_widths;
 #define SD_SCR_BUS_WIDTH_1	(1<<0)
 #define SD_SCR_BUS_WIDTH_4	(1<<2)
+	unsigned char		cmds;
+#define SD_SCR_CMD20_SUPPORT   (1<<0)
+#define SD_SCR_CMD23_SUPPORT   (1<<1)
 };
 
 struct sd_ssr {
diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
index c648878..7d35d52 100644
--- a/include/linux/mmc/sd.h
+++ b/include/linux/mmc/sd.h
@@ -66,7 +66,7 @@
 
 #define SCR_SPEC_VER_0		0	/* Implements system specification 1.0 - 1.01 */
 #define SCR_SPEC_VER_1		1	/* Implements system specification 1.10 */
-#define SCR_SPEC_VER_2		2	/* Implements system specification 2.00 */
+#define SCR_SPEC_VER_2		2	/* Implements system specification 2.00-3.0X */
 
 /*
  * SD bus widths
-- 
1.7.0.4

