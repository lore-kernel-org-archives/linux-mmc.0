From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v5 3/7] regulator: add pbias regulator support
Date: Tue, 10 Dec 2013 20:04:58 +0530
Message-ID: <1386686098-7779-1-git-send-email-balajitk@ti.com>
References: <20131210104005.GB29268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46128 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753807Ab3LJOfP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Dec 2013 09:35:15 -0500
In-Reply-To: <20131210104005.GB29268@sirena.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, broonie@kernel.org
Cc: tony@atomide.com, Balaji T K <balajitk@ti.com>

pbias register controls internal power supply to sd card i/o pads
in most OMAPs (OMAP2-5, DRA7).
Control bits for selecting voltage level and
enabling/disabling are in the same PBIAS register.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 Documentation/devicetree/bindings/regulator/pbias-regulator.txt |   21 
 drivers/regulator/Kconfig                                       |    9 
 drivers/regulator/Makefile                                      |    1 
 drivers/regulator/pbias-regulator.c                             |  236 ++++++++++
 4 files changed, 267 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/pbias-regulator.txt
 create mode 100644 drivers/regulator/pbias-regulator.c

Index: lo/Documentation/devicetree/bindings/regulator/pbias-regulator.txt
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ lo/Documentation/devicetree/bindings/regulator/pbias-regulator.txt	2013-12-10 16:58:28.907927745 +0530
@@ -0,0 +1,21 @@
+PBIAS internal regulator for SD card i/o pads on OMAP SoCs.
+
+Required properties:
+- compatible:
+  - "regulator-pbias-omap2" for OMAP2
+  - "regulator-pbias-omap3" for OMAP3
+  - "regulator-pbias-omap4" for OMAP4
+  - "regulator-pbias-omap5" for OMAP5, DRA7
+- pbias-reg-offset: PBIAS control register offset from syscon base address
+
+Optional properties:
+- Any optional property defined in bindings/regulator/regulator.txt
+
+Example:
+
+		pbias_regulator: pbias_regulator {
+			pbias-reg-offset = <0>;
+			regulator-name = "pbias_regulator";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3000000>;
+	};
Index: lo/drivers/regulator/Kconfig
===================================================================
--- lo.orig/drivers/regulator/Kconfig	2013-12-10 16:58:16.411852457 +0530
+++ lo/drivers/regulator/Kconfig	2013-12-10 17:08:29.291513120 +0530
@@ -369,6 +369,15 @@ config REGULATOR_PALMAS
 	  on the muxing. This is handled automatically in the driver by
 	  reading the mux info from OTP.
 
+config REGULATOR_PBIAS
+	tristate "PBIAS OMAP regulator driver"
+	depends on (ARCH_OMAP || COMPILE_TEST) && MFD_SYSCON
+	help
+	 Say y here to support pbias regulator for mmc1:SD card i/o
+	 on OMAP SoCs.
+	 This driver provides support for OMAP pbias modelled
+	 regulators.
+
 config REGULATOR_PCAP
 	tristate "Motorola PCAP2 regulator driver"
 	depends on EZX_PCAP
Index: lo/drivers/regulator/Makefile
===================================================================
--- lo.orig/drivers/regulator/Makefile	2013-12-10 16:58:16.411852457 +0530
+++ lo/drivers/regulator/Makefile	2013-12-10 16:58:28.915927793 +0530
@@ -52,6 +52,7 @@ obj-$(CONFIG_REGULATOR_MC13XXX_CORE) +=
 obj-$(CONFIG_REGULATOR_PALMAS) += palmas-regulator.o
 obj-$(CONFIG_REGULATOR_PFUZE100) += pfuze100-regulator.o
 obj-$(CONFIG_REGULATOR_TPS51632) += tps51632-regulator.o
+obj-$(CONFIG_REGULATOR_PBIAS) += pbias-regulator.o
 obj-$(CONFIG_REGULATOR_PCAP) += pcap-regulator.o
 obj-$(CONFIG_REGULATOR_PCF50633) += pcf50633-regulator.o
 obj-$(CONFIG_REGULATOR_RC5T583)  += rc5t583-regulator.o
