From: Beata Baranowska <beatax.baranowska@intel.com>
Subject: [PATCH] mmc: Change the enhanced area related sysfs output format
Date: Tue, 14 Jun 2016 10:33:06 +0200
Message-ID: <1465893186-6399-1-git-send-email-beatax.baranowska@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, aisheng.dong@nxp.com, wsa+renesas@sang-engineering.com, gwendal@chromium.org, chaotian.jing@mediatek.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: sebastianx.jarosz@intel.com, beatax.baranowska@intel.com, Chuanxiao Dong <chuanxiao.dong@intel.com>
List-Id: linux-mmc@vger.kernel.org

From: Chuanxiao Dong <chuanxiao.dong@intel.com>

When the enhanced area feature was not enabled, the related sysfs will 
have -EINVAL(-22) value, so change the sysfs output format to display 
the correct value.

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/core/mmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 5d438ad3ee32..cc55253a5d47 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -722,9 +722,10 @@ MMC_DEV_ATTR(name, "%s\n", card->cid.prod_name);
 MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
 MMC_DEV_ATTR(prv, "0x%x\n", card->cid.prv);
 MMC_DEV_ATTR(serial, "0x%08x\n", card->cid.serial);
-MMC_DEV_ATTR(enhanced_area_offset, "%llu\n",
+MMC_DEV_ATTR(enhanced_area_offset, "%lld\n",
 		card->ext_csd.enhanced_area_offset);
-MMC_DEV_ATTR(enhanced_area_size, "%u\n", card->ext_csd.enhanced_area_size);
+MMC_DEV_ATTR(enhanced_area_size, "%d KBytes\n",
+		card->ext_csd.enhanced_area_size);
 MMC_DEV_ATTR(raw_rpmb_size_mult, "%#x\n", card->ext_csd.raw_rpmb_size_mult);
 MMC_DEV_ATTR(rel_sectors, "%#x\n", card->ext_csd.rel_sectors);
 
-- 
