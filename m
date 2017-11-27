From: Bastian Stender <bst@pengutronix.de>
Subject: [PATCH v2 2/2] mmc: core: prepend 0x to pre_erol_info entry in sysfs
Date: Mon, 27 Nov 2017 14:17:21 +0100
Message-ID: <20171127131721.865-2-bst@pengutronix.de>
References: <20171127131721.865-1-bst@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:36883 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752094AbdK0NSg (ORCPT
        <rfc822;linux-mmc@vger.kernel.ORG>); Mon, 27 Nov 2017 08:18:36 -0500
In-Reply-To: <20171127131721.865-1-bst@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Bojan Prtvar <prtvar.b@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jungseung Lee <js07.lee@samsung.com>, kernel@pengutronix.de, Bastian Stender <bst@pengutronix.de>

The sysfs entry "pre_eol_info" was missing the 0x prefix to identify it
as hex formatted.

Fixes: 46bc5c408e4e ("mmc: core: Export device lifetime information through sysfs")
Signed-off-by: Bastian Stender <bst@pengutronix.de>
---
Changes since (implicit) v1 ("mmc: core: prepend 0x to hex numbers in sysfs"):
  - split into two patches, each fixing its introducing commit (as
    requested by Ulf Hansson)
---
 drivers/mmc/core/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index b935ad895701..bad5c1bf4ed9 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
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

