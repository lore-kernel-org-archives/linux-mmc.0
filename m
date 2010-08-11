From: akpm@linux-foundation.org
Subject: [patch 031/177] mmc: recognize CSD structure
Date: Tue, 10 Aug 2010 18:01:36 -0700
Message-ID: <201008110101.o7B11adR027035@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43540 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758276Ab0HKB1O (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Aug 2010 21:27:14 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, kmpark@infradead.org, adrian.hunter@nokia.com, cjb@laptop.org, kyungmin.park@samsung.com, linux-mmc@vger.kernel.org

From: Kyungmin Park <kmpark@infradead.org>

The eMMC spec 4.4 and 4.3 + additional feature chips has CSD structure
version 3 and version 3 have to check the CSD_STRUCTURE byte in the
EXT_CSD register.

Also fix EXT_CSD revision message.

[akpm@linux-foundation.org: fix comment, per Chris Ball]
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/core/mmc.c   |   26 +++++++++++++++++++-------
 include/linux/mmc/card.h |    1 +
 include/linux/mmc/mmc.h  |    1 +
 3 files changed, 21 insertions(+), 7 deletions(-)

diff -puN drivers/mmc/core/mmc.c~mmc-recognize-csd-structure drivers/mmc/core/mmc.c
--- a/drivers/mmc/core/mmc.c~mmc-recognize-csd-structure
+++ a/drivers/mmc/core/mmc.c
@@ -114,17 +114,18 @@ static int mmc_decode_cid(struct mmc_car
 static int mmc_decode_csd(struct mmc_card *card)
 {
 	struct mmc_csd *csd = &card->csd;
-	unsigned int e, m, csd_struct;
+	unsigned int e, m;
 	u32 *resp = card->raw_csd;
 
 	/*
 	 * We only understand CSD structure v1.1 and v1.2.
 	 * v1.2 has extra information in bits 15, 11 and 10.
+	 * We also support eMMC v4.4 & v4.41.
 	 */
-	csd_struct = UNSTUFF_BITS(resp, 126, 2);
-	if (csd_struct != 1 && csd_struct != 2) {
+	csd->structure = UNSTUFF_BITS(resp, 126, 2);
+	if (csd->structure == 0) {
 		printk(KERN_ERR "%s: unrecognised CSD structure version %d\n",
-			mmc_hostname(card->host), csd_struct);
+			mmc_hostname(card->host), csd->structure);
 		return -EINVAL;
 	}
 
@@ -207,11 +208,22 @@ static int mmc_read_ext_csd(struct mmc_c
 		goto out;
 	}
 
+	/* Version is coded in the CSD_STRUCTURE byte in the EXT_CSD register */
+	if (card->csd.structure == 3) {
+		int ext_csd_struct = ext_csd[EXT_CSD_STRUCTURE];
+		if (ext_csd_struct > 2) {
+			printk(KERN_ERR "%s: unrecognised EXT_CSD structure "
+				"version %d\n", mmc_hostname(card->host),
+					ext_csd_struct);
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
 	card->ext_csd.rev = ext_csd[EXT_CSD_REV];
 	if (card->ext_csd.rev > 5) {
-		printk(KERN_ERR "%s: unrecognised EXT_CSD structure "
-			"version %d\n", mmc_hostname(card->host),
-			card->ext_csd.rev);
+		printk(KERN_ERR "%s: unrecognised EXT_CSD revision %d\n",
+			mmc_hostname(card->host), card->ext_csd.rev);
 		err = -EINVAL;
 		goto out;
 	}
diff -puN include/linux/mmc/card.h~mmc-recognize-csd-structure include/linux/mmc/card.h
--- a/include/linux/mmc/card.h~mmc-recognize-csd-structure
+++ a/include/linux/mmc/card.h
@@ -24,6 +24,7 @@ struct mmc_cid {
 };
 
 struct mmc_csd {
+	unsigned char		structure;
 	unsigned char		mmca_vsn;
 	unsigned short		cmdclass;
 	unsigned short		tacc_clks;
diff -puN include/linux/mmc/mmc.h~mmc-recognize-csd-structure include/linux/mmc/mmc.h
--- a/include/linux/mmc/mmc.h~mmc-recognize-csd-structure
+++ a/include/linux/mmc/mmc.h
@@ -254,6 +254,7 @@ struct _mmc_csd {
 #define EXT_CSD_BUS_WIDTH	183	/* R/W */
 #define EXT_CSD_HS_TIMING	185	/* R/W */
 #define EXT_CSD_CARD_TYPE	196	/* RO */
+#define EXT_CSD_STRUCTURE	194	/* RO */
 #define EXT_CSD_REV		192	/* RO */
 #define EXT_CSD_SEC_CNT		212	/* RO, 4 bytes */
 #define EXT_CSD_S_A_TIMEOUT	217
_
