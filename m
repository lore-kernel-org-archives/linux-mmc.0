From: Yunpeng Gao <yunpeng.gao@intel.com>
Subject: [PATCH] mmc: core: export more sysfs for debugging purpose
Date: Tue, 12 Aug 2014 15:28:54 +0800
Message-ID: <1407828534-15846-1-git-send-email-yunpeng.gao@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49682 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981AbaHLHgn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Aug 2014 03:36:43 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Yunpeng Gao <yunpeng.gao@intel.com>, Chuanxiao Xiao <chuanxiao.dong@intel.com>

Add some more sysfs export related to eMMC BK Ops,
HPI and Hardware Reset features. It'll be helpful
for debugging.

Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>
Signed-off-by: Chuanxiao Xiao <chuanxiao.dong@intel.com>
---
 drivers/mmc/core/mmc.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 793c6f7..15b7ab0 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -710,6 +710,12 @@ MMC_DEV_ATTR(enhanced_area_offset, "%llu\n",
 MMC_DEV_ATTR(enhanced_area_size, "%u\n", card->ext_csd.enhanced_area_size);
 MMC_DEV_ATTR(raw_rpmb_size_mult, "%#x\n", card->ext_csd.raw_rpmb_size_mult);
 MMC_DEV_ATTR(rel_sectors, "%#x\n", card->ext_csd.rel_sectors);
+MMC_DEV_ATTR(hpi_support, "%d\n", card->ext_csd.hpi);
+MMC_DEV_ATTR(hpi_enable, "%d\n", card->ext_csd.hpi_en);
+MMC_DEV_ATTR(hpi_command, "%d\n", card->ext_csd.hpi_cmd);
+MMC_DEV_ATTR(hw_reset_support, "%d\n", card->ext_csd.rst_n_function);
+MMC_DEV_ATTR(bkops_support, "%d\n", card->ext_csd.bkops);
+MMC_DEV_ATTR(bkops_enable, "%d\n", card->ext_csd.bkops_en);
 
 static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_cid.attr,
@@ -728,6 +734,12 @@ static struct attribute *mmc_std_attrs[] = {
 	&dev_attr_enhanced_area_size.attr,
 	&dev_attr_raw_rpmb_size_mult.attr,
 	&dev_attr_rel_sectors.attr,
+	&dev_attr_hpi_support.attr,
+	&dev_attr_hpi_enable.attr,
+	&dev_attr_hpi_command.attr,
+	&dev_attr_hw_reset_support.attr,
+	&dev_attr_bkops_support.attr,
+	&dev_attr_bkops_enable.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(mmc_std);
-- 
1.7.9.5

