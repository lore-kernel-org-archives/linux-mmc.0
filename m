From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH] mmc: core: update the power up time according to spec
Date: Wed, 27 Feb 2013 17:26:48 +0800
Message-ID: <1361957208-19433-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:44376 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755697Ab3B0J2g (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Feb 2013 04:28:36 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Lars-Peter Clausen <lars@metafoo.de>, Mike Rapoport <mike@compulab.co.il>, Nicolas Pitre <nico@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>

According to spec, the maximum power up time is 35ms.
Please refer to below spec for sd and emmc:
"SD Physical Layer Specification 4.10, chapter 6.4.1.2
Power Up Time of Host."
"JEDEC 4.5.1, chapter 10.3.3 Power supply voltages."

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/core/core.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 538c8d9..e8e7a85 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1490,10 +1490,9 @@ static void mmc_power_up(struct mmc_host *host)
 	__mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330);
 
 	/*
-	 * This delay should be sufficient to allow the power supply
-	 * to reach the minimum voltage.
+	 * The maximum power ramp up time is 35ms according to spec.
 	 */
-	mmc_delay(10);
+	mmc_delay(35);
 
 	host->ios.clock = host->f_init;
 
-- 
1.7.9.5

