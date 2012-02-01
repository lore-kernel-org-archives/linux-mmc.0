From: Jurgen Heeks <JURGEN.HEEKS@NOKIA.COM>
Subject: [PATCH 1/1] mmc:core: Fix comparison issue in mmc_compare_ext_csds
Date: Wed,  1 Feb 2012 13:30:55 +0100
Message-ID: <d6bc8a99fb26a999ac17c793065333ccbf374b67.1328095280.git.JURGEN.HEEKS@NOKIA.COM>
References: <cover.1328095280.git.JURGEN.HEEKS@NOKIA.COM>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:61010 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754258Ab2BAM3D (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 1 Feb 2012 07:29:03 -0500
Received: from localhost.localdomain (uldhcp1b02947.europe.nokia.com [172.25.29.47])
	by mgw-da02.nokia.com (Switch-3.4.4/Switch-3.4.4) with ESMTP id q11CSwDc022227
	for <linux-mmc@vger.kernel.org>; Wed, 1 Feb 2012 14:28:59 +0200
In-Reply-To: <cover.1328095280.git.JURGEN.HEEKS@NOKIA.COM>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Found this issue during code review. Actually, there are two
issues which both compensate together in lucky case.
In unlucky case the bus width probing might not work as expected.

Signed-off-by: Jurgen Heeks <JURGEN.HEEKS@NOKIA.COM>
---
 drivers/mmc/core/mmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f6ac0a4..4f06c43 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -353,7 +353,7 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 	}
 
 	card->ext_csd.raw_hc_erase_gap_size =
-		ext_csd[EXT_CSD_PARTITION_ATTRIBUTE];
+		ext_csd[EXT_CSD_HC_WP_GRP_SIZE];
 	card->ext_csd.raw_sec_trim_mult =
 		ext_csd[EXT_CSD_SEC_TRIM_MULT];
 	card->ext_csd.raw_sec_erase_mult =
@@ -451,7 +451,7 @@ static int mmc_compare_ext_csds(struct mmc_card *card, unsigned bus_width)
 		goto out;
 
 	/* only compare read only fields */
-	err = (!(card->ext_csd.raw_partition_support ==
+	err = !((card->ext_csd.raw_partition_support ==
 			bw_ext_csd[EXT_CSD_PARTITION_SUPPORT]) &&
 		(card->ext_csd.raw_erased_mem_count ==
 			bw_ext_csd[EXT_CSD_ERASED_MEM_CONT]) &&
-- 
1.7.1

