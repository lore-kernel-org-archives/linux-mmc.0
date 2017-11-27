From: Bastian Stender <bst@pengutronix.de>
Subject: [PATCH v2 1/2] mmc: core: prepend 0x to OCR entry in sysfs
Date: Mon, 27 Nov 2017 14:17:20 +0100
Message-ID: <20171127131721.865-1-bst@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49849 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751838AbdK0NSg (ORCPT
        <rfc822;linux-mmc@vger.kernel.ORG>); Mon, 27 Nov 2017 08:18:36 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Bojan Prtvar <prtvar.b@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jungseung Lee <js07.lee@samsung.com>, kernel@pengutronix.de, Bastian Stender <bst@pengutronix.de>

The sysfs entry "ocr" was missing the 0x prefix to identify it as hex
formatted.

Fixes: 5fb06af7a33b ("mmc: core: Extend sysfs with OCR register")
Signed-off-by: Bastian Stender <bst@pengutronix.de>
---
Changes since (implicit) v1 ("mmc: core: prepend 0x to hex numbers in sysfs"):
  - split into two patches, each fixing its introducing commit (as
    requested by Ulf Hansson)
---
 drivers/mmc/core/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 36217ad5e9b1..b935ad895701 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -780,7 +780,7 @@ MMC_DEV_ATTR(manfid, "0x%06x\n", card->cid.manfid);
 MMC_DEV_ATTR(name, "%s\n", card->cid.prod_name);
 MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
 MMC_DEV_ATTR(prv, "0x%x\n", card->cid.prv);
-MMC_DEV_ATTR(pre_eol_info, "%02x\n", card->ext_csd.pre_eol_info);
+MMC_DEV_ATTR(pre_eol_info, "0x%02x\n", card->ext_csd.pre_eol_info);
 MMC_DEV_ATTR(life_time, "0x%02x 0x%02x\n",
 	card->ext_csd.device_life_time_est_typ_a,
 	card->ext_csd.device_life_time_est_typ_b);
-- 
2.11.0

