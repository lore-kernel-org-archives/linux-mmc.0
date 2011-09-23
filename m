From: Andrei Warkentin <andrey.warkentin@gmail.com>
Subject: [PATCH] MMC: ext_csd.raw_* used in comparison but never set
Date: Fri, 23 Sep 2011 00:25:30 -0400
Message-ID: <1316751930-7478-1-git-send-email-andrey.warkentin@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41834 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750Ab1IWE1z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Sep 2011 00:27:55 -0400
Received: by vws1 with SMTP id 1so3889175vws.19
        for <linux-mmc@vger.kernel.org>; Thu, 22 Sep 2011 21:27:54 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Philip Rakity <prakity@marvell.com>, andreiw@vmware.com, Andrei Warkentin <andrey.warkentin@gmail.com>

f39b2dd9d065151a04f5996656d1f27a7eb32d45 added code to
only compare read-only ext_csd fields in bus width
testing code, yet it's comparing some fields that are
never set.

The affected fields are ext_csd.raw_erased_mem_count and
ext_csd.raw_partition_support.

Signed-off-by: Andrei Warkentin <andrey.warkentin@gmail.com>
---
 drivers/mmc/core/mmc.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 5700b1c..bb33832 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -359,6 +359,7 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		 * card has the Enhanced area enabled.  If so, export enhanced
 		 * area offset and size to user by adding sysfs interface.
 		 */
+		card->ext_csd.raw_partition_support = ext_csd[EXT_CSD_PARTITION_SUPPORT];
 		if ((ext_csd[EXT_CSD_PARTITION_SUPPORT] & 0x2) &&
 		    (ext_csd[EXT_CSD_PARTITION_ATTRIBUTE] & 0x1)) {
 			u8 hc_erase_grp_sz =
@@ -405,6 +406,7 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 	if (card->ext_csd.rev >= 5)
 		card->ext_csd.rel_param = ext_csd[EXT_CSD_WR_REL_PARAM];
 
+	card->ext_csd.raw_erased_mem_count = ext_csd[EXT_CSD_ERASED_MEM_CONT];
 	if (ext_csd[EXT_CSD_ERASED_MEM_CONT])
 		card->erased_byte = 0xFF;
 	else
-- 
1.7.6.1

