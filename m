From: Kyungmin Park <kmpark@infradead.org>
Subject: [PATCH v2] Recognize CSD structure version 3
Date: Thu, 03 Jun 2010 13:20:07 +0900
Message-ID: <20100603042007.GA15347@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout5.samsung.com ([203.254.224.35]:41467 "EHLO
	mailout5.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab0FCEUQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Jun 2010 00:20:16 -0400
Received: from epmmp1 (mailout5.samsung.com [203.254.224.35])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0L3F00JCV81PIU@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 03 Jun 2010 13:20:14 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L3F00M0M81PHQ@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 03 Jun 2010 13:20:13 +0900 (KST)
Content-disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, akpm@linux-foundation.org, adrian.hunter@nokia.com

The eMMC spec 4.4 and 4.3 + additional feature chips has CSD structure version 3
and version 3 have to check the CSD_STRUCTURE byte in the EXT_CSD register.

Also fix EXT_CSD revision message.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 89f7a25..95c4fb2 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -114,17 +114,18 @@ static int mmc_decode_cid(struct mmc_card *card)
 static int mmc_decode_csd(struct mmc_card *card)
 {
 	struct mmc_csd *csd = &card->csd;
-	unsigned int e, m, csd_struct;
+	unsigned int e, m;
 	u32 *resp = card->raw_csd;
 
 	/*
 	 * We only understand CSD structure v1.1 and v1.2.
 	 * v1.2 has extra information in bits 15, 11 and 10.
+	 * also support the for eMMC v4.4 & v4.41.
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
 
@@ -207,11 +208,22 @@ static int mmc_read_ext_csd(struct mmc_card *card)
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
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index d02d2c6..c83c7a7 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -24,6 +24,7 @@ struct mmc_cid {
 };
 
 struct mmc_csd {
+	unsigned char		structure;
 	unsigned char		mmca_vsn;
 	unsigned short		cmdclass;
 	unsigned short		tacc_clks;
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 8a49cbf..52ce988 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -254,6 +254,7 @@ struct _mmc_csd {
 #define EXT_CSD_BUS_WIDTH	183	/* R/W */
 #define EXT_CSD_HS_TIMING	185	/* R/W */
 #define EXT_CSD_CARD_TYPE	196	/* RO */
+#define EXT_CSD_STRUCTURE	194	/* RO */
 #define EXT_CSD_REV		192	/* RO */
 #define EXT_CSD_SEC_CNT		212	/* RO, 4 bytes */
 #define EXT_CSD_S_A_TIMEOUT	217
