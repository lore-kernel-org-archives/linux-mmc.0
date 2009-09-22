From: akpm@linux-foundation.org
Subject: [patch 050/232] mmc: check status after MMC SWITCH command
Date: Tue, 22 Sep 2009 16:44:37 -0700
Message-ID: <200909222344.n8MNibx2012491@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50610 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751439AbZIWASu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Sep 2009 20:18:50 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, adrian.hunter@nokia.com, ext-denis.2.karpov@nokia.com, ian@mnementh.co.uk, jarkko.lavinen@nokia.com, linux-mmc@vger.kernel.org, madhu.cr@ti.com, matt@console-pimps.org, philipl@overt.org, pierre@ossman.eu, roberto.foglietta@gmail.com

From: Adrian Hunter <adrian.hunter@nokia.com>

According to the standard, the SWITCH command should be followed by a
SEND_STATUS command to check for errors.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Acked-by: Matt Fleming <matt@console-pimps.org>
Cc: Ian Molton <ian@mnementh.co.uk>
Cc: "Roberto A. Foglietta" <roberto.foglietta@gmail.com>
Cc: Jarkko Lavinen <jarkko.lavinen@nokia.com>
Cc: Denis Karpov <ext-denis.2.karpov@nokia.com>
Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Philip Langdale <philipl@overt.org>
Cc: "Madhusudhan" <madhu.cr@ti.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/core/mmc.c     |   24 ++++++++++++++++++------
 drivers/mmc/core/mmc_ops.c |   23 +++++++++++++++++++++++
 include/linux/mmc/mmc.h    |    1 +
 3 files changed, 42 insertions(+), 6 deletions(-)

diff -puN drivers/mmc/core/mmc.c~mmc-check-status-after-mmc-switch-command drivers/mmc/core/mmc.c
--- a/drivers/mmc/core/mmc.c~mmc-check-status-after-mmc-switch-command
+++ a/drivers/mmc/core/mmc.c
@@ -416,12 +416,17 @@ static int mmc_init_card(struct mmc_host
 		(host->caps & MMC_CAP_MMC_HIGHSPEED)) {
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			EXT_CSD_HS_TIMING, 1);
-		if (err)
+		if (err && err != -EBADMSG)
 			goto free_card;
 
-		mmc_card_set_highspeed(card);
-
-		mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
+		if (err) {
+			printk(KERN_WARNING "%s: switch to highspeed failed\n",
+			       mmc_hostname(card->host));
+			err = 0;
+		} else {
+			mmc_card_set_highspeed(card);
+			mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
+		}
 	}
 
 	/*
@@ -456,10 +461,17 @@ static int mmc_init_card(struct mmc_host
 		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 				 EXT_CSD_BUS_WIDTH, ext_csd_bit);
 
-		if (err)
+		if (err && err != -EBADMSG)
 			goto free_card;
 
-		mmc_set_bus_width(card->host, bus_width);
+		if (err) {
+			printk(KERN_WARNING "%s: switch to bus width %d "
+			       "failed\n", mmc_hostname(card->host),
+			       1 << bus_width);
+			err = 0;
+		} else {
+			mmc_set_bus_width(card->host, bus_width);
+		}
 	}
 
 	if (!oldcard)
diff -puN drivers/mmc/core/mmc_ops.c~mmc-check-status-after-mmc-switch-command drivers/mmc/core/mmc_ops.c
--- a/drivers/mmc/core/mmc_ops.c~mmc-check-status-after-mmc-switch-command
+++ a/drivers/mmc/core/mmc_ops.c
@@ -390,6 +390,7 @@ int mmc_switch(struct mmc_card *card, u8
 {
 	int err;
 	struct mmc_command cmd;
+	u32 status;
 
 	BUG_ON(!card);
 	BUG_ON(!card->host);
@@ -407,6 +408,28 @@ int mmc_switch(struct mmc_card *card, u8
 	if (err)
 		return err;
 
+	/* Must check status to be sure of no errors */
+	do {
+		err = mmc_send_status(card, &status);
+		if (err)
+			return err;
+		if (card->host->caps & MMC_CAP_WAIT_WHILE_BUSY)
+			break;
+		if (mmc_host_is_spi(card->host))
+			break;
+	} while (R1_CURRENT_STATE(status) == 7);
+
+	if (mmc_host_is_spi(card->host)) {
+		if (status & R1_SPI_ILLEGAL_COMMAND)
+			return -EBADMSG;
+	} else {
+		if (status & 0xFDFFA000)
+			printk(KERN_WARNING "%s: unexpected status %#x after "
+			       "switch", mmc_hostname(card->host), status);
+		if (status & R1_SWITCH_ERROR)
+			return -EBADMSG;
+	}
+
 	return 0;
 }
 
diff -puN include/linux/mmc/mmc.h~mmc-check-status-after-mmc-switch-command include/linux/mmc/mmc.h
--- a/include/linux/mmc/mmc.h~mmc-check-status-after-mmc-switch-command
+++ a/include/linux/mmc/mmc.h
@@ -128,6 +128,7 @@
 #define R1_STATUS(x)            (x & 0xFFFFE000)
 #define R1_CURRENT_STATE(x)	((x & 0x00001E00) >> 9)	/* sx, b (4 bits) */
 #define R1_READY_FOR_DATA	(1 << 8)	/* sx, a */
+#define R1_SWITCH_ERROR		(1 << 7)	/* sx, c */
 #define R1_APP_CMD		(1 << 5)	/* sr, c */
 
 /*
_
