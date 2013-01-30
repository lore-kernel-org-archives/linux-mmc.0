From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 1/7] mmc: sdhci: avoid redundant loops in sdhci_irq for card int
Date: Wed, 30 Jan 2013 16:59:42 +0800
Message-ID: <1359536388-7896-2-git-send-email-kliu5@marvell.com>
References: <1359536388-7896-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:60204 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752422Ab3A3I6z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Jan 2013 03:58:55 -0500
In-Reply-To: <1359536388-7896-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Nicolas Pitre <nico@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>, Jialing Fu <jlfu@marvell.com>

After cleared the handled irq status, sdhci_irq will check the interrupt
status again at end. And it will loop back to handle the irq if any new
interrupts happened.
But card int will keep active all the time since its status is readonly
and can't be cleared at that time. So in case card int happend, the
function will be looped with max_loops (16 times).

Signed-off-by: Kevin Liu <kliu5@marvell.com>
Signed-off-by: Jialing Fu <jlfu@marvell.com>
---
 drivers/mmc/host/sdhci.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3bb9b88..664650b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2431,6 +2431,8 @@ again:
 	result = IRQ_HANDLED;
 
 	intmask = sdhci_readl(host, SDHCI_INT_STATUS);
+	if (cardint)
+		intmask &= ~SDHCI_INT_CARD_INT;
 	if (intmask && --max_loops)
 		goto again;
 out:
-- 
1.7.9.5

