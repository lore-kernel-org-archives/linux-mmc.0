From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 2/2] mmc: core: add the quirk for broken revision
Date: Fri, 24 Aug 2012 09:23:23 +0900
Message-ID: <5036C97B.2040704@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:33931 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257Ab2HXAXk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Aug 2012 20:23:40 -0400
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M980050PH2FFC40@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 24 Aug 2012 09:23:40 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M98002PTH3FQ410@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 24 Aug 2012 09:23:39 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

When mmc card initiailize,
if read the wrong revsion value(upper than 0x6), eMMC-init should be failed.
But If we known already eMMC card revision, we can init with
quirk_broken_revision.
(Assume we know exactly eMMC card revision,and use the MMC_FIXUP() for specific eMMC card.)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/core/mmc.c   |   13 +++++++++----
 include/linux/mmc/card.h |    1 +
 include/linux/mmc/host.h |    1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 0811fb7..9297bdb 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -293,10 +293,15 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 
 	card->ext_csd.rev = ext_csd[EXT_CSD_REV];
 	if (card->ext_csd.rev > 7) {
-		pr_err("%s: unrecognised EXT_CSD revision %d\n",
-			mmc_hostname(card->host), card->ext_csd.rev);
-		err = -EINVAL;
-		goto out;
+		if ((card->quirks & MMC_QUIRK_BROKEN_REV) &&
+				card->host->known_rev)
+			card->ext_csd.rev = card->host->known_rev;
+		else {
+			pr_err("%s: unrecognised EXT_CSD revision %d\n",
+				mmc_hostname(card->host), card->ext_csd.rev);
+			err = -EINVAL;
+			goto out;
+		}
 	}
 
 	card->ext_csd.raw_sectors[0] = ext_csd[EXT_CSD_SEC_CNT + 0];
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 111aca5..47241cc 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -240,6 +240,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_BYTE_MODE_512 (1<<8)	/* Avoid sending 512 bytes in */
 #define MMC_QUIRK_LONG_READ_TIME (1<<9)		/* Data read time > CSD says */
 						/* byte mode */
+#define MMC_QUIRK_BROKEN_REV	(1<<10)		/* If broken card revision, set to known revision */
 	unsigned int    poweroff_notify_state;	/* eMMC4.5 notify feature */
 #define MMC_NO_POWER_NOTIFICATION	0
 #define MMC_POWERED_ON			1
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index f578a71..4506bfa 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -192,6 +192,7 @@ struct mmc_host {
 	u32			max_current_330;
 	u32			max_current_300;
 	u32			max_current_180;
+	u8			known_rev;	/* Set to known revision */
 
 #define MMC_VDD_165_195		0x00000080	/* VDD voltage 1.65 - 1.95 */
 #define MMC_VDD_20_21		0x00000100	/* VDD voltage 2.0 ~ 2.1 */
-- 
1.7.4.1
