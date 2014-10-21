From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 04/15] mmc: core: Remove redundant check of max_dtr while selecting timings
Date: Tue, 21 Oct 2014 19:19:02 +0200
Message-ID: <1413911953-19012-5-git-send-email-ulf.hansson@linaro.org>
References: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:46021 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933121AbaJURT1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Oct 2014 13:19:27 -0400
Received: by mail-lb0-f180.google.com with SMTP id n15so1407652lbi.11
        for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2014 10:19:25 -0700 (PDT)
In-Reply-To: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

If the MMC spec version is < CSD_SPEC_VER_4, there aren't support for
the EXT_CSD register. Since max_dtr is fetched from there, it will
default to zero, which thus isn't needed to verify.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 2da3a53..185d114 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1132,8 +1132,7 @@ static int mmc_select_timing(struct mmc_card *card)
 {
 	int err = 0;
 
-	if ((card->csd.mmca_vsn < CSD_SPEC_VER_4 &&
-	     card->ext_csd.hs_max_dtr == 0))
+	if (card->csd.mmca_vsn < CSD_SPEC_VER_4)
 		goto bus_speed;
 
 	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
-- 
1.9.1

