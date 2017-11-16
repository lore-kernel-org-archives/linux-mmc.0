From: Bastian Stender <bst@pengutronix.de>
Subject: [PATCH] mmc: core: prepend 0x to hex numbers in sysfs
Date: Thu, 16 Nov 2017 12:30:00 +0100
Message-ID: <20171116113000.25044-1-bst@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:39361 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933136AbdKPLaW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Nov 2017 06:30:22 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bojan Prtvar <prtvar.b@gmail.com>, Jungseung Lee <js07.lee@samsung.com>, linux-mmc@vger.kernel.org, kernel@pengutronix.de, Bastian Stender <bst@pengutronix.de>

The sysfs entries "pre_eol_info" and "ocr" were missing the 0x prefix
to identify them as hex formatted.

Fixes: 5fb06af7a33b ("mmc: core: Extend sysfs with OCR register")
Fixes: 46bc5c408e4e ("mmc: core: Export device lifetime information through sysfs")
Signed-off-by: Bastian Stender <bst@pengutronix.de>
---
 drivers/mmc/core/mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 36217ad5e9b1..bad5c1bf4ed9 100644
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
@@ -790,7 +790,7 @@ MMC_DEV_ATTR(enhanced_area_offset, "%llu\n",
 MMC_DEV_ATTR(enhanced_area_size, "%u\n", card->ext_csd.enhanced_area_size);
 MMC_DEV_ATTR(raw_rpmb_size_mult, "%#x\n", card->ext_csd.raw_rpmb_size_mult);
 MMC_DEV_ATTR(rel_sectors, "%#x\n", card->ext_csd.rel_sectors);
-MMC_DEV_ATTR(ocr, "%08x\n", card->ocr);
+MMC_DEV_ATTR(ocr, "0x%08x\n", card->ocr);
 MMC_DEV_ATTR(cmdq_en, "%d\n", card->ext_csd.cmdq_en);
 
 static ssize_t mmc_fwrev_show(struct device *dev,
-- 
2.11.0

