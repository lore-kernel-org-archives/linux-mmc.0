From: akpm@linux-foundation.org
Subject: [patch 044/177] sdio: allow non-standard SDIO cards
Date: Tue, 10 Aug 2010 18:01:50 -0700
Message-ID: <201008110101.o7B11o7F027077@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47574 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757575Ab0HKBDN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Aug 2010 21:03:13 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, notasas@gmail.com, adrian.hunter@nokia.com, kishore.kadiyala@ti.com, kvalo@adurom.com, linux-mmc@vger.kernel.org, linux@arm.linux.org.uk, madhu.cr@ti.com, me@bobcopeland.com, tony@atomide.com

From: Grazvydas Ignotas <notasas@gmail.com>

There are some chips (like TI WL12xx series) that can be interfaced over
SDIO but don't support the SDIO specification, meaning that they are
missing CIA (Common I/O Area) with all it's registers.  Current Linux SDIO
implementation relies on those registers to identify and configure the
card, so non-standard cards can not function and cause lots of warnings
from the core when it reads invalid data from non-existent registers.

After this patch, init_card() host callback can now set new quirk
MMC_QUIRK_NONSTD_SDIO, which means that SDIO core should not try to access
any standard SDIO registers and rely on init_card() to fill all SDIO
structures instead.  As those cards are usually embedded chips, all the
required information can be obtained from machine board files by the host
driver when it's called through init_card() callback.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Bob Copeland <me@bobcopeland.com>
Cc: Kalle Valo <kvalo@adurom.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/core/sdio.c  |   36 ++++++++++++++++++++++++++++++------
 include/linux/mmc/card.h |    2 ++
 2 files changed, 32 insertions(+), 6 deletions(-)

diff -puN drivers/mmc/core/sdio.c~sdio-allow-non-standard-sdio-cards drivers/mmc/core/sdio.c
--- a/drivers/mmc/core/sdio.c~sdio-allow-non-standard-sdio-cards
+++ a/drivers/mmc/core/sdio.c
@@ -63,13 +63,19 @@ static int sdio_init_func(struct mmc_car
 
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
 
@@ -412,6 +418,23 @@ static int mmc_sdio_init_card(struct mmc
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
@@ -480,6 +503,7 @@ static int mmc_sdio_init_card(struct mmc
 	else if (err)
 		goto remove;
 
+finish:
 	if (!oldcard)
 		host->card = card;
 	return 0;
diff -puN include/linux/mmc/card.h~sdio-allow-non-standard-sdio-cards include/linux/mmc/card.h
--- a/include/linux/mmc/card.h~sdio-allow-non-standard-sdio-cards
+++ a/include/linux/mmc/card.h
@@ -103,6 +103,8 @@ struct mmc_card {
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
 						/* for byte mode */
+#define MMC_QUIRK_NONSTD_SDIO	(1<<2)		/* non-standard SDIO card attached */
+						/* (missing CIA registers) */
 
 	u32			raw_cid[4];	/* raw card CID */
 	u32			raw_csd[4];	/* raw card CSD */
_
