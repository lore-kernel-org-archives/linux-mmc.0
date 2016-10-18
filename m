From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH] mmc: core: Check regulator pointer
Date: Tue, 18 Oct 2016 10:43:43 +0200
Message-ID: <20161018084343.680-1-maxime.ripard@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from up.free-electrons.com ([163.172.77.33]:53035 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752327AbcJRInv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2016 04:43:51 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>

mmc_regulator_get_supply might silently fail if the regulators are not
found, which is the right thing to do since both these regulators are
optional.

However, the drivers then have no way to know whether or not they should
proceed and call mmc_regulator_set_ocr. And since this function doesn't
check for the validity of the regulator pointer, it leads to a null pointer
dereference. Add such a check to make sure everything works fine.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/mmc/core/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 2553d903a82b..1d3ea5e1aa37 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1474,6 +1474,12 @@ int mmc_regulator_set_ocr(struct mmc_host *mmc,
 	int			result = 0;
 	int			min_uV, max_uV;
 
+	if (!supply)
+		return -EINVAL;
+
+	if (IS_ERR(supply))
+		return PTR_ERR(supply);
+
 	if (vdd_bit) {
 		mmc_ocrbitnum_to_vdd(vdd_bit, &min_uV, &max_uV);
 
-- 
2.9.3

