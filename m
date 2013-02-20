From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH] mmc: core: enhance card remove detection for gpio detect
Date: Wed, 20 Feb 2013 17:45:13 +0800
Message-ID: <1361353514-18258-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:43924 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933773Ab3BTJpb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Feb 2013 04:45:31 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Lars-Peter Clausen <lars@metafoo.de>, Mike Rapoport <mike@compulab.co.il>, Nicolas Pitre <nico@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao

Current code detect card removal only by judging the result of
sending cmd13 to card, which is not safe for card with external
gpio detection. The communication status between host and card
may out of sync with the external gpio status if remove slowly
or hand shake during card removal.

For a card with external gpio detection, this patch add the
gpio detection into consideration when detect card removal.
The judgement result won't return until both the gpio status
and cmd13 result are synced or wait more than 1 second.

This patch won't impact to cards not using gpio detection.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/core/core.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index b8c3d41..61ec354 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -32,6 +32,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sd.h>
+#include <linux/mmc/slot-gpio.h>
 
 #include "core.h"
 #include "bus.h"
@@ -2281,7 +2282,7 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 
 int _mmc_detect_card_removed(struct mmc_host *host)
 {
-	int ret;
+	int ret, gpio_cd, retries = 10;
 
 	if ((host->caps & MMC_CAP_NONREMOVABLE) || !host->bus_ops->alive)
 		return 0;
@@ -2290,6 +2291,17 @@ int _mmc_detect_card_removed(struct mmc_host *host)
 		return 1;
 
 	ret = host->bus_ops->alive(host);
+	gpio_cd = mmc_gpio_get_cd(host);
+	if (gpio_cd >= 0) {
+		while (((ret && gpio_cd) || (!ret && !gpio_cd)) && --retries) {
+			msleep(100);
+			ret = host->bus_ops->alive(host);
+			gpio_cd = mmc_gpio_get_cd(host);
+		}
+		if (!retries)
+			pr_warn("%s: card insert/remove too slow\n",
+					mmc_hostname(host));
+	}
 	if (ret) {
 		mmc_card_set_removed(host->card);
 		pr_debug("%s: card remove detected\n", mmc_hostname(host));
-- 
1.7.9.5

