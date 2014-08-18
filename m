From: Yunpeng Gao <yunpeng.gao@intel.com>
Subject: [PATCH] mmc: core: Change the enhanced area sysfs output format
Date: Mon, 18 Aug 2014 13:24:06 +0800
Message-ID: <1408339446-7828-1-git-send-email-yunpeng.gao@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:60279 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762AbaHRFWX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 18 Aug 2014 01:22:23 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: "Zhang, YiX X" <yix.x.zhang@intel.com>, Yunpeng Gao <yunpeng.gao@intel.com>

From: "Zhang, YiX X" <yix.x.zhang@intel.com>

Current sysfs output format for eMMC Enhanced Area feature
are incorrect.

If the enhanced area feature not enabled, then the driver
will return error code -EINVAL(-22) as the sysfs value.

But the definition for those two sysfs items are
unsigned int and unsigned long long.

So, if Enhanced area feature not enabled on the eMMC device,
then output similar to below may be observed:
...
	#cat /sys/block/mmcblk0/device/enhanced_area_offset
	#18446744073709551594
	#cat /sys/block/mmcblk0/device/enhanced_area_size
	#4294967274

Submit this patch to change the output format to display
the correct value.

Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>
---
 drivers/mmc/core/mmc.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 793c6f7..a57827a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -705,9 +705,10 @@ MMC_DEV_ATTR(name, "%s\n", card->cid.prod_name);
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
1.7.9.5

