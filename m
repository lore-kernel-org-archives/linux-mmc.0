From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: sdhci: Restore behavior while creating OCR mask
Date: Fri,  5 Jun 2015 12:06:57 +0200
Message-ID: <1433498817-16679-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:36034 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753796AbbFEKHH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jun 2015 06:07:07 -0400
Received: by laar3 with SMTP id r3so1609855laa.3
        for <linux-mmc@vger.kernel.org>; Fri, 05 Jun 2015 03:07:06 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Yangbo Lu <yangbo.lu@freescale.com>, Tim Kryger <tim.kryger@gmail.com>

Commit 3a48edc4bd68 ("mmc: sdhci: Use mmc core regulator infrastucture")
changed the behavior for how to assign the ocr_avail mask for the mmc
host. More precisely it started to mask the bits instead of assigning
them.

Restore the behavior, but also make it clear that an OCR mask created
from an external regulator overrides the other ones.

Fixes: 3a48edc4bd68 ("mmc: sdhci: Use mmc core regulator infrastucture")
Cc: Tim Kryger <tim.kryger@gmail.com>
Reported-by: Yangbo Lu <yangbo.lu@freescale.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1b4861d..706bb60 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3256,13 +3256,14 @@ int sdhci_add_host(struct sdhci_host *host)
 				   SDHCI_MAX_CURRENT_MULTIPLIER;
 	}
 
-	/* If OCR set by external regulators, use it instead */
+	/* If OCR set by host, use it instead. */
+	if (host->ocr_mask)
+		ocr_avail = host->ocr_mask;
+
+	/* If OCR set by external regulators, give it highest prio. */
 	if (mmc->ocr_avail)
 		ocr_avail = mmc->ocr_avail;
 
-	if (host->ocr_mask)
-		ocr_avail &= host->ocr_mask;
-
 	mmc->ocr_avail = ocr_avail;
 	mmc->ocr_avail_sdio = ocr_avail;
 	if (host->ocr_avail_sdio)
-- 
1.9.1

