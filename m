From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2] regulator: treat regulators with constant volatage as fixed
Date: Tue, 13 Nov 2012 10:35:34 +0100
Message-ID: <1352799334-13898-1-git-send-email-m.szyprowski@samsung.com>
References: <20121113090007.GS18224@opensource.wolfsonmicro.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:62538 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754470Ab2KMJfv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Nov 2012 04:35:51 -0500
In-reply-to: <20121113090007.GS18224@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Chris Ball <cjb@laptop.org>

Some drivers has additional logic for fixed regulators. Let regulator core
to treat regulators which cannot change their voltage due to applied
constraints as fixed.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/regulator/core.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 042c1ff..78b34b7 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1872,7 +1872,11 @@ int regulator_count_voltages(struct regulator *regulator)
 {
 	struct regulator_dev	*rdev = regulator->rdev;
 
-	return rdev->desc->n_voltages ? : -EINVAL;
+	if (rdev->constraints->valid_ops_mask & REGULATOR_CHANGE_VOLTAGE)
+		return rdev->desc->n_voltages ? rdev->desc->n_voltages :
+		       -EINVAL;
+	else
+		return 1;
 }
 EXPORT_SYMBOL_GPL(regulator_count_voltages);
 
-- 
1.7.9.5

