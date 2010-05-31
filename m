From: Kyungmin Park <kmpark@infradead.org>
Subject: [PATCH] Recognize CSD structure version 3
Date: Mon, 31 May 2010 15:40:35 +0900
Message-ID: <20100531064035.GA25269@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout5.samsung.com ([203.254.224.35]:63033 "EHLO
	mailout5.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643Ab0EaGkq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 31 May 2010 02:40:46 -0400
Received: from epmmp2 (mailout5.samsung.com [203.254.224.35])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0L390034MUJVWS@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 31 May 2010 15:40:43 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L3900MUOUJV8L@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 31 May 2010 15:40:43 +0900 (KST)
Content-disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, akpm@linux-foundation.org

The eMMC spec 4.4 and 4.3 + additional feature chips has CSD structure version 3
To probe these chip properly and make it simple.
it doesn't check CSD structure.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 89f7a25..9e42bc6 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -118,15 +118,12 @@ static int mmc_decode_csd(struct mmc_card *card)
 	u32 *resp = card->raw_csd;
 
 	/*
-	 * We only understand CSD structure v1.1 and v1.2.
+	 * We understand all CSD structure v1.1, v1.2 and v1.3.
 	 * v1.2 has extra information in bits 15, 11 and 10.
 	 */
 	csd_struct = UNSTUFF_BITS(resp, 126, 2);
-	if (csd_struct != 1 && csd_struct != 2) {
-		printk(KERN_ERR "%s: unrecognised CSD structure version %d\n",
+	printk(KERN_DEBUG "%s: recognised CSD structure version %d\n",
 			mmc_hostname(card->host), csd_struct);
-		return -EINVAL;
-	}
 
 	csd->mmca_vsn	 = UNSTUFF_BITS(resp, 122, 4);
 	m = UNSTUFF_BITS(resp, 115, 4);
