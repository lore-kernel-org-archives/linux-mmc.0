From: Sangho Yi <antiroot@gmail.com>
Subject: [PATCH 3/3] drivers: mmc: core: sdio.c: fixed from pr_warning(... to pr_warn(...
Date: Fri, 19 Oct 2012 01:06:34 +0900
Message-ID: <1350576394-2008-3-git-send-email-antiroot@gmail.com>
References: <n>
 <1350576394-2008-1-git-send-email-antiroot@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:60959 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754948Ab2JRQIN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Oct 2012 12:08:13 -0400
In-Reply-To: <1350576394-2008-1-git-send-email-antiroot@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: prakity@marvell.com, aaron.lu@amd.com, linus.walleij@linaro.org, ulf.hansson@stericsson.com, cjb@laptop.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Sangho Yi <antiroot@gmail.com>

Replaced pr_warning(... to pr_warn(... on sdio.c

Signed-off-by: Sangho Yi <antiroot@gmail.com>
---
 drivers/mmc/core/sdio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index df09b63..889d3da 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -220,7 +220,7 @@ static int sdio_enable_wide(struct mmc_card *card)
 		return ret;
 
 	if ((ctrl & SDIO_BUS_WIDTH_MASK) == SDIO_BUS_WIDTH_RESERVED)
-		pr_warning("%s: SDIO_CCCR_IF is invalid: 0x%02x\n",
+		pr_warn("%s: SDIO_CCCR_IF is invalid: 0x%02x\n",
 			   mmc_hostname(card->host), ctrl);
 
 	/* set as 4-bit bus width */
@@ -1068,7 +1068,7 @@ int mmc_attach_sdio(struct mmc_host *host)
 	 * support.
 	 */
 	if (ocr & 0x7F) {
-		pr_warning("%s: card claims to support voltages "
+		pr_warn("%s: card claims to support voltages "
 		       "below the defined range. These will be ignored.\n",
 		       mmc_hostname(host));
 		ocr &= ~0x7F;
-- 
1.7.9.5

