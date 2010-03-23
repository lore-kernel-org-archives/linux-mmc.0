From: akpm@linux-foundation.org
Subject: [patch 30/36] mmc: fix incorrect interpretation of card type bits
Date: Tue, 23 Mar 2010 13:35:40 -0700
Message-ID: <201003232035.o2NKZewC024543@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35024 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753102Ab0CWUfq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Mar 2010 16:35:46 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, adrian.hunter@nokia.com, linux-mmc@vger.kernel.org

From: Adrian Hunter <adrian.hunter@nokia.com>

In the extended CSD register the CARD_TYPE is an 8-bit value of which the
upper 6 bits were reserved in JEDEC specifications prior to version 4.4. 
In version 4.4 two of the reserved bits were designated for identifying
support for the newly added High-Speed Dual Data Rate.  Unfortunately the
mmc_read_ext_csd() function required that the reserved bits be zero
instead of ignoring them as it should.

This patch makes mmc_read_ext_csd() ignore the CARD_TYPE bits that are
reserved or not yet supported.  It also stops the function jumping to the
end as though an error occurred, when it is only warns that the CARD_TYPE
bits (that it does interpret) are invalid.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/core/mmc.c  |    3 +--
 include/linux/mmc/mmc.h |    1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/mmc/core/mmc.c~mmc-fix-incorrect-interpretation-of-card-type-bits drivers/mmc/core/mmc.c
--- a/drivers/mmc/core/mmc.c~mmc-fix-incorrect-interpretation-of-card-type-bits
+++ a/drivers/mmc/core/mmc.c
@@ -225,7 +225,7 @@ static int mmc_read_ext_csd(struct mmc_c
 			mmc_card_set_blockaddr(card);
 	}
 
-	switch (ext_csd[EXT_CSD_CARD_TYPE]) {
+	switch (ext_csd[EXT_CSD_CARD_TYPE] & EXT_CSD_CARD_TYPE_MASK) {
 	case EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
 		card->ext_csd.hs_max_dtr = 52000000;
 		break;
@@ -237,7 +237,6 @@ static int mmc_read_ext_csd(struct mmc_c
 		printk(KERN_WARNING "%s: card is mmc v4 but doesn't "
 			"support any high-speed modes.\n",
 			mmc_hostname(card->host));
-		goto out;
 	}
 
 	if (card->ext_csd.rev >= 3) {
diff -puN include/linux/mmc/mmc.h~mmc-fix-incorrect-interpretation-of-card-type-bits include/linux/mmc/mmc.h
--- a/include/linux/mmc/mmc.h~mmc-fix-incorrect-interpretation-of-card-type-bits
+++ a/include/linux/mmc/mmc.h
@@ -268,6 +268,7 @@ struct _mmc_csd {
 
 #define EXT_CSD_CARD_TYPE_26	(1<<0)	/* Card can run at 26MHz */
 #define EXT_CSD_CARD_TYPE_52	(1<<1)	/* Card can run at 52MHz */
+#define EXT_CSD_CARD_TYPE_MASK	0x3	/* Mask out reserved and DDR bits */
 
 #define EXT_CSD_BUS_WIDTH_1	0	/* Card is in 1 bit mode */
 #define EXT_CSD_BUS_WIDTH_4	1	/* Card is in 4 bit mode */
_
