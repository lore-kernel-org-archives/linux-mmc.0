From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 1/1] mmc: quirks: Fixup debug message
Date: Tue, 20 May 2014 13:29:21 +0200
Message-ID: <1400585361-5194-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:52402 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751760AbaETLal (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 May 2014 07:30:41 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, linux-mmc@vger.kernel.org

There is no need for an output like this:
> mmcblk mmc1:0001: calling add_quirk_mmc+0x0/0x20
Instead use this one:
> mmcblk mmc1:0001: calling add_quirk_mmc

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/mmc/core/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/quirks.c b/drivers/mmc/core/quirks.c
index 6c36fcc..dd1d1e0 100644
--- a/drivers/mmc/core/quirks.c
+++ b/drivers/mmc/core/quirks.c
@@ -91,7 +91,7 @@ void mmc_fixup_device(struct mmc_card *card, const struct mmc_fixup *table)
 		    (f->cis_device == card->cis.device ||
 		     f->cis_device == (u16) SDIO_ANY_ID) &&
 		    rev >= f->rev_start && rev <= f->rev_end) {
-			dev_dbg(&card->dev, "calling %pF\n", f->vendor_fixup);
+			dev_dbg(&card->dev, "calling %pf\n", f->vendor_fixup);
 			f->vendor_fixup(card, f->data);
 		}
 	}
-- 
1.8.5.5

