From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH v6 1/2] mmc: core: enhance card removal judgement for slow removal
Date: Thu, 28 Feb 2013 10:38:49 +0800
Message-ID: <1362019130-11214-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:56214 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750889Ab3B1Cjc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Feb 2013 21:39:32 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>

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
_mmc_detect_card_removed if cmd13 check succeed and host->ops->get_cd
provided. If get_cd detect no card present then schedule another detect
work 200ms later.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/core/core.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index b8c3d41..a06fa68 100644
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
@@ -2290,6 +2292,19 @@ int _mmc_detect_card_removed(struct mmc_host *host)
 		return 1;
 
 	ret = host->bus_ops->alive(host);
+	/*
+	 * Card detect status and alive check may out of sync if card is
+	 * removed slowly when card detect switch changed while card/slot
+	 * pads still contacted in hardware.(refer to "SD Card Mechanical
+	 * Addendum, Appendix C: Card Detection Switch") So reschedule a
+	 * detect work 200ms later for this case.
+	 */
+	if (!ret && host->ops->get_cd && !host->ops->get_cd(host)) {
+		mmc_detect_change(host, msecs_to_jiffies(200));
+		pr_debug("%s: card remove too slowly\n",
+				mmc_hostname(host));
+	}
+
 	if (ret) {
 		mmc_card_set_removed(host->card);
 		pr_debug("%s: card remove detected\n", mmc_hostname(host));
-- 
1.7.9.5

