From: Kyungmin Park <kmpark@infradead.org>
Subject: [PATCH] Detect the mmc v4.5
Date: Tue, 26 Jul 2011 17:12:37 +0900
Message-ID: <20110726081237.GA15049@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:16936 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621Ab1GZIMr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jul 2011 04:12:47 -0400
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LOX00LMJLH0SN50@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 26 Jul 2011 17:12:45 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LOX00LJDLH9PJ@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 26 Jul 2011 17:12:45 +0900 (KST)
Content-disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: jh80.chung@samsung.com

From: Kyungmin Park <kyungmin.park@samsung.com>

As eMMC v4.5 Spec is released, prepare the eMMC v4.5

EXT_CSD_REV	Extended CSD Revision
255-7		Reserved
6		Revision 1.6 (for MMC v4.5)
5		Revision 1.5 (for MMV v4.41)
...

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index aa7d1d7..5700b1c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -259,7 +259,7 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 	}
 
 	card->ext_csd.rev = ext_csd[EXT_CSD_REV];
-	if (card->ext_csd.rev > 5) {
+	if (card->ext_csd.rev > 6) {
 		printk(KERN_ERR "%s: unrecognised EXT_CSD revision %d\n",
 			mmc_hostname(card->host), card->ext_csd.rev);
 		err = -EINVAL;
