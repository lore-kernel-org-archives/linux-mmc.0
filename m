From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3] regulator: treat regulators with constant volatage as fixed
Date: Tue, 13 Nov 2012 10:49:37 +0100
Message-ID: <1352800177-16139-1-git-send-email-m.szyprowski@samsung.com>
References: <20121113094255.GW18224@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20121113094255.GW18224@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Some drivers has additional logic for fixed regulators. Let regulator core
to treat regulators which cannot change their voltage due to applied
constraints as fixed.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/regulator/core.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 042c1ff..d07c240 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1872,7 +1872,14 @@ int regulator_count_voltages(struct regulator *regulator)
 {
 	struct regulator_dev	*rdev = regulator->rdev;
 
-	return rdev->desc->n_voltages ? : -EINVAL;
+	if (rdev->constraints->valid_ops_mask & REGULATOR_CHANGE_VOLTAGE) {
+		if (rdev->desc->n_voltages)
+			return rdev->desc->n_voltages;
+		else
+			return -EINVAL;
+	} else {
+		return 1;
+	}
 }
 EXPORT_SYMBOL_GPL(regulator_count_voltages);
 
-- 
1.7.9.5
