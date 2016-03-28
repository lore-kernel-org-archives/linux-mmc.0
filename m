From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v2] regulator: s2mps11: Fix invalid selector mask and voltages
 for buck9
Date: Mon, 28 Mar 2016 13:09:56 +0900
Message-ID: <1459138196-13672-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sangbeom Kim <sbkim73@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The buck9 regulator of S2MPS11 PMIC had incorrect vsel_mask (0xff
instead of 0x1f) thus reading entire register as buck9's voltage. This
effectively caused regulator core to interpret values as higher voltages
than they were and then to set real voltage much lower than intended.

The buck9 provides power to other regulators, including LDO13
and LDO19 which supply the MMC2 (SD card). On Odroid XU3/XU4 the lower
voltage caused SD card detection errors on Odroid XU3/XU4:
	mmc1: card never left busy state
	mmc1: error -110 whilst initialising SD card

During driver probe the regulator core was checking whether initial
voltage matches the constraints. With incorrect vsel_mask of 0xff and
default value of 0x50, the core interpreted this as 5 V which is outside
of constraints (3-3.775 V). Then the regulator core was adjusting the
voltage to match the constraints. With incorrect vsel_mask this new
voltage mapped to a vere low voltage in the driver.

Fixes: cb74685ecb39 ("regulator: s2mps11: Add samsung s2mps11 regulator driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes since v1:
1. The driver did not lack minimal linear selector but the selector mask
   was wrong. The effect was exactly the same - writing values
   corresponding to a lower voltage in reality.
   Instead of setting '.linear_min_sel', set the '.vsel_mask' to a
   proper value.
2. Rewrite title/commit.
3. Minor changes after Javier's review.
4. Add Javier's review/tested by.

The issue can be reproduced on next-20160324 with
bae4fdc88d7f7dda1 (regulator: core: Ensure we are at least in bounds
for our constraints).
---
 drivers/regulator/s2mps11.c         | 28 ++++++++++++++++++++++------
 include/linux/mfd/samsung/s2mps11.h |  2 ++
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index d24e2c783dc5..6dfa3502e1f1 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -308,7 +308,7 @@ static struct regulator_ops s2mps11_buck_ops = {
 	.enable_mask	= S2MPS11_ENABLE_MASK			\
 }
 
-#define regulator_desc_s2mps11_buck6_10(num, min, step) {	\
+#define regulator_desc_s2mps11_buck67810(num, min, step) {	\
 	.name		= "BUCK"#num,				\
 	.id		= S2MPS11_BUCK##num,			\
 	.ops		= &s2mps11_buck_ops,			\
@@ -324,6 +324,22 @@ static struct regulator_ops s2mps11_buck_ops = {
 	.enable_mask	= S2MPS11_ENABLE_MASK			\
 }
 
+#define regulator_desc_s2mps11_buck9 {				\
+	.name		= "BUCK9",				\
+	.id		= S2MPS11_BUCK9,			\
+	.ops		= &s2mps11_buck_ops,			\
+	.type		= REGULATOR_VOLTAGE,			\
+	.owner		= THIS_MODULE,				\
+	.min_uV		= MIN_3000_MV,				\
+	.uV_step	= STEP_25_MV,				\
+	.n_voltages	= S2MPS11_BUCK9_N_VOLTAGES,		\
+	.ramp_delay	= S2MPS11_RAMP_DELAY,			\
+	.vsel_reg	= S2MPS11_REG_B9CTRL2,			\
+	.vsel_mask	= S2MPS11_BUCK9_VSEL_MASK,		\
+	.enable_reg	= S2MPS11_REG_B9CTRL1,			\
+	.enable_mask	= S2MPS11_ENABLE_MASK			\
+}
+
 static const struct regulator_desc s2mps11_regulators[] = {
 	regulator_desc_s2mps11_ldo(1, STEP_25_MV),
 	regulator_desc_s2mps11_ldo(2, STEP_50_MV),
@@ -368,11 +384,11 @@ static const struct regulator_desc s2mps11_regulators[] = {
 	regulator_desc_s2mps11_buck1_4(3),
 	regulator_desc_s2mps11_buck1_4(4),
 	regulator_desc_s2mps11_buck5,
-	regulator_desc_s2mps11_buck6_10(6, MIN_600_MV, STEP_6_25_MV),
-	regulator_desc_s2mps11_buck6_10(7, MIN_600_MV, STEP_6_25_MV),
-	regulator_desc_s2mps11_buck6_10(8, MIN_600_MV, STEP_6_25_MV),
-	regulator_desc_s2mps11_buck6_10(9, MIN_3000_MV, STEP_25_MV),
-	regulator_desc_s2mps11_buck6_10(10, MIN_750_MV, STEP_12_5_MV),
+	regulator_desc_s2mps11_buck67810(6, MIN_600_MV, STEP_6_25_MV),
+	regulator_desc_s2mps11_buck67810(7, MIN_600_MV, STEP_6_25_MV),
+	regulator_desc_s2mps11_buck67810(8, MIN_600_MV, STEP_6_25_MV),
+	regulator_desc_s2mps11_buck9,
+	regulator_desc_s2mps11_buck67810(10, MIN_750_MV, STEP_12_5_MV),
 };
 
 static struct regulator_ops s2mps14_reg_ops;
diff --git a/include/linux/mfd/samsung/s2mps11.h b/include/linux/mfd/samsung/s2mps11.h
index b288965e8101..2c14eeca46f0 100644
--- a/include/linux/mfd/samsung/s2mps11.h
+++ b/include/linux/mfd/samsung/s2mps11.h
@@ -173,10 +173,12 @@ enum s2mps11_regulators {
 
 #define S2MPS11_LDO_VSEL_MASK	0x3F
 #define S2MPS11_BUCK_VSEL_MASK	0xFF
+#define S2MPS11_BUCK9_VSEL_MASK	0x1F
 #define S2MPS11_ENABLE_MASK	(0x03 << S2MPS11_ENABLE_SHIFT)
 #define S2MPS11_ENABLE_SHIFT	0x06
 #define S2MPS11_LDO_N_VOLTAGES	(S2MPS11_LDO_VSEL_MASK + 1)
 #define S2MPS11_BUCK_N_VOLTAGES (S2MPS11_BUCK_VSEL_MASK + 1)
+#define S2MPS11_BUCK9_N_VOLTAGES (S2MPS11_BUCK9_VSEL_MASK + 1)
 #define S2MPS11_RAMP_DELAY	25000		/* uV/us */
 
 #define S2MPS11_CTRL1_PWRHOLD_MASK	BIT(4)
-- 
2.5.0
