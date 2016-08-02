From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0691/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:37:11 +0800
Message-ID: <20160802113711.28131-1-baolex.ni@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:4851 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934773AbcHBMij (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 2 Aug 2016 08:38:39 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, gregkh@linuxfoundation.org, jirislaby@gmail.com, mchehab@redhat.com, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, jonathanh@nvidia.com, grundler@chromium.org, lporzio@micron.com, chuansheng.liu@intel.com, baolex.ni@intel.com

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/mmc/card/block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index e62fde3..75ee88a 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -130,7 +130,7 @@ enum {
 	MMC_PACKED_NR_SINGLE,
 };
 
-module_param(perdev_minors, int, 0444);
+module_param(perdev_minors, int, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(perdev_minors, "Minors numbers to allocate per device");
 
 static inline int mmc_blk_part_switch(struct mmc_card *card,
-- 
2.9.2

