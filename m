From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 1/3] regulator: fix voltage check in
 regulator_is_supported_voltage()
Date: Tue, 13 Nov 2012 09:48:51 +0100
Message-ID: <1352796533-12350-2-git-send-email-m.szyprowski@samsung.com>
References: <1352796533-12350-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1352796533-12350-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

regulator_is_supported_voltage() should return true only if the voltage
of fixed/constant regulator is between min_uV and max_uV.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/regulator/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1a35251..042c1ff 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1974,7 +1974,7 @@ int regulator_is_supported_voltage(struct regulator *regulator,
 	if (!(rdev->constraints->valid_ops_mask & REGULATOR_CHANGE_VOLTAGE)) {
 		ret = regulator_get_voltage(regulator);
 		if (ret >= 0)
-			return (min_uV >= ret && ret <= max_uV);
+			return (min_uV <= ret && ret <= max_uV);
 		else
 			return ret;
 	}
-- 
1.7.9.5
