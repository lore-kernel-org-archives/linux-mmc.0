From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] regulator: s2mps11: Fix invalid minimal selector for buck9
 supplying SD card
Date: Mon, 28 Mar 2016 09:54:49 +0900
Message-ID: <1459126489-18311-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Sangbeom Kim <sbkim73@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The buck9 regulator of S2MPS11 PMIC lacked minimal selector for linear
mapping. The mapping starts from 0x40 (3 V).

This buck9 provides power to other regulators, including LDO13 and LDO19
which supply the MMC2 (SD card).

Bootloader initializes the regulator with value of 0xff (5 V) which is
outside of supported voltage range. When (during boot) constraints to
buck9 were applied, the driver wrote value counting from 0x00, not 0x40.
Effectively driver set lower voltage than required leading to SD card
detection errors on Odroid XU3/XU4:
	mmc1: card never left busy state
	mmc1: error -110 whilst initialising SD card

Fixes: cb74685ecb39 ("regulator: s2mps11: Add samsung s2mps11 regulator driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The issue can be reproduced on next-20160324 with
bae4fdc88d7f7dda1 (regulator: core: Ensure we are at least in bounds
for our constraints).
---
 drivers/regulator/s2mps11.c         | 19 ++++++++++++++++++-
 include/linux/mfd/samsung/s2mps11.h |  9 +++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/s2mps11.c b/drivers/regulator/s2mps11.c
index d24e2c783dc5..caeefc38ac47 100644
--- a/drivers/regulator/s2mps11.c
+++ b/drivers/regulator/s2mps11.c
@@ -324,6 +324,23 @@ static struct regulator_ops s2mps11_buck_ops = {
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
+	.linear_min_sel	= S2MPS11_BUCK9_MIN_VSEL,		\
+	.n_voltages	= S2MPS11_BUCK9_N_VOLTAGES,		\
+	.ramp_delay	= S2MPS11_RAMP_DELAY,			\
+	.vsel_reg	= S2MPS11_REG_B9CTRL2,			\
+	.vsel_mask	= S2MPS11_BUCK_VSEL_MASK,		\
+	.enable_reg	= S2MPS11_REG_B9CTRL1,			\
+	.enable_mask	= S2MPS11_ENABLE_MASK			\
+}
+
 static const struct regulator_desc s2mps11_regulators[] = {
 	regulator_desc_s2mps11_ldo(1, STEP_25_MV),
 	regulator_desc_s2mps11_ldo(2, STEP_50_MV),
@@ -371,7 +388,7 @@ static const struct regulator_desc s2mps11_regulators[] = {
 	regulator_desc_s2mps11_buck6_10(6, MIN_600_MV, STEP_6_25_MV),
 	regulator_desc_s2mps11_buck6_10(7, MIN_600_MV, STEP_6_25_MV),
 	regulator_desc_s2mps11_buck6_10(8, MIN_600_MV, STEP_6_25_MV),
-	regulator_desc_s2mps11_buck6_10(9, MIN_3000_MV, STEP_25_MV),
+	regulator_desc_s2mps11_buck9,
 	regulator_desc_s2mps11_buck6_10(10, MIN_750_MV, STEP_12_5_MV),
 };
 
diff --git a/include/linux/mfd/samsung/s2mps11.h b/include/linux/mfd/samsung/s2mps11.h
index b288965e8101..3937a932bfe0 100644
--- a/include/linux/mfd/samsung/s2mps11.h
+++ b/include/linux/mfd/samsung/s2mps11.h
@@ -173,10 +173,19 @@ enum s2mps11_regulators {
 
 #define S2MPS11_LDO_VSEL_MASK	0x3F
 #define S2MPS11_BUCK_VSEL_MASK	0xFF
+#define S2MPS11_BUCK9_MIN_VSEL	0x40
 #define S2MPS11_ENABLE_MASK	(0x03 << S2MPS11_ENABLE_SHIFT)
 #define S2MPS11_ENABLE_SHIFT	0x06
 #define S2MPS11_LDO_N_VOLTAGES	(S2MPS11_LDO_VSEL_MASK + 1)
 #define S2MPS11_BUCK_N_VOLTAGES (S2MPS11_BUCK_VSEL_MASK + 1)
+/*
+ * Buck9 supports only 32 voltages (values from 0x40 to 0x5F) but bootloader
+ * initializes the register with value of 0xff so when probing this would
+ * cause a failure (Odroid XU3):
+ *	vdd_2.8v_ldo: failed to get the current voltage(-22)
+ * Instead pretend we support up to 0xff (5 V).
+ */
+#define S2MPS11_BUCK9_N_VOLTAGES	192
 #define S2MPS11_RAMP_DELAY	25000		/* uV/us */
 
 #define S2MPS11_CTRL1_PWRHOLD_MASK	BIT(4)
-- 
2.5.0
