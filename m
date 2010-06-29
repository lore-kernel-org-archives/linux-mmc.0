From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 1/3] sdio: allow non-standard SDIO cards
Date: Tue, 29 Jun 2010 16:49:23 +0300
Message-ID: <1277819365-2761-2-git-send-email-notasas@gmail.com>
References: <1277819365-2761-1-git-send-email-notasas@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:60554 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755914Ab0F2Nte (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Jun 2010 09:49:34 -0400
Received: by wwb18 with SMTP id 18so514157wwb.19
        for <linux-mmc@vger.kernel.org>; Tue, 29 Jun 2010 06:49:32 -0700 (PDT)
In-Reply-To: <1277819365-2761-1-git-send-email-notasas@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Adrian Hunter <adrian.hunter@nokia.com>, Tony Lindgren <tony@atomide.com>, Bob Copeland <me@bobcopeland.com>, Kalle Valo <kvalo@adurom.com>, Grazvydas Ignotas <notasas@gmail.com>

There are some chips (like TI WL12xx series) that can be interfaced
over SDIO but don't support the SDIO specification, meaning that they
are missing CIA (Common I/O Area) with all it's registers. Current
Linux SDIO implementation relies on those registers to identify and
configure the card, so non-standard cards can not function and cause
lots of warnings from the core when it reads invalid data from
non-existent registers.

After this patch, init_card() host callback can now set new quirk
MMC_QUIRK_NONSTD_SDIO, which means that SDIO core should not try to
access any standard SDIO registers and rely on init_card() to fill all
SDIO structures instead. As those cards are usually embedded chips,
all the required information can be obtained from machine board files
by the host driver when it's called through init_card() callback.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/mmc/core/sdio.c  |   36 ++++++++++++++++++++++++++++++------
 include/linux/mmc/card.h |    2 ++
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index b9dee28..cb66833 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -62,13 +62,19 @@ static int sdio_init_func(struct mmc_card *card, unsigned int fn)
 
 	func->num = fn;
 
-	ret = sdio_read_fbr(func);
-	if (ret)
-		goto fail;
+	if (!(card->quirks & MMC_QUIRK_NONSTD_SDIO)) {
+		ret = sdio_read_fbr(func);
+		if (ret)
+			goto fail;
 
-	ret = sdio_read_func_cis(func);
-	if (ret)
-		goto fail;
+		ret = sdio_read_func_cis(func);
+		if (ret)
+			goto fail;
+	} else {
+		func->vendor = func->card->cis.vendor;
+		func->device = func->card->cis.device;
+		func->max_blksize = func->card->cis.blksize;
+	}
 
 	card->sdio_func[fn - 1] = func;
 
@@ -321,6 +327,23 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 			goto remove;
 	}
 
+	if (card->quirks & MMC_QUIRK_NONSTD_SDIO) {
+		/*
+		 * This is non-standard SDIO device, meaning it doesn't
+		 * have any CIA (Common I/O area) registers present.
+		 * It's host's responsibility to fill cccr and cis
+		 * structures in init_card().
+		 */
+		mmc_set_clock(host, card->cis.max_dtr);
+
+		if (card->cccr.high_speed) {
+			mmc_card_set_highspeed(card);
+			mmc_set_timing(card->host, MMC_TIMING_SD_HS);
+		}
+
+		goto finish;
+	}
+
 	/*
 	 * Read the common registers.
 	 */
@@ -376,6 +399,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	if (err)
 		goto remove;
 
+finish:
 	if (!oldcard)
 		host->card = card;
 	return 0;
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index d02d2c6..cbc745c 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -101,6 +101,8 @@ struct mmc_card {
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
 						/* for byte mode */
+#define MMC_QUIRK_NONSTD_SDIO	(1<<2)		/* non-standard SDIO card attached */
+						/* (missing CIA registers) */
 
 	u32			raw_cid[4];	/* raw card CID */
 	u32			raw_csd[4];	/* raw card CSD */
-- 
1.6.3.3

