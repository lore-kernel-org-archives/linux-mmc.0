From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v3] mmc: core: enhance card remove detection for gpio detect
Date: Fri, 22 Feb 2013 10:56:40 +0800
Message-ID: <1361501800-3658-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:38053 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753504Ab3BVC50 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Feb 2013 21:57:26 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Lars-Peter Clausen <lars@metafoo.de>, Mike Rapoport <mike@compulab.co.il>, Nicolas Pitre <nico@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>

Current code detect card removal only by judging the result of
sending cmd13 to card, which is not safe for card with external
gpio detection. The communication status between host and card
may out of sync with the external gpio status if remove the card
slowly or hands shake during the process. The reason is the async
between card detect and pin contact in slot/card hardware.

The sequence is below when the issue occur (remove the card slowly):
1. gpio level changed and card detect interrupt triggered.
2. mmc_rescan is launched.
3. the card pin is still contacted with the slot because of slow
   removal. So _mmc_detect_card_removed and mmc_rescan think card is
   still present.
4. card pin is disconnected from the card slot pin contact.
So the card is really removed finally but the card removal event
has been missed by system.
The interval length between step 1 and step 4 depends on the
card removal speed. If it's longer than the detect work schedule
delay which is 200ms, this issue will likely happen.

For a card with external gpio detection, this patch add the
gpio detection into consideration when detect card removal.
If the gpio status and cmd13 result are out of sync then schedule
another detect work 200ms later.

This patch won't impact to cards not using gpio detection.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/core/core.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index b8c3d41..897ceb2 100644
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
+	int ret, gpio_cd;
 
 	if ((host->caps & MMC_CAP_NONREMOVABLE) || !host->bus_ops->alive)
 		return 0;
@@ -2290,6 +2291,20 @@ int _mmc_detect_card_removed(struct mmc_host *host)
 		return 1;
 
 	ret = host->bus_ops->alive(host);
+	/*
+	 * If card use gpio detection then the gpio status and alive check
+	 * may out of sync because of the async between card detect and
+	 * pin contact in slot hardware. So schedule a detect work 200ms
+	 * later in this case.
+	 */
+	gpio_cd = mmc_gpio_get_cd(host);
+	if (!IS_ERR_VALUE(gpio_cd)) {
+		if (!ret ^ !!gpio_cd) {
+			mmc_detect_change(host, msecs_to_jiffies(200));
+			pr_warn("%s: card insert/remove too slowly\n",
+					mmc_hostname(host));
+		}
+	}
 	if (ret) {
 		mmc_card_set_removed(host->card);
 		pr_debug("%s: card remove detected\n", mmc_hostname(host));
-- 
1.7.9.5

