From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 1/6] regulator: pbias: program pbias register offset in
 pbias driver
Date: Thu, 3 Sep 2015 12:20:37 +0530
Message-ID: <1441263042-12942-2-git-send-email-kishon@ti.com>
References: <1441263042-12942-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1441263042-12942-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, broonie@kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mark.rutland@arm.com, ulf.hansson@linaro.org, linux@arm.linux.org.uk, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, nsekhar@ti.com, lgirdwood@gmail.com, kishon@ti.com, robh+dt@kernel.org, bcousson@baylibre.com, galak@codeaurora.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Add separate compatible strings for every platform and populate the
pbias register offset in the driver data.
This helps avoid depending on the dt for pbias register offset.

Also update the dt binding documentation for the new compatible
strings.

Suggested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 .../bindings/regulator/pbias-regulator.txt         |    7 ++-
 drivers/regulator/pbias-regulator.c                |   56 +++++++++++++++++---
 2 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/pbias-regulator.txt b/Documentation/devicetree/bindings/regulator/pbias-regulator.txt
index 32aa26f..acbcb45 100644
--- a/Documentation/devicetree/bindings/regulator/pbias-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/pbias-regulator.txt
@@ -2,7 +2,12 @@ PBIAS internal regulator for SD card dual voltage i/o pads on OMAP SoCs.
 
 Required properties:
 - compatible:
-  - "ti,pbias-omap" for OMAP2, OMAP3, OMAP4, OMAP5, DRA7.
+  - should be "ti,pbias-dra7" for DRA7
+  - should be "ti,pbias-omap2" for OMAP2
+  - should be "ti,pbias-omap3" for OMAP3
+  - should be "ti,pbias-omap4" for OMAP4
+  - should be "ti,pbias-omap5" for OMAP5
+  - "ti,pbias-omap" is deprecated
 - reg: pbias register offset from syscon base and size of pbias register.
 - syscon : phandle of the system control module
 - regulator-name : should be
diff --git a/drivers/regulator/pbias-regulator.c b/drivers/regulator/pbias-regulator.c
index bd2b75c..c21cedb 100644
--- a/drivers/regulator/pbias-regulator.c
+++ b/drivers/regulator/pbias-regulator.c
@@ -44,6 +44,10 @@ struct pbias_regulator_data {
 	int voltage;
 };
 
+struct pbias_of_data {
+	unsigned int offset;
+};
+
 static const unsigned int pbias_volt_table[] = {
 	1800000,
 	3000000
@@ -98,8 +102,35 @@ static struct of_regulator_match pbias_matches[] = {
 };
 #define PBIAS_NUM_REGS	ARRAY_SIZE(pbias_matches)
 
+/* Offset from SCM general area (and syscon) base */
+
+static const struct pbias_of_data pbias_of_data_omap2 = {
+	.offset = 0x230,
+};
+
+static const struct pbias_of_data pbias_of_data_omap3 = {
+	.offset = 0x2b0,
+};
+
+static const struct pbias_of_data pbias_of_data_omap4 = {
+	.offset = 0x60,
+};
+
+static const struct pbias_of_data pbias_of_data_omap5 = {
+	.offset = 0x60,
+};
+
+static const struct pbias_of_data pbias_of_data_dra7 = {
+	.offset = 0xe00,
+};
+
 static const struct of_device_id pbias_of_match[] = {
 	{ .compatible = "ti,pbias-omap", },
+	{ .compatible = "ti,pbias-omap2", .data = &pbias_of_data_omap2, },
+	{ .compatible = "ti,pbias-omap3", .data = &pbias_of_data_omap3, },
+	{ .compatible = "ti,pbias-omap4", .data = &pbias_of_data_omap4, },
+	{ .compatible = "ti,pbias-omap5", .data = &pbias_of_data_omap5, },
+	{ .compatible = "ti,pbias-dra7", .data = &pbias_of_data_dra7, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, pbias_of_match);
@@ -114,6 +145,9 @@ static int pbias_regulator_probe(struct platform_device *pdev)
 	const struct pbias_reg_info *info;
 	int ret = 0;
 	int count, idx, data_idx = 0;
+	const struct of_device_id *match;
+	const struct pbias_of_data *data;
+	unsigned int offset;
 
 	count = of_regulator_match(&pdev->dev, np, pbias_matches,
 						PBIAS_NUM_REGS);
@@ -129,6 +163,20 @@ static int pbias_regulator_probe(struct platform_device *pdev)
 	if (IS_ERR(syscon))
 		return PTR_ERR(syscon);
 
+	match = of_match_device(of_match_ptr(pbias_of_match), &pdev->dev);
+	if (match && match->data) {
+		data = match->data;
+		offset = data->offset;
+	} else {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!res)
+			return -EINVAL;
+
+		offset = res->start;
+		dev_WARN(&pdev->dev,
+			 "using legacy dt data for pbias offset\n");
+	}
+
 	cfg.regmap = syscon;
 	cfg.dev = &pdev->dev;
 
@@ -141,10 +189,6 @@ static int pbias_regulator_probe(struct platform_device *pdev)
 		if (!info)
 			return -ENODEV;
 
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		if (!res)
-			return -EINVAL;
-
 		drvdata[data_idx].syscon = syscon;
 		drvdata[data_idx].info = info;
 		drvdata[data_idx].desc.name = info->name;
@@ -154,9 +198,9 @@ static int pbias_regulator_probe(struct platform_device *pdev)
 		drvdata[data_idx].desc.volt_table = pbias_volt_table;
 		drvdata[data_idx].desc.n_voltages = 2;
 		drvdata[data_idx].desc.enable_time = info->enable_time;
-		drvdata[data_idx].desc.vsel_reg = res->start;
+		drvdata[data_idx].desc.vsel_reg = offset;
 		drvdata[data_idx].desc.vsel_mask = info->vmode;
-		drvdata[data_idx].desc.enable_reg = res->start;
+		drvdata[data_idx].desc.enable_reg = offset;
 		drvdata[data_idx].desc.enable_mask = info->enable_mask;
 		drvdata[data_idx].desc.enable_val = info->enable;
 
-- 
1.7.9.5
