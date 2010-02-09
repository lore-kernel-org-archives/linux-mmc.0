From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 3/5] SDIO: Don't use CMD[357] as part of a powered SDIO resume
Date: Tue, 09 Feb 2010 15:29:24 -0500
Message-ID: <1265747366-6676-4-git-send-email-nico@fluxnic.net>
References: <1265747366-6676-1-git-send-email-nico@fluxnic.net>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:12186 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab0BIU3w (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Feb 2010 15:29:52 -0500
Received: from localhost.localdomain ([66.130.28.92])
 by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KXL00I4TCXNVXE0@VL-MH-MR002.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Tue, 09 Feb 2010 15:29:49 -0500 (EST)
In-reply-to: <1265747366-6676-1-git-send-email-nico@fluxnic.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org

From: Chris Ball <cjb@laptop.org>

Seen on a Marvell 8686 SDIO card and Via VX855 controller:  we must avoid
sending CMD3/5/7 on a resume where power has been maintained, because the
8686 will refuse to respond to them and the MMC stack will give up on
the card.

Signed-off-by: Chris Ball <cjb@laptop.org>
Signed-off-by: Nicolas Pitre <nico@marvell.com>
---
 drivers/mmc/core/sdio.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 06b6408..7d8ba64 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -224,7 +224,7 @@ static int sdio_enable_hs(struct mmc_card *card)
  * we're trying to reinitialise.
  */
 static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
-			      struct mmc_card *oldcard)
+			      struct mmc_card *oldcard, int powered_resume)
 {
 	struct mmc_card *card;
 	int err;
@@ -235,9 +235,11 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	/*
 	 * Inform the card of the voltage
 	 */
-	err = mmc_send_io_op_cond(host, host->ocr, &ocr);
-	if (err)
-		goto err;
+	if (!powered_resume) {
+		err = mmc_send_io_op_cond(host, host->ocr, &ocr);
+		if (err)
+			goto err;
+	}
 
 	/*
 	 * For SPI, enable CRC as appropriate.
@@ -262,7 +264,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	/*
 	 * For native busses:  set card RCA and quit open drain mode.
 	 */
-	if (!mmc_host_is_spi(host)) {
+	if (!powered_resume && !mmc_host_is_spi(host)) {
 		err = mmc_send_relative_addr(host, &card->rca);
 		if (err)
 			goto remove;
@@ -273,7 +275,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	/*
 	 * Select card, as all following commands rely on that.
 	 */
-	if (!mmc_host_is_spi(host)) {
+	if (!powered_resume && !mmc_host_is_spi(host)) {
 		err = mmc_select_card(card);
 		if (err)
 			goto remove;
@@ -437,7 +439,8 @@ static int mmc_sdio_resume(struct mmc_host *host)
 
 	/* Basic card reinitialization. */
 	mmc_claim_host(host);
-	err = mmc_sdio_init_card(host, host->ocr, host->card);
+	err = mmc_sdio_init_card(host, host->ocr, host->card,
+				 (host->pm_flags & MMC_PM_KEEP_POWER));
 	mmc_release_host(host);
 
 	/*
@@ -507,7 +510,7 @@ int mmc_attach_sdio(struct mmc_host *host, u32 ocr)
 	/*
 	 * Detect and init the card.
 	 */
-	err = mmc_sdio_init_card(host, host->ocr, NULL);
+	err = mmc_sdio_init_card(host, host->ocr, NULL, 0);
 	if (err)
 		goto err;
 	card = host->card;
-- 
1.7.0.rc2.1.g694b5

