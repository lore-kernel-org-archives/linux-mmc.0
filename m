From: akpm@linux-foundation.org
Subject: [patch 103/160] sdio: don't use CMD[357] as part of a powered SDIO resume
Date: Fri, 05 Mar 2010 13:43:33 -0800
Message-ID: <201003052143.o25LhXD4029782@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:32808 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755358Ab0CEVni (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Mar 2010 16:43:38 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, cjb@laptop.org, linux-mmc@vger.kernel.org, nico@marvell.com

From: Chris Ball <cjb@laptop.org>

Seen on a Marvell 8686 SDIO card and Via VX855 controller: we must avoid
sending CMD3/5/7 on a resume where power has been maintained, because the
8686 will refuse to respond to them and the MMC stack will give up on the
card.

Signed-off-by: Chris Ball <cjb@laptop.org>
Signed-off-by: Nicolas Pitre <nico@marvell.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/core/sdio.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff -puN drivers/mmc/core/sdio.c~sdio-dont-use-cmd-as-part-of-a-powered-sdio-resume drivers/mmc/core/sdio.c
--- a/drivers/mmc/core/sdio.c~sdio-dont-use-cmd-as-part-of-a-powered-sdio-resume
+++ a/drivers/mmc/core/sdio.c
@@ -224,7 +224,7 @@ static int sdio_enable_hs(struct mmc_car
  * we're trying to reinitialise.
  */
 static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
-			      struct mmc_card *oldcard)
+			      struct mmc_card *oldcard, int powered_resume)
 {
 	struct mmc_card *card;
 	int err;
@@ -235,9 +235,11 @@ static int mmc_sdio_init_card(struct mmc
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
@@ -262,7 +264,7 @@ static int mmc_sdio_init_card(struct mmc
 	/*
 	 * For native busses:  set card RCA and quit open drain mode.
 	 */
-	if (!mmc_host_is_spi(host)) {
+	if (!powered_resume && !mmc_host_is_spi(host)) {
 		err = mmc_send_relative_addr(host, &card->rca);
 		if (err)
 			goto remove;
@@ -273,7 +275,7 @@ static int mmc_sdio_init_card(struct mmc
 	/*
 	 * Select card, as all following commands rely on that.
 	 */
-	if (!mmc_host_is_spi(host)) {
+	if (!powered_resume && !mmc_host_is_spi(host)) {
 		err = mmc_select_card(card);
 		if (err)
 			goto remove;
@@ -437,7 +439,8 @@ static int mmc_sdio_resume(struct mmc_ho
 
 	/* Basic card reinitialization. */
 	mmc_claim_host(host);
-	err = mmc_sdio_init_card(host, host->ocr, host->card);
+	err = mmc_sdio_init_card(host, host->ocr, host->card,
+				 (host->pm_flags & MMC_PM_KEEP_POWER));
 	mmc_release_host(host);
 
 	/*
@@ -507,7 +510,7 @@ int mmc_attach_sdio(struct mmc_host *hos
 	/*
 	 * Detect and init the card.
 	 */
-	err = mmc_sdio_init_card(host, host->ocr, NULL);
+	err = mmc_sdio_init_card(host, host->ocr, NULL, 0);
 	if (err)
 		goto err;
 	card = host->card;
_