Index: lo/drivers/regulator/pbias-regulator.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ lo/drivers/regulator/pbias-regulator.c	2013-12-10 17:06:51.046930033 +0530
@@ -0,0 +1,236 @@
+/*
+ * pbias-regulator.c
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Author: Balaji T K <balajitk@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <linux/module.h>
+#include <linux/mfd/syscon.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+struct pbias_reg_info {
+	u32 enable;
+	u32 enable_mask;
+	u32 vmode;
+	char *name;
+};
+
+struct pbias_regulator_data {
+	struct regulator_desc desc;
+	void __iomem *pbias_addr;
+	unsigned int pbias_reg;
+	struct regulator_dev *dev;
+	struct regmap *syscon;
+	const struct pbias_reg_info *info;
+	int voltage;
+};
+
+static int pbias_regulator_set_voltage(struct regulator_dev *dev,
+			int min_uV, int max_uV, unsigned *selector)
+{
+	struct pbias_regulator_data *data = rdev_get_drvdata(dev);
+	const struct pbias_reg_info *info = data->info;
+	int ret, vmode;
+
+	if (min_uV <= 1800000)
+		vmode = 0;
+	else if (min_uV > 1800000)
+		vmode = info->vmode;
+
+	ret = regmap_update_bits(data->syscon, data->pbias_reg,
+						info->vmode, vmode);
+
+	return ret;
+}
+
+static int pbias_regulator_get_voltage(struct regulator_dev *rdev)
+{
+	struct pbias_regulator_data *data = rdev_get_drvdata(rdev);
+	const struct pbias_reg_info *info = data->info;
+	int value, voltage;
+
+	regmap_read(data->syscon, data->pbias_reg, &value);
+	value &= info->vmode;
+
+	voltage = value ? 1800000 : 3000000;
+
+	return voltage;
+}
+
+static int pbias_regulator_enable(struct regulator_dev *rdev)
+{
+	struct pbias_regulator_data *data = rdev_get_drvdata(rdev);
+	const struct pbias_reg_info *info = data->info;
+	int ret;
+
+	ret = regmap_update_bits(data->syscon, data->pbias_reg,
+					info->enable_mask, info->enable);
+
+	return ret;
+}
+
+static int pbias_regulator_disable(struct regulator_dev *rdev)
+{
+	struct pbias_regulator_data *data = rdev_get_drvdata(rdev);
+	const struct pbias_reg_info *info = data->info;
+	int ret;
+
+	ret = regmap_update_bits(data->syscon, data->pbias_reg,
+						info->enable_mask, 0);
+	return ret;
+}
+
+static int pbias_regulator_is_enable(struct regulator_dev *rdev)
+{
+	struct pbias_regulator_data *data = rdev_get_drvdata(rdev);
+	const struct pbias_reg_info *info = data->info;
+	int value;
+
+	regmap_read(data->syscon, data->pbias_reg, &value);
+
+	return (value & info->enable_mask) == info->enable_mask;
+}
+
+static struct regulator_ops pbias_regulator_voltage_ops = {
+	.set_voltage	= pbias_regulator_set_voltage,
+	.get_voltage	= pbias_regulator_get_voltage,
+	.enable		= pbias_regulator_enable,
+	.disable	= pbias_regulator_disable,
+	.is_enabled	= pbias_regulator_is_enable,
+};
+
+static const struct pbias_reg_info pbias_omap3 = {
+	.enable = BIT(1),
+	.enable_mask = BIT(1),
+	.vmode = BIT(0),
+	.name = "pbias_omap3"
+};
+
+static const struct pbias_reg_info pbias_omap4 = {
+	.enable = BIT(26) | BIT(22),
+	.enable_mask = BIT(26) | BIT(25) | BIT(22),
+	.vmode = BIT(21),
+	.name = "pbias_omap4"
+};
+
+static const struct pbias_reg_info pbias_omap5 = {
+	.enable = BIT(27) | BIT(26),
+	.enable_mask = BIT(27) | BIT(25) | BIT(26),
+	.vmode = BIT(21),
+	.name = "pbias_omap5"
+};
+
+static const struct of_device_id pbias_of_match[] = {
+	{ .compatible = "regulator-pbias-omap3", .data = &pbias_omap3},
+	{ .compatible = "regulator-pbias-omap4", .data = &pbias_omap4},
+	{ .compatible = "regulator-pbias-omap5", .data = &pbias_omap5},
+	{},
+};
+MODULE_DEVICE_TABLE(of, pbias_of_match);
+
+static int pbias_regulator_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *syscon_np;
+	struct pbias_regulator_data *drvdata;
+	const struct of_device_id *id;
+	struct regulator_init_data *initdata;
+	struct regulator_config cfg = { };
+	int ret;
+
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct pbias_regulator_data),
+			       GFP_KERNEL);
+	if (drvdata == NULL) {
+		dev_err(&pdev->dev, "Failed to allocate device data\n");
+		return -ENOMEM;
+	}
+
+	id = of_match_device(of_match_ptr(pbias_of_match), &pdev->dev);
+	if (!id)
+		return -ENODEV;
+
+	drvdata->info = id->data;
+	if (!drvdata->info)
+		return -ENODEV;
+
+	initdata = of_get_regulator_init_data(&pdev->dev, np);
+	if (!initdata)
+		return -EINVAL;
+
+	ret = of_property_read_u32(np, "pbias-reg-offset",
+				   &drvdata->pbias_reg);
+	if (ret) {
+		dev_err(&pdev->dev, "no pbias-reg-offset property set\n");
+		return ret;
+	}
+
+	syscon_np = of_get_parent(np);
+	if (!syscon_np)
+		return -ENODEV;
+
+	drvdata->syscon = syscon_node_to_regmap(syscon_np);
+	of_node_put(syscon_np);
+	if (IS_ERR(drvdata->syscon))
+		return PTR_ERR(drvdata->syscon);
+
+	drvdata->desc.name = drvdata->info->name;
+	drvdata->desc.owner = THIS_MODULE;
+	drvdata->desc.type = REGULATOR_VOLTAGE;
+	drvdata->desc.ops = &pbias_regulator_voltage_ops;
+	drvdata->desc.n_voltages = 2;
+
+	cfg.dev = &pdev->dev;
+	cfg.init_data = initdata;
+	cfg.driver_data = drvdata;
+	cfg.of_node = np;
+
+	drvdata->dev = devm_regulator_register(&pdev->dev, &drvdata->desc,
+									&cfg);
+	if (IS_ERR(drvdata->dev)) {
+		ret = PTR_ERR(drvdata->dev);
+		dev_err(&pdev->dev, "Failed to register regulator: %d\n", ret);
+		goto err_regulator;
+	}
+
+	platform_set_drvdata(pdev, drvdata);
+
+err_regulator:
+	return ret;
+}
+
+static struct platform_driver pbias_regulator_driver = {
+	.probe		= pbias_regulator_probe,
+	.driver		= {
+		.name		= "pbias-regulator",
+		.owner		= THIS_MODULE,
+		.of_match_table = of_match_ptr(pbias_of_match),
+	},
+};
+
+module_platform_driver(pbias_regulator_driver);
+
+MODULE_AUTHOR("Balaji T K <balajitk@ti.com>");
+MODULE_DESCRIPTION("pbias voltage regulator");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:pbias-regulator");
