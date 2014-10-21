From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 09/15] mmc: core: Don't panic when fetching EXT_CSD
Date: Tue, 21 Oct 2014 19:19:07 +0200
Message-ID: <1413911953-19012-10-git-send-email-ulf.hansson@linaro.org>
References: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:42875 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933135AbaJURTh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Oct 2014 13:19:37 -0400
Received: by mail-lb0-f182.google.com with SMTP id z11so1361129lbi.41
        for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2014 10:19:36 -0700 (PDT)
In-Reply-To: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

Instead of doing BUG_ON(), return an error code.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 755019d..55757fe 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -185,8 +185,8 @@ static int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd)
 	int err;
 	u8 *ext_csd;
 
-	BUG_ON(!card);
-	BUG_ON(!new_ext_csd);
+	if (!card || !new_ext_csd)
+		return -EINVAL;
 
 	if (!mmc_can_ext_csd(card))
 		return -EOPNOTSUPP;
@@ -368,8 +368,6 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 	int err = 0, idx;
 	unsigned int part_size;
 
-	BUG_ON(!card);
-
 	/* Version is coded in the CSD_STRUCTURE byte in the EXT_CSD register */
 	card->ext_csd.raw_ext_csd_structure = ext_csd[EXT_CSD_STRUCTURE];
 	if (card->csd.structure == 3) {
-- 
1.9.1

