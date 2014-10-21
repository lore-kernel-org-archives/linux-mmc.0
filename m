From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 03/15] mmc: core: Remove redundant check while selecting powerclass
Date: Tue, 21 Oct 2014 19:19:01 +0200
Message-ID: <1413911953-19012-4-git-send-email-ulf.hansson@linaro.org>
References: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:52364 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933117AbaJURTZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Oct 2014 13:19:25 -0400
Received: by mail-la0-f41.google.com with SMTP id pn19so1442689lab.14
        for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2014 10:19:23 -0700 (PDT)
In-Reply-To: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

The validation of the buswidth and the MMC spec version in
__mmc_select_powerclass() is redundant, let's remove it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 87ee28f..2da3a53 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -768,14 +768,6 @@ static int __mmc_select_powerclass(struct mmc_card *card,
 	unsigned int pwrclass_val = 0;
 	int err = 0;
 
-	/* Power class selection is supported for versions >= 4.0 */
-	if (card->csd.mmca_vsn < CSD_SPEC_VER_4)
-		return 0;
-
-	/* Power class values are defined only for 4/8 bit bus */
-	if (bus_width == EXT_CSD_BUS_WIDTH_1)
-		return 0;
-
 	switch (1 << host->ios.vdd) {
 	case MMC_VDD_165_195:
 		if (host->ios.clock <= MMC_HIGH_26_MAX_DTR)
-- 
1.9.1

