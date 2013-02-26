From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 1/2 v4] mmc: core: enhance card removal judgement for slow removal
Date: Tue, 26 Feb 2013 17:48:04 +0800
Message-ID: <1361872084-13370-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:47795 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932568Ab3BZJsI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Feb 2013 04:48:08 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Lars-Peter Clausen <lars@metafoo.de>, Mike Rapoport <mike@compulab.co.il>, Nicolas Pitre <nico@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>

Function _mmc_detect_card_removed will be called to know whether
the card is still present when host->bus_ops->detect is called.
In current code, the return value of this function generally only
depend on the result of sending cmd13 to card, which may not safe
for card with detection support like slot gpio detection.
Because the communication status between host and card may out of
sync with the detect status if remove the card slowly or hands shake
during the process. The direct reason is the async between card
detect switch and card/slot pad contaction in hardware, which is
defined by spec.

The spec define card insert/remove sequence as below (both standard size
SD card and MicroSD card have the same sequence):
"Part 1 Standard Size SD Card Mechanical Addendum Ver4.00 Final,
Appendix C: Card Detection Switch" (Take normally open type as example)
a)SD card insertion sequence:
  The card detection switch should be turned on after all SD card
  contact pads are connected to the host connector contact pads.
b)SD removal sequence:
  The card detection switch should be turned off when the SD card
  is just going to be removed and before any SD card contact pad is
  disconnected from the host connector contact pad.

Below is the sequence when this issue occur (Take slot gpio detection
as example and remove the card slowly during the process):
1. gpio level changed and card detect interrupt triggered.
2. mmc_rescan was launched.
3. the card pads were still contacted with the slot pads because of slow
   removal. So _mmc_detect_card_removed and mmc_rescan think card was
   still present (cmd13 succeed).
4. card pads were discontacted from the card slot pads.
So the card was actually removed finally but the card removal event
has been missed by system.
The interval length between step 1 and step 4 depends on the
card removal speed. If it's longer than the detect work schedule
delay which is 200ms, this issue will likely happen.

This patch add the card detect status check in function
_mmc_detect_card_removed if host->ops->get_cd existed.
If the card detect status and cmd13 result are out of sync then schedule
another detect work 200ms later.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/core/core.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index b8c3d41..ad927ad 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -32,6 +32,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/sd.h>
+#include <linux/mmc/slot-gpio.h>
 
 #include "core.h"
 #include "bus.h"
@@ -2282,6 +2283,7 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
 int _mmc_detect_card_removed(struct mmc_host *host)
 {
 	int ret;
+	int detected;
 
 	if ((host->caps & MMC_CAP_NONREMOVABLE) || !host->bus_ops->alive)
 		return 0;
@@ -2290,6 +2292,23 @@ int _mmc_detect_card_removed(struct mmc_host *host)
 		return 1;
 
 	ret = host->bus_ops->alive(host);
+	/*
+	 * Card detect status and alive check may out of sync because of
+	 * the async between card detect switch and card/slot pad contaction
+	 * in hardware.(refer to "SD Card Mechanical Addendum, Appendix C:
+	 * Card Detection Switch") So reschedule a detect work 200ms later
+	 * for this case.
+	 */
+	if (host->ops->get_cd &&
+		!(host->caps & MMC_CAP_NEEDS_POLL)) {
+		detected = host->ops->get_cd(host);
+		if (!IS_ERR_VALUE(detected) && (!ret ^ !!detected)) {
+			mmc_detect_change(host, msecs_to_jiffies(200));
+			pr_warn("%s: card insert/remove too slowly\n",
+					mmc_hostname(host));
+		}
+	}
+
 	if (ret) {
 		mmc_card_set_removed(host->card);
 		pr_debug("%s: card remove detected\n", mmc_hostname(host));
-- 
1.7.9.5

