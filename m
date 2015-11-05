From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: core: Check for non-removable cards earlier in the error path
Date: Thu,  5 Nov 2015 16:21:39 +0100
Message-ID: <1446736899-21542-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33671 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754933AbbKEPVt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2015 10:21:49 -0500
Received: by lfbf136 with SMTP id f136so59011354lfb.0
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2015 07:21:47 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>

_mmc_detect_card_removed() validates that the card is removable, but when
being called via the bus_ops ->detect() callbacks, the validation is
redundant as it's already done in mmc_rescan().

Move the validation of a removable card to the mmc_detect_card_removed()
API, which is where it's applicable, to allow the blk error recovery path
to get the response a bit earlier.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5ae89e4..34243f7 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2498,9 +2498,6 @@ int _mmc_detect_card_removed(struct mmc_host *host)
 {
 	int ret;
 
-	if (host->caps & MMC_CAP_NONREMOVABLE)
-		return 0;
-
 	if (!host->card || mmc_card_removed(host->card))
 		return 1;
 
@@ -2536,6 +2533,9 @@ int mmc_detect_card_removed(struct mmc_host *host)
 	if (!card)
 		return 1;
 
+	if (host->caps & MMC_CAP_NONREMOVABLE)
+		return 0;
+
 	ret = mmc_card_removed(card);
 	/*
 	 * The card will be considered unchanged unless we have been asked to
-- 
1.9.1

