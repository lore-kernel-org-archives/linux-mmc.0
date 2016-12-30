From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 17/21] mmc: omap: Don't use mmc_card_present() when validating for inserted card
Date: Fri, 30 Dec 2016 13:47:30 +0100
Message-ID: <1483102054-1752-18-git-send-email-ulf.hansson@linaro.org>
References: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33986 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753908AbcL3Msi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Dec 2016 07:48:38 -0500
Received: by mail-lf0-f49.google.com with SMTP id y21so236383708lfa.1
        for <linux-mmc@vger.kernel.org>; Fri, 30 Dec 2016 04:48:37 -0800 (PST)
In-Reply-To: <1483102054-1752-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>

The mmc_card_present() function helps the mmc core to track an internal
state of the card device. More importantly, it's not intended to be used by
mmc host drivers to check for an inserted card. Therefore, let's stop using
it and instead rely on checking for a valid pointer to a struct mmc_card,
as it should be good enough.

Cc: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index be3c49f..bd49f34 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -893,7 +893,7 @@ static void mmc_omap_cover_handler(unsigned long param)
 	 * If no card is inserted, we postpone polling until
 	 * the cover has been closed.
 	 */
-	if (slot->mmc->card == NULL || !mmc_card_present(slot->mmc->card))
+	if (slot->mmc->card == NULL)
 		return;
 
 	mod_timer(&slot->cover_timer,
-- 
1.9.1

