From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 2/6] regulator: pbias: Select voltage table based on max-voltage
Date: Thu, 31 Aug 2017 15:48:45 +0530
Message-ID: <20170831101849.9489-3-kishon@ti.com>
References: <20170831101849.9489-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170831101849.9489-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

From: Ravikumar Kattekola <rk@ti.com>

Reference manuals of OMAP5x and DRA7x have been updated to reflect
the PBIAS regulator max-voltage as 3.3V instead of 3.0V, while OMAP3x
and OMAP4x are still quoting 3.0V. So, as of now, the pbias driver
needs to support both 3.0V and 3.3V IO voltage based on the max-voltage
supported by the PBIAS regulator.

Document reference:
SWPU249AF - OMAP543x Technical reference manual - August 2016
SPRUI30C – DRA75x, DRA74x Technical reference manual November 2016

Tested on:
DRA75x PG 2.0 REV H EVM

Signed-off-by: Ravikumar Kattekola <rk@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/regulator/pbias-regulator.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/pbias-regulator.c b/drivers/regulator/pbias-regulator.c
index 0cb76ba29e84..8f782d22fdbe 100644
--- a/drivers/regulator/pbias-regulator.c
+++ b/drivers/regulator/pbias-regulator.c
@@ -34,6 +34,8 @@ struct pbias_reg_info {
 	u32 vmode;
 	unsigned int enable_time;
 	char *name;
+	const unsigned int *pbias_volt_table;
+	int n_voltages;
 };
 
 struct pbias_regulator_data {
@@ -49,11 +51,16 @@ struct pbias_of_data {
 	unsigned int offset;
 };
 
-static const unsigned int pbias_volt_table[] = {
+static const unsigned int pbias_volt_table_3_0V[] = {
 	1800000,
 	3000000
 };
 
+static const unsigned int pbias_volt_table_3_3V[] = {
+	1800000,
+	3300000
+};
+
 static const struct regulator_ops pbias_regulator_voltage_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
@@ -69,6 +76,8 @@ static const struct pbias_reg_info pbias_mmc_omap2430 = {
 	.vmode = BIT(0),
 	.disable_val = 0,
 	.enable_time = 100,
+	.pbias_volt_table = pbias_volt_table_3_0V,
+	.n_voltages = 2,
 	.name = "pbias_mmc_omap2430"
 };
 
@@ -77,6 +86,8 @@ static const struct pbias_reg_info pbias_sim_omap3 = {
 	.enable_mask = BIT(9),
 	.vmode = BIT(8),
 	.enable_time = 100,
+	.pbias_volt_table = pbias_volt_table_3_0V,
+	.n_voltages = 2,
 	.name = "pbias_sim_omap3"
 };
 
@@ -86,6 +97,8 @@ static const struct pbias_reg_info pbias_mmc_omap4 = {
 	.disable_val = BIT(25),
 	.vmode = BIT(21),
 	.enable_time = 100,
+	.pbias_volt_table = pbias_volt_table_3_0V,
+	.n_voltages = 2,
 	.name = "pbias_mmc_omap4"
 };
 
@@ -95,6 +108,8 @@ static const struct pbias_reg_info pbias_mmc_omap5 = {
 	.disable_val = BIT(25),
 	.vmode = BIT(21),
 	.enable_time = 100,
+	.pbias_volt_table = pbias_volt_table_3_3V,
+	.n_voltages = 2,
 	.name = "pbias_mmc_omap5"
 };
 
@@ -199,8 +214,8 @@ static int pbias_regulator_probe(struct platform_device *pdev)
 		drvdata[data_idx].desc.owner = THIS_MODULE;
 		drvdata[data_idx].desc.type = REGULATOR_VOLTAGE;
 		drvdata[data_idx].desc.ops = &pbias_regulator_voltage_ops;
-		drvdata[data_idx].desc.volt_table = pbias_volt_table;
-		drvdata[data_idx].desc.n_voltages = 2;
+		drvdata[data_idx].desc.volt_table = info->pbias_volt_table;
+		drvdata[data_idx].desc.n_voltages = info->n_voltages;
 		drvdata[data_idx].desc.enable_time = info->enable_time;
 		drvdata[data_idx].desc.vsel_reg = offset;
 		drvdata[data_idx].desc.vsel_mask = info->vmode;
-- 
2.11.0
