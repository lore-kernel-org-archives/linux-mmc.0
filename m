From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH] mmc: fix incorrect interpretation of card type bits
Date: Fri, 19 Mar 2010 08:24:56 +0200
Message-ID: <4BA318B8.5060408@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61632 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705Ab0CSGZC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Mar 2010 02:25:02 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Fri, 19 Mar 2010 08:06:54 +0200
Subject: [PATCH] mmc: fix incorrect interpretation of card type bits

In the extended CSD register the CARD_TYPE is an 8-bit value
of which the upper 6 bits were reserved in JEDEC specifications
prior to version 4.4.  In version 4.4 two of the reserved bits
were designated for identifying support for the newly added
High-Speed Dual Data Rate.  Unfortunately the mmc_read_ext_csd()
function required that the reserved bits be zero instead of
ignoring them as it should.

This patch makes mmc_read_ext_csd() ignore the CARD_TYPE bits
that are reserved or not yet supported.  It also stops the
function jumping to the end as though an error occurred, when
it is only warns that the CARD_TYPE bits (that it does interpret)
are invalid.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/core/mmc.c  |    3 +--
 include/linux/mmc/mmc.h |    1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 0eac6c8..e041c00 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -225,7 +225,7 @@ static int mmc_read_ext_csd(struct mmc_card *card)
 			mmc_card_set_blockaddr(card);
 	}
 
-	switch (ext_csd[EXT_CSD_CARD_TYPE]) {
+	switch (ext_csd[EXT_CSD_CARD_TYPE] & EXT_CSD_CARD_TYPE_MASK) {
 	case EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
 		card->ext_csd.hs_max_dtr = 52000000;
 		break;
@@ -237,7 +237,6 @@ static int mmc_read_ext_csd(struct mmc_card *card)
 		printk(KERN_WARNING "%s: card is mmc v4 but doesn't "
 			"support any high-speed modes.\n",
 			mmc_hostname(card->host));
-		goto out;
 	}
 
 	if (card->ext_csd.rev >= 3) {
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index c02c8db..8a49cbf 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -268,6 +268,7 @@ struct _mmc_csd {
 
 #define EXT_CSD_CARD_TYPE_26	(1<<0)	/* Card can run at 26MHz */
 #define EXT_CSD_CARD_TYPE_52	(1<<1)	/* Card can run at 52MHz */
+#define EXT_CSD_CARD_TYPE_MASK	0x3	/* Mask out reserved and DDR bits */
 
 #define EXT_CSD_BUS_WIDTH_1	0	/* Card is in 1 bit mode */
 #define EXT_CSD_BUS_WIDTH_4	1	/* Card is in 4 bit mode */
-- 
1.6.0.4
