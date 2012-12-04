From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 2/3] mmc: use regulator_can_change_voltage() instead of
 regulator_count_voltages() hacks
Date: Tue, 04 Dec 2012 15:01:02 +0100
Message-ID: <1354629663-29091-3-git-send-email-m.szyprowski@samsung.com>
References: <1354629663-29091-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:13802 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073Ab2LDOBh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Dec 2012 09:01:37 -0500
In-reply-to: <1354629663-29091-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Chris Ball <cjb@laptop.org>, Kevin Liu <keyuan.liu@gmail.com>

mmc_regulator_set_ocr() depends on the ability of regulator to change the
voltage value. When regulator cannot change its voltage output, some code is
skipped to avoid reporting false errors on some boards, which use MMC hosts
with fixed regulators (example: Samsung Goni and UniversalC210 boards).

This patch replaces a hacky workaround based on regulator_count_voltages()
value with the correct call to recently introduced
regulator_can_change_voltage() function in regulators core.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/mmc/core/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index aaed768..f5a0493 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1137,7 +1137,7 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 		 */
 		voltage = regulator_get_voltage(supply);
 
-		if (regulator_count_voltages(supply) == 1)
+		if (!regulator_can_change_voltage(supply))
 			min_uV = max_uV = voltage;
 
 		if (voltage < 0)
-- 
1.7.9.5

