From: Yunpeng Gao <yunpeng.gao@intel.com>
Subject: [PATCH] mmc: core: optimize mmc device power up ramp up time
Date: Mon, 18 Aug 2014 14:17:05 +0800
Message-ID: <1408342625-23720-1-git-send-email-yunpeng.gao@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:65075 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870AbaHRGPT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 18 Aug 2014 02:15:19 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Yunpeng Gao <yunpeng.gao@intel.com>, Chuanxiao Dong <chuanxiao.dong@intel.com>

In current kernel mmc driver, it uses two 'msleep(10)'
for eMMC/SD card power up ramp up time delay.

According to Spec, the ramp up time should be max of 74
eMMC/SD bus clock or 1ms.
Take the worst eMMC/SD card I can image as the example -
assume it has to work on 32KHz or 16KHz during the card initialzation,
then 74 clock should be 2.312ms or 4.625ms.
So, 5ms delay should be enough.

Also, msleep(10) will invlove sechdule and may consume
more time than what we expected.
Measured on Merrifield platform showed it consumed almost
2*20 = 40ms. This is much more than what we expected.

Submit this patch to reduce the time of mmc boot up and
the time of mmc D3 resume.

Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>
Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/core/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 7dc0c85..7bcb797 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1556,7 +1556,7 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
 	 * This delay should be sufficient to allow the power supply
 	 * to reach the minimum voltage.
 	 */
-	mmc_delay(10);
+	usleep_range(10000, 12000);
 
 	host->ios.clock = host->f_init;
 
@@ -1567,7 +1567,7 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
 	 * This delay must be at least 74 clock sizes, or 1 ms, or the
 	 * time required to reach a stable voltage.
 	 */
-	mmc_delay(10);
+	usleep_range(5000, 6000);
 
 	mmc_host_clk_release(host);
 }
-- 
1.7.9.5

