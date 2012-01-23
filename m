From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] mmc: add workaround for fixed regulators
Date: Mon, 23 Jan 2012 10:53:17 +0100
Message-ID: <1327312397-10176-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38831 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799Ab2AWJxf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Jan 2012 04:53:35 -0500
Received: from euspt1 (mailout2.w1.samsung.com [210.118.77.12])
 by mailout2.w1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0LY800ACOWTAUL@mailout2.w1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 23 Jan 2012 09:53:34 +0000 (GMT)
Received: from linux.samsung.com ([106.116.38.10])
 by spt1.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0LY800LBGWT9EB@spt1.w1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 23 Jan 2012 09:53:34 +0000 (GMT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>

Voltage change errors should not be fatal to mmc subsystem. Some
regulators don't support changing the supplied voltage values, while
they can still be used for enabling and disabling the supply. This fixes
the regresion that appeared in sdhci driver after commit ceb6143b -
erlier it worked fine with fixed gpio-based regulator.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/core/core.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index f545a3e..8726ae4 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1128,6 +1128,12 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 		else
 			result = 0;
 
+		/* Some regulators don't support voltage changes, so
+		 * assume that board designer used correct values
+		 */ 
+		if (result == -EINVAL)
+			result = 0;
+
 		if (result == 0 && !mmc->regulator_enabled) {
 			result = regulator_enable(supply);
 			if (!result)
-- 
1.7.1.569.g6f426

