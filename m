From: Bing Zhao <bzhao@marvell.com>
Subject: [PATCH v2] sdio: skip initialization on powered resume
Date: Wed,  1 Sep 2010 18:41:32 -0700
Message-ID: <1283391692-14150-1-git-send-email-bzhao@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from dakia2.marvell.com ([65.219.4.35]:45267 "EHLO
	dakia2.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182Ab0IBBOM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Sep 2010 21:14:12 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Bing Zhao <bzhao@marvell.com>, Michal Miroslaw <mirqus@gmail.com>, Nicolas Pitre <nico@fluxnic.net>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>

Quoted Michal Miroslaw's comment:

Simplified SDIO spec v.2.00 (section 6.14 - Bus State Diagram)
suggests, that initialization commands (CMD5, CMD3) are not accepted
in CMD state. As the card stays in that state on powered suspend (no
resetting CMD52 nor power cycle is issued) then reinitialization
should be entirely skipped on resume unless the power was lost between
suspend and resume (or card was temporarily removed from the slot).

Signed-off-by: Bing Zhao <bzhao@marvell.com>
---
Changes since v1:
	* Subject changed (was "add MMC_PM_SKIP_RESUME_PROBE to...")
	* No need to introduce new flag MMC_PM_SKIP_RESUME_PROBE
	* Add Michal Miroslaw's comment as patch description

 drivers/mmc/core/sdio.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index f332c52..64d2471 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -605,15 +605,23 @@ static int mmc_sdio_suspend(struct mmc_host *host)
 
 static int mmc_sdio_resume(struct mmc_host *host)
 {
-	int i, err;
+	int i, err = 0;
 
 	BUG_ON(!host);
 	BUG_ON(!host->card);
 
 	/* Basic card reinitialization. */
 	mmc_claim_host(host);
-	err = mmc_sdio_init_card(host, host->ocr, host->card,
-				 (host->pm_flags & MMC_PM_KEEP_POWER));
+
+	/*
+	 * Simplified SDIO spec v2.00 (section 6.14 - Bus State Diagram)
+	 * suggests that initialization should be skipped on powered resume.
+	 */
+	if (!(host->pm_flags & MMC_PM_KEEP_POWER)) {
+		err = mmc_sdio_init_card(host, host->ocr, host->card,
+					host->pm_flags & MMC_PM_KEEP_POWER);
+	}
+
 	if (!err) {
 		/* We may have switched to 1-bit mode during suspend. */
 		err = sdio_enable_4bit_bus(host->card);
-- 
1.5.3.6

