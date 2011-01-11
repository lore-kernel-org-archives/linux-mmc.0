From: Richard Zhu <r65037@freescale.com>
Subject: [REVIEW 2/2] ENGR0000137838 SDHCI Some eMMC cards can't work well in our BSP
Date: Tue, 11 Jan 2011 10:02:48 +0800
Message-ID: <1294711368-446-1-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:31703 "EHLO
	TX2EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755396Ab1AKCAj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jan 2011 21:00:39 -0500
Received: from mail94-tx2 (localhost.localdomain [127.0.0.1])	by
 mail94-tx2-R.bigfish.com (Postfix) with ESMTP id C53AC116050B	for
 <linux-mmc@vger.kernel.org>; Tue, 11 Jan 2011 02:00:37 +0000 (UTC)
Received: from TX2EHSMHS012.bigfish.com (unknown [10.9.14.248])	by
 mail94-tx2.bigfish.com (Postfix) with ESMTP id 82C2710051	for
 <linux-mmc@vger.kernel.org>; Tue, 11 Jan 2011 02:00:37 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
 [10.64.34.200])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
 p0B20Qlj025572	for <linux-mmc@vger.kernel.org>; Mon, 10 Jan 2011 19:00:29
 -0700 (MST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: r58066@freescale.com, root@udp161639uds.ap.freescale.net
Cc: lnxrevli@freescale.com, Richard Zhu <r65037@freescale.com>, linux-mmc@vger.kernel.org

Pick up the patch from the community.

fc8a0985c2846292312556cba10b8a4182f55967
From: Hanumath Prasad <hanumath.prasad@stericsson.com>
Date: Tue, 10 Aug 2010 18:01:45 -0700
Subject: [REVIEW 2/2] mmc: only set blockaddressed for > 2GiB cards

A non-zero value of SEC_COUNT does not indicate that the card is sector
addressed. According to the MMC specification, cards
with a densitygreater than 2GiB are sector addressed.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Hanumath Prasad <hanumath.prasad@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

Signed-off-by: Richard Zhu <r65037@freescale.com>

 drivers/mmc/core/mmc.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

ENGR0000137838 SDHCI Some eMMC cards can't work well in our BSP
sha             : ce733e353d0ac82c9a607b708f7de2b214408445
local branch is : imx_2.6.35
remote_branch   : origin/imx_2.6.35
branch_start    : v2.6.35.3

review-commits last updated 2010-12-31 13:49 /home/r65037/bin/linux-infra/tools/review-commits
d33ca02dca1624e86b1513e7bb7cce7281cd9590 don't generate pkg for linux-2.6-testbu
ild for cherry-pick experiment
git version 1.6.3.3


Running checkpatch.pl: 
total: 0 errors, 0 warnings, 10 lines checked

Your patch has no obvious style problems and is ready for submission.

checking header of ce733e3: ENGR0000137838 SDHCI Some eMMC cards can't work well in our BSP

check header: PASS

Checking kernel paths: PASS

review-commits: PASS
=============================================
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4a9e2ed..95e13c2 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -222,7 +222,9 @@ static int mmc_read_ext_csd(struct mmc_card *card)
 			ext_csd[EXT_CSD_SEC_CNT + 1] << 8 |
 			ext_csd[EXT_CSD_SEC_CNT + 2] << 16 |
 			ext_csd[EXT_CSD_SEC_CNT + 3] << 24;
-		if (card->ext_csd.sectors)
+
+		/* Cards with density > 2GiB are sector addressed */
+		if (card->ext_csd.sectors > (2u * 1024 * 1024 * 1024) / 512)
 			mmc_card_set_blockaddr(card);
 	}
 
-- 
1.6.3.3


